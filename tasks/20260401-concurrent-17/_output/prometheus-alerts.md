# Prometheus Alerting Rules Configuration

Task: 20260401-concurrent-17

## Overview

This document defines Prometheus alerting rules for distributed systems monitoring. Rules are organized into four core categories aligned with the USE/RED methodology: availability, error rate, latency, and saturation. Thresholds are conservative and data-driven, consistent with a resilience-first operational philosophy.

---

## Rule Group: Service Availability

```yaml
groups:
  - name: service_availability
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
          category: availability
        annotations:
          summary: "Instance {{ $labels.instance }} of job {{ $labels.job }} is down"
          description: "The instance has been unreachable for more than 1 minute. Immediate investigation required to prevent cascading failures."
          runbook_url: "https://runbooks.internal/alerts/instance-down"

      - alert: HealthCheckFailure
        expr: probe_success == 0
        for: 2m
        labels:
          severity: critical
          category: availability
        annotations:
          summary: "Health check failing for {{ $labels.instance }}"
          description: "Blackbox probe has been failing for over 2 minutes. Service may be in a degraded state despite the process being up."

      - alert: TooFewInstances
        expr: count by (job) (up == 1) < 2
        for: 5m
        labels:
          severity: warning
          category: availability
        annotations:
          summary: "Job {{ $labels.job }} has fewer than 2 healthy instances"
          description: "Redundancy is compromised. A single additional failure will cause service outage."
```

---

## Rule Group: Error Rates

```yaml
  - name: error_rates
    rules:
      - alert: HighHTTP5xxRate
        expr: |
          (
            sum by (job) (rate(http_requests_total{status=~"5.."}[5m]))
            /
            sum by (job) (rate(http_requests_total[5m]))
          ) > 0.05
        for: 5m
        labels:
          severity: critical
          category: error_rate
        annotations:
          summary: "HTTP 5xx error rate above 5% for {{ $labels.job }}"
          description: "Server error rate has exceeded 5% for 5 minutes. This indicates a systemic issue rather than transient failures."

      - alert: HighHTTP5xxRateWarning
        expr: |
          (
            sum by (job) (rate(http_requests_total{status=~"5.."}[5m]))
            /
            sum by (job) (rate(http_requests_total[5m]))
          ) > 0.01
        for: 10m
        labels:
          severity: warning
          category: error_rate
        annotations:
          summary: "HTTP 5xx error rate above 1% for {{ $labels.job }}"
          description: "Elevated server error rate sustained for 10 minutes. Investigate for early signs of degradation."

      - alert: HighGRPCErrorRate
        expr: |
          (
            sum by (grpc_service) (rate(grpc_server_handled_total{grpc_code!="OK"}[5m]))
            /
            sum by (grpc_service) (rate(grpc_server_handled_total[5m]))
          ) > 0.05
        for: 5m
        labels:
          severity: critical
          category: error_rate
        annotations:
          summary: "gRPC error rate above 5% for {{ $labels.grpc_service }}"
          description: "Non-OK gRPC response rate has exceeded 5%. Check downstream dependencies and circuit breaker states."

      - alert: CircuitBreakerOpen
        expr: circuit_breaker_state{state="open"} == 1
        for: 0m
        labels:
          severity: warning
          category: error_rate
        annotations:
          summary: "Circuit breaker open for {{ $labels.target_service }}"
          description: "A circuit breaker has tripped to the open state, indicating repeated failures to the downstream service. Traffic is being rejected to prevent cascading failure."
```

---

## Rule Group: Latency

```yaml
  - name: latency
    rules:
      - alert: HighP99Latency
        expr: |
          histogram_quantile(0.99, sum by (job, le) (rate(http_request_duration_seconds_bucket[5m])))
          > 2.0
        for: 5m
        labels:
          severity: critical
          category: latency
        annotations:
          summary: "P99 latency above 2s for {{ $labels.job }}"
          description: "The 99th percentile request latency has exceeded 2 seconds for 5 minutes. This typically indicates resource contention, upstream dependency degradation, or approaching capacity limits."

      - alert: HighP95Latency
        expr: |
          histogram_quantile(0.95, sum by (job, le) (rate(http_request_duration_seconds_bucket[5m])))
          > 1.0
        for: 10m
        labels:
          severity: warning
          category: latency
        annotations:
          summary: "P95 latency above 1s for {{ $labels.job }}"
          description: "The 95th percentile request latency has sustained above 1 second for 10 minutes. Early indicator of performance degradation."

      - alert: LatencyAnomalyDetection
        expr: |
          histogram_quantile(0.50, sum by (job, le) (rate(http_request_duration_seconds_bucket[5m])))
          >
          2 * histogram_quantile(0.50, sum by (job, le) (rate(http_request_duration_seconds_bucket[1h])))
        for: 10m
        labels:
          severity: warning
          category: latency
        annotations:
          summary: "Median latency anomaly detected for {{ $labels.job }}"
          description: "Current median latency is more than 2x the hourly baseline. This may indicate a sudden change in traffic patterns or dependency behavior."

      - alert: UpstreamTimeoutRate
        expr: |
          (
            sum by (job) (rate(http_requests_total{status="504"}[5m]))
            /
            sum by (job) (rate(http_requests_total[5m]))
          ) > 0.02
        for: 5m
        labels:
          severity: critical
          category: latency
        annotations:
          summary: "Upstream timeout rate above 2% for {{ $labels.job }}"
          description: "Gateway timeouts indicate downstream services are not responding within timeout windows. Check circuit breaker states and downstream health."
```

