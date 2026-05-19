# Knowledge Base Entry

## Type
- concept

## Summary
- Istio implements a two-tier metrics architecture built on Envoy sidecar proxies: (1) proxy-level metrics at Envoy resource granularity (listeners, clusters) providing infrastructure-level visibility, and (2) service-level metrics covering the four golden signals (latency, traffic, errors, saturation) exported to Prometheus by default. Istio selectively enables only a subset of Envoy's full statistics output to balance observability depth against metrics backend overhead and CPU cost, with operators able to expand collection for targeted debugging.

## Source Lineage
- Task ID: 20260401-fix-val-04
- Task Learning Record: mind/learning/task-learning/tl-20260401-fix-val-04.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-04-istio-metrics-architecture.md
- Review File: mind/learning/reviews/review-20260401-fix-val-04-istio-metrics-architecture.md
- Original Source Anchor: tasks/20260401-fix-val-04/acquire/raw-sources/src-003-istio-observability.md
- Original Source URL: https://istio.io/latest/docs/concepts/observability/

## Key Evidence
> "Istio metrics collection begins with the sidecar proxies (Envoy). Each proxy generates a rich set of metrics about all traffic passing through the proxy (both inbound and outbound). The proxies also provide detailed statistics about the administrative functions of the proxy itself, including configuration and health information.\n\nEnvoy-generated metrics provide monitoring of the mesh at the granularity of Envoy resources (such as listeners and clusters). As a result, understanding the connection between mesh services and Envoy resources is required for monitoring the Envoy metrics.\n\nIstio enables operators to select which of the Envoy metrics are generated and collected at each workload instance. By default, Istio enables only a small subset of the Envoy-generated statistics to avoid overwhelming metrics backends and to reduce the CPU overhead associated with metrics collection. However, operators can easily expand the set of collected proxy metrics when required. This enables targeted debugging of networking behavior, while reducing the overall cost of monitoring across the mesh."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-fix-val-04-istio-metrics-architecture.md

## Applicability
- Applies to: Istio-based service mesh deployments using Envoy sidecar proxies for observability; Kubernetes environments with Istio where Prometheus is the metrics backend; operators configuring Envoy metric collection granularity
- Does not apply to: service meshes not using Istio/Envoy; environments where all Envoy metrics are collected without selective filtering; non-Prometheus metrics backends that do not use Istio's standard metrics export path

## Notes
- Grounded in official Istio project documentation (istio.io)
- Complements kb-concept-envoy-sidecar-architecture.md and kb-concept-istio-traffic-management.md for a comprehensive Istio service mesh picture
- Complements kb-concept-envoy-stats-system.md for understanding Envoy's native statistics types that feed into the two-tier architecture
