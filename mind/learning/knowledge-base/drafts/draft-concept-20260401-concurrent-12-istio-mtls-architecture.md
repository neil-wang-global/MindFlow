# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-12

## Summary
- Istio implements mTLS transparently via Envoy sidecar proxies acting as Policy Enforcement Points, with automated certificate provisioning via istiod CA and Secret Discovery Service API.

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-12.md
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-12/acquire/raw-sources/src-003-istio-security-mtls.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-12/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Mutual TLS authentication: Istio tunnels service-to-service communication through the client- and server-side PEPs (Envoy proxies). When a workload sends a request to another workload using mutual TLS authentication: Istio re-routes the outbound traffic from a client to the client's local sidecar Envoy. The client side Envoy starts a mutual TLS handshake with the server side Envoy. During the handshake, the client side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service. The client side Envoy and the server side Envoy establish a mutual TLS connection, and Istio forwards the traffic from the client side Envoy to the server side Envoy. The server side Envoy authorizes the request. If authorized, it forwards the traffic to the backend service through local TCP connections."

## Candidate Conclusion
- Istio implements mTLS transparently via Envoy sidecar proxies acting as Policy Enforcement Points (PEPs). The mTLS flow involves: client-side Envoy intercepting outbound traffic, performing a mutual TLS handshake with the server-side Envoy (including secure naming verification of the server's service account), establishing the encrypted connection, and forwarding authorized traffic to the backend. Certificates are provisioned automatically via istiod CA and distributed to Envoy via the Secret Discovery Service (SDS) API, with automated rotation. PeerAuthentication policies (PERMISSIVE, STRICT, DISABLE) control mTLS enforcement per namespace or workload.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-12-istio-mtls-architecture.md

## Notes
- none
