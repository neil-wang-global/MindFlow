# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/adaptive_concurrency_filter

## Fetch Timestamp
- 2026-04-01T10:20:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Envoy proxy documentation; Envoy is a CNCF graduated project widely used in production service meshes

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Adaptive Concurrency Filter

The adaptive concurrency filter dynamically adjusts the allowed number of outstanding requests to a service based on sampled latencies from prior requests. The filter is an implementation of the gradient-based concurrency limiting algorithm, similar to the approach described by Netflix's concurrency-limits library.

## Overview

Unlike static concurrency limits that require manual configuration, the adaptive concurrency filter automatically determines the optimal concurrency limit by monitoring request latency. When latency increases (indicating the service is approaching saturation), the filter reduces the concurrency limit. When latency is stable at the baseline, the filter gradually increases the limit to explore higher throughput.

## Algorithm

The filter uses a gradient-based algorithm to adjust the concurrency limit:

### Minimum RTT Measurement

The filter periodically measures the minimum round-trip time (minRTT) by entering a measurement window. During this window:

- The concurrency limit is temporarily reduced to a small value (the `min_concurrency` setting, default 3)
- Latency samples are collected to estimate the service's unloaded latency
- The window duration is configurable via `min_rtt_calc_params`

The minRTT is recalculated at a configurable interval (`min_rtt_calc_params.interval`, default 30 seconds) to adapt to changing service conditions.

### Gradient Calculation

After each request, the filter computes a gradient:

```
gradient = min_rtt / sample_rtt
```

Where:
- `min_rtt` is the measured minimum latency (baseline)
- `sample_rtt` is the exponentially weighted moving average (EWMA) of recent request latencies

### Limit Adjustment

The new concurrency limit is calculated as:

```
new_limit = current_limit * gradient + headroom
```

Where:
- `gradient` adjusts the limit based on latency deviation from baseline
- `headroom` is a configurable parameter (default: sqrt(current_limit)) that allows the limit to grow when latency is near baseline

### Configuration Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `sample_aggregate_percentile` | p50 | Percentile used for latency aggregation |
| `concurrency_limit_params.max_concurrency_limit` | 1000 | Upper bound on the concurrency limit |
| `concurrency_limit_params.concurrency_update_interval` | 500ms | How often the limit is recalculated |
| `min_rtt_calc_params.interval` | 30s | How often minRTT is remeasured |
| `min_rtt_calc_params.request_count` | 50 | Number of requests to sample for minRTT |
| `min_rtt_calc_params.jitter` | 15% | Random jitter applied to measurement interval |
| `min_rtt_calc_params.min_concurrency` | 3 | Concurrency limit during minRTT measurement |

## Request Lifecycle

1. A request arrives at the filter.
2. The filter checks if the current number of outstanding requests is below the dynamically calculated concurrency limit.
3. If below the limit, the request is forwarded and its latency is recorded upon completion.
4. If at or above the limit, the request is rejected with a 503 Service Unavailable response.
5. The recorded latency feeds into the gradient calculation for future limit adjustments.

## Comparison with Static Concurrency Limits

The adaptive approach offers several advantages over Envoy's static `max_requests` circuit breaker:

- **No manual tuning**: The limit self-adjusts based on observed latency.
- **Responsive to conditions**: Handles varying load patterns, deployment changes, and infrastructure shifts automatically.
- **Backpressure**: Naturally reduces load on services experiencing latency increases.

However, the adaptive filter adds complexity:
- The minRTT measurement window temporarily reduces throughput.
- The algorithm requires a warm-up period to establish accurate baselines.
- Sudden latency spikes (e.g., GC pauses) can temporarily reduce the limit.

## Usage Example

```yaml
http_filters:
- name: envoy.filters.http.adaptive_concurrency
  typed_config:
    "@type": type.googleapis.com/envoy.extensions.filters.http.adaptive_concurrency.v3.AdaptiveConcurrency
    gradient_controller_config:
      sample_aggregate_percentile:
        value: 50
      concurrency_limit_params:
        max_concurrency_limit: 1000
        concurrency_update_interval: 0.5s
      min_rtt_calc_params:
        interval: 30s
        request_count: 50
        jitter:
          value: 15
        min_concurrency: 3
```

## See Also

- Netflix concurrency-limits library: https://github.com/Netflix/concurrency-limits
- TCP Vegas congestion avoidance: Brakmo & Peterson, 1995
