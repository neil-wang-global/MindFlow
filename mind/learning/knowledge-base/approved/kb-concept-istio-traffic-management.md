# Knowledge Base Entry

## Type
- concept

## Summary
- Istio's traffic management model uses Envoy sidecar proxies as the data plane, proxying all mesh traffic through Envoy. This enables service-level traffic control (routing, load balancing, circuit breaking, retries, timeouts) without application code changes. Traffic policies are configured via Istio CRDs (VirtualService, DestinationRule, Gateway, Sidecar) which the control plane distributes to Envoy proxies.

## Source Lineage
- Task ID: 20260401-concurrent-12
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-12.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-12-istio-traffic-management.md
- Review File: mind/learning/reviews/review-20260401-concurrent-12-istio-traffic-management.md
- Original Source Anchor: tasks/20260401-concurrent-12/acquire/raw-sources/src-002-istio-traffic-management.md
- Original Source URL: https://istio.io/latest/docs/concepts/traffic-management/

## Key Evidence
> "Istio's traffic management model relies on the Envoy proxies that are deployed along with your services. All traffic that your mesh services send and receive (data plane traffic) is proxied through Envoy, making it easy to direct and control traffic around your mesh without making any changes to your services."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-12-istio-traffic-management.md

## Applicability
- Applies to: Istio-based service mesh deployments; Kubernetes environments using Istio for traffic management; microservice architectures requiring declarative traffic policies (canary deployments, A/B testing, circuit breaking)
- Does not apply to: service meshes not using Istio/Envoy (e.g., AWS App Mesh with custom proxies); environments where Istio CRD overhead is unacceptable; simple deployments without multi-version routing or advanced traffic control needs

## Notes
- Grounded in official Istio project documentation (istio.io)
