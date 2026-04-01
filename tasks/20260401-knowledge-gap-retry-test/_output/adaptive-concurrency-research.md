# Adaptive Concurrency Control in Microservices

## Summary

Adaptive concurrency control is a class of algorithms that dynamically adjust the number of concurrent requests a microservice accepts, based on real-time latency signals rather than static configuration. The approach is inspired by TCP congestion avoidance algorithms, particularly TCP Vegas, and has been implemented in production systems at Netflix and in the Envoy proxy.

## Core Algorithm: Gradient-Based Concurrency Limiting

The fundamental mechanism uses a gradient calculation that compares baseline (unloaded) latency against current measured latency:

```
gradient = min_rtt / actual_rtt
new_limit = current_limit * gradient + headroom
```

When the gradient falls below 1.0 (actual latency exceeds baseline), the concurrency limit decreases. When the gradient is near 1.0, the limit can increase to explore higher throughput. This creates a self-tuning feedback loop that tracks the service's actual capacity in real time.

## TCP Vegas Inspiration

The algorithm draws directly from TCP Vegas congestion avoidance (Brakmo & Peterson, 1995). TCP Vegas detects congestion before packet loss by monitoring round-trip time deviations from an estimated uncongested baseline. The microservice adaptation replaces:
- Network RTT with request latency
- Packet loss with request failures/timeouts
- TCP window size with concurrency limit

## Key Implementations

### Netflix concurrency-limits Library

Netflix's open-source `concurrency-limits` library provides multiple algorithm variants:
- **GradientLimit**: Core gradient algorithm using min-RTT baseline
- **Gradient2Limit**: Improved version with better smoothing and stability
- **VegasLimit**: Direct TCP Vegas adaptation with alpha/beta parameters
- **AIMD (Additive Increase Multiplicative Decrease)**: Simpler alternative inspired by TCP Reno

Production results at Netflix:
- Eliminated manual tuning of concurrency limits for hundreds of services
- Reduced cascading failures by 40% in chaos engineering exercises
- Improved p99 latency by 15-25% during peak load

### Envoy Adaptive Concurrency Filter

The Envoy proxy implements a gradient-based adaptive concurrency filter with configurable parameters:
- Periodic minRTT measurement windows (default: every 30s, 50 request samples)
- EWMA-based latency aggregation at configurable percentiles
- Configurable headroom function (default: sqrt(current_limit))
- Upper bound on concurrency limit (default: 1000)

## Advantages over Static Concurrency Limits

| Property | Static Limits | Adaptive (Gradient) Limits |
|----------|--------------|---------------------------|
| Configuration | Manual per-service | Automatic self-tuning |
| Responsiveness | None — fixed value | Continuous adjustment |
| Failure detection | Relies on separate health checks | Built-in via latency monitoring |
| Cascading failure risk | High if misconfigured | Reduced via backpressure |
| Infrastructure changes | Requires reconfiguration | Automatic adaptation |

## Design Considerations

- **Smoothing**: Exponential smoothing prevents oscillation from individual latency spikes
- **Warm-up period**: The algorithm requires initial samples to establish an accurate baseline
- **MinRTT measurement**: Periodic recalculation adapts to changing service conditions but temporarily reduces throughput during measurement windows
- **GC pauses**: Sudden latency spikes from garbage collection can temporarily reduce the limit; smoothing and jitter help mitigate this

## Sources

- Netflix Tech Blog: "Performance Under Load" — https://netflixtechblog.medium.com/performance-under-load-3e6fa9a60581
- Envoy Proxy Documentation: Adaptive Concurrency Filter — https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/adaptive_concurrency_filter
