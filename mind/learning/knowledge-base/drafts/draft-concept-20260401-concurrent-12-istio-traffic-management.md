# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-12

## Summary
- Istio's traffic management uses Envoy sidecar proxies as the data plane, proxying all mesh traffic through Envoy to enable service-level traffic control without application code changes.

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-12.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-12/acquire/raw-sources/src-002-istio-traffic-management.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-12/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Istio's traffic management model relies on the Envoy proxies that are deployed along with your services. All traffic that your mesh services send and receive (data plane traffic) is proxied through Envoy, making it easy to direct and control traffic around your mesh without making any changes to your services."

## Candidate Conclusion
- Istio's traffic management model uses Envoy sidecar proxies as the data plane, proxying all mesh traffic through Envoy. This enables service-level traffic control (routing, load balancing, circuit breaking, retries, timeouts) without application code changes. Traffic policies are configured via Istio CRDs (VirtualService, DestinationRule, Gateway, Sidecar) which the control plane distributes to Envoy proxies.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-12-istio-traffic-management.md

## Notes
- none
