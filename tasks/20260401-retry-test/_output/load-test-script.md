# Load Testing Script -- k6 Configuration

## Overview
This load testing script validates system resilience under stress using the k6 framework. It targets two critical API endpoints with configurable concurrency, ramp-up strategy, and explicit pass/fail thresholds.

## Target Endpoints

### Endpoint 1: Health Check API
- URL: `${BASE_URL}/api/v1/health`
- Method: GET
- Purpose: Validate baseline availability under load
- Expected Response: 200 OK

### Endpoint 2: Order Processing API
- URL: `${BASE_URL}/api/v1/orders`
- Method: POST
- Purpose: Validate transactional throughput under concurrent write pressure
- Payload: `{"item_id": "test-001", "quantity": 1}`
- Expected Response: 201 Created

## Concurrency Configuration

| Parameter | Value |
|-----------|-------|
| Initial Virtual Users | 10 |
| Peak Virtual Users | 200 |
| Ramp-Up Strategy | Step-based (4 stages) |
| Total Test Duration | 10 minutes |

## Ramp-Up Strategy

```
Stage 1: 0 -> 50 VUs over 2 minutes    (warm-up)
Stage 2: 50 VUs sustained for 3 minutes (steady state low)
Stage 3: 50 -> 200 VUs over 2 minutes   (ramp to peak)
Stage 4: 200 VUs sustained for 3 minutes (steady state peak)
```

## k6 Script

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 50 },
    { duration: '3m', target: 50 },
    { duration: '2m', target: 200 },
    { duration: '3m', target: 200 },
  ],
  thresholds: {
    http_req_duration: ['p(95) < 300', 'p(99) < 500'],
    http_req_failed: ['rate < 0.01'],
    http_reqs: ['rate > 100'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8080';

export default function () {
  // Health check endpoint
  const healthRes = http.get(`${BASE_URL}/api/v1/health`);
  check(healthRes, {
    'health status is 200': (r) => r.status === 200,
    'health response time < 200ms': (r) => r.timings.duration < 200,
  });

  // Order processing endpoint
  const orderPayload = JSON.stringify({
    item_id: 'test-001',
    quantity: 1,
  });
  const orderParams = {
    headers: { 'Content-Type': 'application/json' },
  };
  const orderRes = http.post(
    `${BASE_URL}/api/v1/orders`,
    orderPayload,
    orderParams
  );
  check(orderRes, {
    'order status is 201': (r) => r.status === 201,
    'order response time < 500ms': (r) => r.timings.duration < 500,
  });

  sleep(1);
}
```

## Pass/Fail Thresholds

| Metric | Threshold | Action on Breach |
|--------|-----------|-----------------|
| p95 Response Time | < 300ms | FAIL -- investigate latency bottleneck |
| p99 Response Time | < 500ms | FAIL -- investigate tail latency |
| Error Rate | < 1% | FAIL -- investigate error source |
| Request Rate | > 100 req/s at peak | WARN -- capacity may be insufficient |

## Execution Instructions

```bash
# Basic run
k6 run --env BASE_URL=http://target-service:8080 load-test.js

# With output to InfluxDB for Grafana dashboards
k6 run --env BASE_URL=http://target-service:8080 \
  --out influxdb=http://localhost:8086/k6 load-test.js

# With summary export
k6 run --env BASE_URL=http://target-service:8080 \
  --summary-export=results.json load-test.js
```

## Notes
- The BASE_URL is parameterized via environment variable for environment portability
- Sleep of 1 second between iterations simulates realistic user pacing
- Thresholds use k6 native threshold syntax (numeric milliseconds, not string suffixes)
- First attempt failed due to invalid threshold syntax; corrected in this version
