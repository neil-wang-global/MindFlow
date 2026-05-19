# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-04

## Summary
- Istio implements a two-tier metrics architecture: proxy-level metrics at Envoy resource granularity and service-level metrics covering the four golden signals, with selective metric enablement to balance observability against overhead

## From Task Learning
- mind/learning/task-learning/tl-20260401-fix-val-04.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-fix-val-04/acquire/raw-sources/src-003-istio-observability.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-fix-val-04/acquire/verification-report.md §ACQ-001`
  - Verification Status: passed

## Original Excerpt
> "Istio metrics collection begins with the sidecar proxies (Envoy). Each proxy generates a rich set of metrics about all traffic passing through the proxy (both inbound and outbound). The proxies also provide detailed statistics about the administrative functions of the proxy itself, including configuration and health information.\n\nEnvoy-generated metrics provide monitoring of the mesh at the granularity of Envoy resources (such as listeners and clusters). As a result, understanding the connection between mesh services and Envoy resources is required for monitoring the Envoy metrics.\n\nIstio enables operators to select which of the Envoy metrics are generated and collected at each workload instance. By default, Istio enables only a small subset of the Envoy-generated statistics to avoid overwhelming metrics backends and to reduce the CPU overhead associated with metrics collection. However, operators can easily expand the set of collected proxy metrics when required. This enables targeted debugging of networking behavior, while reducing the overall cost of monitoring across the mesh."

## Candidate Conclusion
- Istio implements a two-tier metrics architecture built on Envoy sidecar proxies: (1) proxy-level metrics at Envoy resource granularity (listeners, clusters) providing infrastructure-level visibility, and (2) service-level metrics covering the four golden signals (latency, traffic, errors, saturation) exported to Prometheus by default. Istio selectively enables only a subset of Envoy's full statistics output to balance observability depth against metrics backend overhead and CPU cost, with operators able to expand collection for targeted debugging.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-fix-val-04-istio-metrics-architecture.md

## Notes
- Source content retrieved via WebSearch content extraction (partial fetch completeness); verified as substantially-matched by independent subagent
