# Observability Pillars Research

## Task ID
- 20260401-concurrent-25

## Overview
Research findings on the three pillars of observability: metrics, distributed tracing, and structured logging. Each pillar was researched from primary sources with verified external knowledge acquisition.

## Pillar 1: Metrics

### Prometheus Data Model
Prometheus uses a dimensional data model where every time series is uniquely identified by its metric name and optional key-value label pairs. Labels enable Prometheus's dimensional data model: any given combination of labels for the same metric name identifies a particular dimensional instantiation. The query language (PromQL) allows filtering and aggregation based on these dimensions.

### Four Core Metric Types
1. **Counter**: cumulative, monotonically increasing (resets to zero on restart). Use for requests served, tasks completed, errors.
2. **Gauge**: single numerical value that arbitrarily goes up and down. Use for temperatures, memory usage, concurrent requests.
3. **Histogram**: samples observations into configurable buckets; exposes cumulative counters (basename_bucket), total sum (basename_sum), and event count (basename_count).
4. **Summary**: samples observations and calculates configurable quantiles over a sliding time window.

### Dimensional vs Hierarchical Metrics
- **Dimensional** (Prometheus, OpenTelemetry): base name + key-value labels; query-time aggregation; suited for dynamic infrastructure
- **Hierarchical** (StatsD, Graphite): dot-separated paths encoding all context in the name; pre-aggregated at collection; limited post-hoc analysis

Sources: src-001 (Prometheus metric types), src-002 (Prometheus data model)

## Pillar 2: Distributed Tracing

### W3C Trace Context (W3C Recommendation)
Standardized HTTP headers for propagating distributed tracing context across services:
- **traceparent**: `{version}-{trace-id}-{parent-id}-{trace-flags}`
  - version: 8-bit (currently `00`)
  - trace-id: 128-bit (32 hex chars) — unique identifier for the entire distributed trace
  - parent-id: 64-bit (16 hex chars) — identifier for the current span
  - trace-flags: 8-bit — sampling flag
- **tracestate**: vendor-specific key-value pairs, must be passed through unmodified by systems that do not understand it

### Sampling Strategies
- **Head-based**: decision at trace start (root span). OpenTelemetry provides TraceIdRatioBased (deterministic based on trace ID) and ParentBased (follows parent decision) samplers. Simple but blind to outcomes.
- **Tail-based**: decision after all spans collected. OpenTelemetry Collector's tail sampling processor supports latency-based, error-based, probabilistic, status-code-based, and attribute-based policies. Context-aware but higher resource overhead.

Sources: src-003 (W3C Trace Context), src-004 (OpenTelemetry sampling)

## Pillar 3: Structured Logging

### Elastic Common Schema (ECS)
Open source specification for common event data fields in Elasticsearch:
- Core: @timestamp, message, log.level, log.logger, ecs.version
- Event categorization: event.category, event.kind, event.outcome
- Host context: host.name, host.hostname, host.ip
- Service context: service.name, service.version
- Error details: error.message, error.stack_trace
- Tracing correlation: trace.id, span.id, transaction.id
- Uses dot-notated snake_case field naming convention

### RFC 5424 Syslog Severity Levels
Eight severity levels (lower number = higher severity):
| Code | Severity | Description |
|------|----------|-------------|
| 0 | Emergency | System is unusable |
| 1 | Alert | Action must be taken immediately |
| 2 | Critical | Critical conditions |
| 3 | Error | Error conditions |
| 4 | Warning | Warning conditions |
| 5 | Notice | Normal but significant condition |
| 6 | Informational | Informational messages |
| 7 | Debug | Debug-level messages |

Priority = Facility * 8 + Severity. RFC 5424 also supports STRUCTURED-DATA elements for machine-parseable key-value metadata.

Sources: src-005 (ECS field reference), src-006 (RFC 5424)
