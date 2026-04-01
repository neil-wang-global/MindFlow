# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://prometheus.io/docs/concepts/metric_types/

## Fetch Timestamp
- 2026-04-01T10:00:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Prometheus project documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Prometheus client libraries offer four core metric types. These are currently only differentiated in the client libraries (to enable APIs tailored to the usage of the specific types) and in the wire protocol. The Prometheus server does not yet make use of the type information and flattens all data into untyped time series.

Counter: A counter is a cumulative metric that represents a single monotonically increasing counter whose value can only increase or be reset to zero on restart. For example, you can use a counter to represent the number of requests served, tasks completed, or errors. Do not use a counter to expose a value that can decrease. For example, do not use a counter for the number of currently running processes; instead use a gauge.

Gauge: A gauge is a metric that represents a single numerical value that can arbitrarily go up and down. Gauges are typically used for measured values like temperatures or current memory usage, but also "counts" that can go up and down, like the number of concurrent requests.

Histogram: A histogram samples observations (usually things like request durations or response sizes) and counts them in configurable buckets. It also provides a sum of all observed values. A histogram with a base metric name of basename exposes multiple time series during a scrape: cumulative counters for the observation buckets (basename_bucket with le label), the total sum of all observed values (basename_sum), and the count of events (basename_count).

Summary: Similar to a histogram, a summary samples observations (usually things like request durations or response sizes). While it also provides a total count of observations and a sum of all observed values, it calculates configurable quantiles over a sliding time window.
