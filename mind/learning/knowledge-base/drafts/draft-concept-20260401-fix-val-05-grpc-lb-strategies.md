# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-05

## Summary
- gRPC's HTTP/2 multiplexing over persistent TCP connections defeats Kubernetes L4 load balancing; three solutions: client-side balancing via headless services/DNS, xDS-based proxyless gRPC, and proxy-based L7 balancing via service mesh sidecars

## From Task Learning
- mind/learning/task-learning/tl-20260401-fix-val-05.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-fix-val-05/acquire/raw-sources/src-001-k8s-grpc-lb-blog.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-fix-val-05/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "However, gRPC also breaks the standard connection-level load balancing, including what's provided by Kubernetes. This is because gRPC is built on HTTP/2, and HTTP/2 is designed to have a single long-lived TCP connection, across which all requests are multiplexed—meaning multiple requests can be active on the same connection at any point in time. Normally, this is great, as it reduces the overhead of connection management. However, it also means that (as you might imagine) connection-level balancing isn't very useful. Once the connection is established, there's no more balancing to be done. All requests will get pinned to a single destination pod."

## Candidate Conclusion
- gRPC's use of HTTP/2 multiplexing over persistent TCP connections defeats Kubernetes default L4 (connection-level) load balancing because kube-proxy selects a backend per TCP connection, causing all multiplexed RPCs to pin to a single pod. Three solution approaches exist: (1) client-side load balancing where the gRPC client maintains a pool of backend connections and distributes RPCs using policies like round_robin, typically via headless services that expose individual pod IPs through DNS A records; (2) xDS-based proxyless gRPC where a control plane pushes endpoint configuration to gRPC clients via the xDS protocol, enabling dynamic client-side balancing without a proxy; (3) proxy-based L7 load balancing where an HTTP/2-aware proxy (Envoy, Linkerd) intercepts traffic and distributes individual RPCs at the request/stream level, transparent to the application. The proxy approach (typically via service mesh sidecar) is the most common production solution due to zero application code changes and rich feature set (retries, circuit breaking, mTLS), while client-side approaches offer lower latency by eliminating the proxy hop.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-fix-val-05-grpc-lb-strategies.md

## Notes
- none
