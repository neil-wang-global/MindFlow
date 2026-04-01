# Health Check Endpoint Design

## Task ID
- 20260401-concurrent-07

## Overview

This document specifies a health check endpoint design for a microservice, applying patterns from Kubernetes probe types and the Azure Health Endpoint Monitoring pattern. The design separates liveness (shallow) and readiness (deep) concerns into distinct endpoints with clear failure semantics.

## Endpoint Specification

### /health/live — Liveness Probe (Shallow Check)

**Purpose**: Determine whether the application process is running and not deadlocked.

**Check Type**: Shallow — no external dependency checks.

**What it checks**:
- Application process is responsive (can handle HTTP requests)
- Main event loop / thread pool is not deadlocked
- Application has not entered an unrecoverable error state

**What it does NOT check**:
- Database connectivity
- External service availability
- Cache health
- Any downstream dependency

**Response Format**:
```
HTTP 200 OK
Content-Type: application/json

{
  "status": "UP",
  "timestamp": "2026-04-01T10:00:00Z"
}
```

**Failure Response**:
```
HTTP 503 Service Unavailable
Content-Type: application/json

{
  "status": "DOWN",
  "timestamp": "2026-04-01T10:00:00Z"
}
```

**Rationale**: Per Kubernetes documentation, liveness probes that check external dependencies can cause cascading restarts when a shared dependency (e.g., database) becomes temporarily unavailable. All pods would be killed simultaneously, amplifying the outage. The liveness endpoint must only confirm the process itself is alive.

**Kubernetes Configuration Guidance**:
```yaml
livenessProbe:
  httpGet:
    path: /health/live
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 3
  failureThreshold: 3
  successThreshold: 1
```

### /health/ready — Readiness Probe (Deep Check)

**Purpose**: Determine whether the service is ready to accept and process traffic.

**Check Type**: Deep — checks critical dependencies.

**What it checks**:
- Database connection pool: can obtain a connection and execute a lightweight query (e.g., `SELECT 1`)
- Cache connectivity: can read/write to cache store
- Critical downstream services: can reach required APIs (via cached health status or lightweight ping)
- Application initialization: all startup tasks have completed

**Dependency Classification**:

| Dependency | Criticality | Check Method | Timeout |
|-----------|-------------|-------------|---------|
| Primary database | critical | Connection pool test query | 2s |
| Cache (Redis) | critical | PING command | 1s |
| Message queue | critical | Connection check | 2s |
| External API (payment) | non-critical | Cached status check | 1s |
| External API (analytics) | non-critical | Cached status check | 1s |

**Aggregation Logic**:
- If ANY critical dependency is DOWN: overall status = DOWN (503)
- If all critical dependencies are UP but any non-critical dependency is DOWN: overall status = DEGRADED (200 with degraded flag)
- If all dependencies are UP: overall status = UP (200)

**Response Format** (UP):
```
HTTP 200 OK
Content-Type: application/json

{
  "status": "UP",
  "timestamp": "2026-04-01T10:00:00Z",
  "checks": [
    { "name": "database", "status": "UP", "responseTime": "12ms" },
    { "name": "cache", "status": "UP", "responseTime": "3ms" },
    { "name": "message-queue", "status": "UP", "responseTime": "8ms" },
    { "name": "payment-api", "status": "UP", "responseTime": "45ms" },
    { "name": "analytics-api", "status": "UP", "responseTime": "22ms" }
  ]
}
```

**Response Format** (DEGRADED):
```
HTTP 200 OK
Content-Type: application/json

{
  "status": "DEGRADED",
  "timestamp": "2026-04-01T10:00:00Z",
  "checks": [
    { "name": "database", "status": "UP", "responseTime": "12ms" },
    { "name": "cache", "status": "UP", "responseTime": "3ms" },
    { "name": "message-queue", "status": "UP", "responseTime": "8ms" },
    { "name": "payment-api", "status": "UP", "responseTime": "45ms" },
    { "name": "analytics-api", "status": "DOWN", "error": "timeout" }
  ]
}
```

**Failure Response** (DOWN):
```
HTTP 503 Service Unavailable
Content-Type: application/json

{
  "status": "DOWN",
  "timestamp": "2026-04-01T10:00:00Z",
  "checks": [
    { "name": "database", "status": "DOWN", "error": "connection refused" },
    { "name": "cache", "status": "UP", "responseTime": "3ms" },
    { "name": "message-queue", "status": "UP", "responseTime": "8ms" }
  ]
}
```

**Rationale**: Per Azure Architecture Center pattern, readiness checks should verify the service's ability to actually process requests, including dependency availability. The three-tier status model (UP/DEGRADED/DOWN) follows the principle of explicit failure handling — a DEGRADED state signals that non-critical features may be unavailable without taking the service entirely out of rotation.

**Kubernetes Configuration Guidance**:
```yaml
readinessProbe:
  httpGet:
    path: /health/ready
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 1
  successThreshold: 1
```

### /health/startup — Startup Probe

**Purpose**: Determine whether the application has completed its initialization phase.

**Check Type**: Moderate — checks initialization completion only.

**What it checks**:
- Database migrations completed
- Cache warmed (if applicable)
- Configuration loaded
- Thread pools initialized

**Response**: Same format as liveness (UP/DOWN only).

**Kubernetes Configuration Guidance**:
```yaml
startupProbe:
  httpGet:
    path: /health/startup
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 30
  successThreshold: 1
```

**Rationale**: Per Kubernetes documentation, startup probes disable liveness and readiness checks during initialization. This prevents premature kills of slow-starting containers (e.g., those running database migrations).

## Circuit Breaker Integration

Health check endpoints should integrate with the circuit breaker pattern (per kb-concept-circuit-breaker-states.md):

- When a dependency's circuit breaker is in **Open** state, the readiness check should report that dependency as DOWN without attempting the actual check (the circuit breaker already knows the dependency is failing)
- When in **Half-Open** state, the readiness check may report DEGRADED to indicate the dependency is being tested for recovery
- When in **Closed** state, perform the normal dependency check

This integration avoids redundant failure detection and leverages the circuit breaker's existing failure tracking.

## Security Considerations

Per Azure Architecture Center guidance:
- Internal-only access: health check endpoints should not be exposed on public-facing ports
- Two-tier detail: unauthenticated requests get simple UP/DOWN; authenticated internal requests get full dependency detail
- No sensitive data: never expose connection strings, credentials, or internal topology in health check responses

## Performance Considerations

- **Caching**: readiness check results should be cached for 5-10 seconds to prevent overwhelming dependencies with health check queries
- **Timeouts**: all dependency checks must have individual timeouts (see table above) to prevent a hanging dependency from blocking the entire health check
- **Non-blocking**: health check handlers should use async I/O to avoid consuming thread pool resources
- **Total timeout**: the readiness check should have a hard total timeout of 5 seconds, returning partial results if any individual check times out

## Source Attribution

- Liveness/readiness/startup probe semantics: Kubernetes official documentation (src-001, ACQ-001)
- Health endpoint monitoring pattern, dependency health aggregation, caching, security: Microsoft Azure Architecture Center (src-002, ACQ-001)
- Circuit breaker state integration: kb-concept-circuit-breaker-states.md (approved knowledge)