---

## Rule Group: Resource Saturation

```yaml
  - name: resource_saturation
    rules:
      - alert: HighCPUUsage
        expr: |
          (1 - avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])))
          > 0.85
        for: 10m
        labels:
          severity: warning
          category: saturation
        annotations:
          summary: "CPU usage above 85% on {{ $labels.instance }}"
          description: "Sustained high CPU usage reduces headroom for traffic spikes and increases latency tail. Consider scaling or load shedding."

      - alert: CriticalCPUUsage
        expr: |
          (1 - avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])))
          > 0.95
        for: 5m
        labels:
          severity: critical
          category: saturation
        annotations:
          summary: "CPU usage above 95% on {{ $labels.instance }}"
          description: "Near-total CPU saturation. Service is likely experiencing degraded performance and increased error rates."

      - alert: HighMemoryUsage
        expr: |
          (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes))
          > 0.85
        for: 10m
        labels:
          severity: warning
          category: saturation
        annotations:
          summary: "Memory usage above 85% on {{ $labels.instance }}"
          description: "High memory utilization increases risk of OOM kills. Monitor for memory leaks or resize workload."

      - alert: DiskSpaceLow
        expr: |
          (1 - (node_filesystem_avail_bytes{fstype!~"tmpfs|fuse.*"} / node_filesystem_size_bytes{fstype!~"tmpfs|fuse.*"}))
          > 0.85
        for: 15m
        labels:
          severity: warning
          category: saturation
        annotations:
          summary: "Disk usage above 85% on {{ $labels.instance }} mount {{ $labels.mountpoint }}"
          description: "Disk space is running low. Services may fail to write logs, data, or temporary files."

      - alert: DiskSpaceCritical
        expr: |
          (1 - (node_filesystem_avail_bytes{fstype!~"tmpfs|fuse.*"} / node_filesystem_size_bytes{fstype!~"tmpfs|fuse.*"}))
          > 0.95
        for: 5m
        labels:
          severity: critical
          category: saturation
        annotations:
          summary: "Disk usage above 95% on {{ $labels.instance }} mount {{ $labels.mountpoint }}"
          description: "Disk is nearly full. Immediate action required to prevent service failure."

      - alert: HighOpenConnections
        expr: |
          sum by (instance) (node_netstat_Tcp_CurrEstab)
          > 10000
        for: 5m
        labels:
          severity: warning
          category: saturation
        annotations:
          summary: "Over 10,000 established TCP connections on {{ $labels.instance }}"
          description: "High connection count may indicate connection leaks, missing timeouts, or insufficient connection pooling."

      - alert: FileDescriptorExhaustion
        expr: |
          process_open_fds / process_max_fds > 0.80
        for: 5m
        labels:
          severity: warning
          category: saturation
        annotations:
          summary: "File descriptor usage above 80% for {{ $labels.job }} on {{ $labels.instance }}"
          description: "Approaching file descriptor limits. This can cause connection refusals and service unavailability."
```

---

## Design Notes

- **Conservative thresholds**: All thresholds use conservative values with sustained `for` durations to minimize false positives while ensuring timely detection of genuine issues
- **Two-tier severity**: Warning alerts provide early detection; critical alerts indicate conditions requiring immediate response
- **Resilience-oriented**: Rules specifically monitor circuit breaker states, timeout rates, and cascading failure indicators
- **Data-driven**: Percentile-based latency rules (p95, p99) provide nuanced performance visibility over simple averages
- **Explicit failure handling**: Every rule includes descriptive annotations with context for the responder
