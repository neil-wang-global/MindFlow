# Acquire Search Log

## Task ID
- 20260401-fix-val-04

## ACQ-001: Envoy telemetry collection and export mechanisms

### Trigger
- step-triggered: Step 2

### Knowledge Gap or Problem
- The approved knowledge base lacks entries on how Envoy proxies collect and export telemetry data (access logs, metrics, distributed traces) in an Istio service mesh. Existing entries cover Envoy sidecar architecture and Istio traffic management but not the observability/telemetry pipeline.

### Search Queries

#### Query 1
- **Query String**: Envoy proxy observability access logs metrics distributed tracing official documentation
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/observability | Official Envoy documentation overview of observability architecture |
| 2 | https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/statistics | Official Envoy documentation on statistics/metrics system |
| 3 | https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/tracing | Official Envoy documentation on distributed tracing |

#### Query 2
- **Query String**: Istio telemetry Envoy proxy metrics collection export configuration
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://istio.io/latest/docs/concepts/observability/ | Official Istio documentation on observability concepts |
| 2 | https://istio.io/latest/docs/tasks/observability/metrics/ | Official Istio documentation on metrics configuration |

### Fetch Plan
- https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/statistics — Envoy stats/metrics architecture
- https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/tracing — Envoy distributed tracing architecture
- https://istio.io/latest/docs/concepts/observability/ — Istio observability concepts (covers how Istio uses Envoy telemetry)

### Notes
- Focused on 3 URLs to cover the two main knowledge entry targets: (1) Envoy metrics/stats system and (2) Envoy distributed tracing in Istio
- The Envoy access logging page was deprioritized in favor of the stats and tracing pages since the observability overview already links to it
