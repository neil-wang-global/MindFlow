# Step 1: Metrics Pillar Research

## Task ID
- 20260401-concurrent-25

## Step
- Step 1: Metrics Pillar Research

## ACQ Event
- ACQ-001: completed — 2 sources passed (src-001, src-002)

## Findings

### Prometheus Data Model
Prometheus uses a dimensional data model where every time series is uniquely identified by its metric name and optional key-value pairs called labels. Labels enable filtering and aggregation based on dimensions. This contrasts with hierarchical (dot-separated) naming used by StatsD/Graphite where all context is encoded in the metric name.

### Four Core Metric Types
1. **Counter**: cumulative, monotonically increasing (reset on restart only). Use for requests served, errors counted.
2. **Gauge**: single numerical value that goes up and down. Use for temperature, memory usage, concurrent requests.
3. **Histogram**: samples observations into configurable buckets, provides sum and count. Exposes basename_bucket, basename_sum, basename_count.
4. **Summary**: samples observations, calculates configurable quantiles over sliding time window.

### Dimensional vs Hierarchical
- Dimensional (Prometheus): base name + labels; flexible query-time aggregation via PromQL
- Hierarchical (StatsD/Graphite): dot-separated paths; pre-aggregated at collection; limited post-hoc analysis

## Source References
- src-001: Prometheus metric types documentation
- src-002: Prometheus data model documentation
