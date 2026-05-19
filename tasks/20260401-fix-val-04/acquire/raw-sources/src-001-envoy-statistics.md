# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/statistics

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Envoy project documentation hosted on envoyproxy.io (CNCF project)

## Fetch Status
- success

## Fetch Completeness
- partial
- reason: content retrieved via WebSearch tool content extraction rather than direct WebFetch; WebSearch returns processed/extracted content from the target page rather than the complete raw page

## Original Content

Statistics — envoy documentation

Envoy proxy provides three core observability pillars for monitoring:

**Statistics System**

Envoy emits a large number of statistics depending on how the server is configured. Statistics fall into three categories:

- **Counter** — Unsigned integers that only increase (e.g., total requests). Counters represent monotonically increasing values.
- **Gauge** — Unsigned integers that both increase and decrease (e.g., currently active requests). Gauges represent current state values.
- **Histogram** — Unsigned integers that track value distributions (e.g., request latencies). Histograms capture the distribution of data over time.

These can be exported to stats sinks including:
- StatsD
- Prometheus
- Others (configurable stats sink infrastructure)

**Key Statistics Examples**

HTTP Connection Manager statistics include:
- `downstream_cx_total` (Counter) — Total connections
- `downstream_cx_active` (Gauge) — Active connections
- `downstream_rq_total` (Counter) — Total requests
- `downstream_rq_time` (Histogram) — Request time in milliseconds
- `downstream_rq_active` (Gauge) — Active requests

Additional Envoy-generated statistics at the proxy level:
- `envoy_cluster_upstream_rq_completed`
- `envoy_cluster_upstream_cx_total`
- `envoy_cluster_upstream_cx_connect_fail`
- `envoy_cluster_upstream_cx_active`
- `envoy_cluster_upstream_cx_rx_bytes_total`
- `envoy_cluster_upstream_cx_tx_bytes_total`
- `envoy_cluster_membership_change`
- `envoy_cluster_membership_healthy`
- `envoy_cluster_membership_degraded`
- `envoy_server_memory_allocated`
- `envoy_server_memory_heap_size`
- `envoy_cluster_upstream_cx_none_healthy`

Statistics are organized by Envoy resource categories (listeners, clusters, connection managers).

The statistics documentation page URL is: https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/statistics
The HTTP Connection Manager Stats reference URL is: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/stats
The Listener Stats reference URL is: https://www.envoyproxy.io/docs/envoy/latest/configuration/listeners/stats
The Stats Sinks Configuration API URL is: https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/metrics/v3/stats.proto
