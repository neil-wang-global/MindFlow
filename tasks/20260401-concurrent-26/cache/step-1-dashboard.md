# Monitoring Dashboard Design — 20260401-concurrent-26

## Overview
Monitoring dashboard specification for distributed systems observability. Designed following Soul constraints: resilience over performance, evidence-based design, operational simplicity, minimal configuration surface with sensible defaults.

## Metrics

### Service Health
| Metric | Description | Data Source | Unit |
|--------|-------------|-------------|------|
| Request latency p50 | Median request latency | Service instrumentation (histogram) | ms |
| Request latency p95 | 95th percentile latency | Service instrumentation (histogram) | ms |
| Request latency p99 | 99th percentile latency | Service instrumentation (histogram) | ms |
| Error rate | Ratio of 5xx responses to total requests | HTTP metrics | % |
| Availability | Uptime ratio over rolling window | Health check probes | % |

### Traffic
| Metric | Description | Data Source | Unit |
|--------|-------------|-------------|------|
| Requests per second | Throughput per service | Load balancer / service metrics | req/s |
| Active connections | Current open connections | Connection pool metrics | count |
| Queue depth | Pending requests in queue | Message broker / queue metrics | count |

### Resource Utilization (Saturation)
| Metric | Description | Data Source | Unit |
|--------|-------------|-------------|------|
| CPU utilization | CPU usage percentage | Node exporter / container metrics | % |
| Memory utilization | Memory usage percentage | Node exporter / container metrics | % |
| Disk I/O | Read/write throughput | Node exporter | MB/s |
| Network I/O | Inbound/outbound bandwidth | Node exporter | MB/s |

### Circuit Breaker State
| Metric | Description | Data Source | Unit |
|--------|-------------|-------------|------|
| Circuit state | Current state (closed/open/half-open) | Circuit breaker instrumentation | enum |
| Failure count | Failures in current window | Circuit breaker instrumentation | count |
| State transitions | State change events | Circuit breaker instrumentation | event/min |

## Layout Specification

### Row 1: Service Health Overview
- Panel 1: Availability gauge (per-service, color-coded green/yellow/red)
- Panel 2: Error rate time series (stacked by service)
- Panel 3: Active alerts summary table

### Row 2: Latency Distribution
- Panel 1: Latency heatmap (request duration distribution over time)
- Panel 2: p50/p95/p99 time series (overlaid)
- Panel 3: Latency SLO compliance gauge

### Row 3: Traffic and Throughput
- Panel 1: Requests per second (per-service time series)
- Panel 2: Active connections gauge
- Panel 3: Queue depth time series with saturation threshold line

### Row 4: Resource Utilization
- Panel 1: CPU utilization (per-node time series)
- Panel 2: Memory utilization (per-node time series)
- Panel 3: Disk and Network I/O (combined panel)

### Row 5: Circuit Breaker Status
- Panel 1: Circuit breaker state timeline (state-over-time per service)
- Panel 2: Failure count rate (per circuit)
- Panel 3: State transition event log

## Data Source Mapping
- Service instrumentation: Prometheus-compatible metrics endpoint
- Node metrics: Node Exporter / cAdvisor
- Load balancer metrics: Ingress controller metrics
- Circuit breaker metrics: Application-level instrumentation (Resilience4j / custom)
- Health probes: Kubernetes liveness/readiness endpoints

## Alerting Thresholds

| Alert | Condition | Severity | SLO Target |
|-------|-----------|----------|------------|
| High error rate | error_rate > 1% for 5m | critical | 99% success rate |
| Latency SLO breach | p99_latency > 500ms for 5m | warning | p99 < 500ms |
| Latency SLO critical | p99_latency > 1000ms for 2m | critical | p99 < 500ms |
| High CPU | cpu_utilization > 80% for 10m | warning | < 80% sustained |
| Critical CPU | cpu_utilization > 95% for 5m | critical | < 95% peak |
| Circuit breaker open | circuit_state = open | critical | All circuits closed |
| Queue saturation | queue_depth > 1000 for 5m | warning | < 1000 sustained |

## Refresh and Retention
- Dashboard auto-refresh: 30 seconds
- Metric retention: 15 days at full resolution, 90 days downsampled
- Alert evaluation interval: 15 seconds
