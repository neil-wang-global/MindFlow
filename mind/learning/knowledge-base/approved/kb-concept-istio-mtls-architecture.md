# Knowledge Base Entry

## Type
- concept

## Summary
- Istio implements mTLS transparently via Envoy sidecar proxies acting as Policy Enforcement Points (PEPs). The mTLS flow involves: client-side Envoy intercepting outbound traffic, performing a mutual TLS handshake with the server-side Envoy (including secure naming verification of the server's service account), establishing the encrypted connection, and forwarding authorized traffic to the backend. Certificates are provisioned automatically via istiod CA and distributed to Envoy via the Secret Discovery Service (SDS) API, with automated rotation. PeerAuthentication policies (PERMISSIVE, STRICT, DISABLE) control mTLS enforcement per namespace or workload.

## Source Lineage
- Task ID: 20260401-concurrent-12
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-12.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-12-istio-mtls-architecture.md
- Review File: mind/learning/reviews/review-20260401-concurrent-12-istio-mtls-architecture.md
- Original Source Anchor: tasks/20260401-concurrent-12/acquire/raw-sources/src-003-istio-security-mtls.md
- Original Source URL: https://istio.io/latest/docs/concepts/security

## Key Evidence
> "Mutual TLS authentication: Istio tunnels service-to-service communication through the client- and server-side PEPs (Envoy proxies). When a workload sends a request to another workload using mutual TLS authentication: Istio re-routes the outbound traffic from a client to the client's local sidecar Envoy. The client side Envoy starts a mutual TLS handshake with the server side Envoy. During the handshake, the client side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service. The client side Envoy and the server side Envoy establish a mutual TLS connection, and Istio forwards the traffic from the client side Envoy to the server side Envoy. The server side Envoy authorizes the request. If authorized, it forwards the traffic to the backend service through local TCP connections."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-12-istio-mtls-architecture.md

## Applicability
- Applies to: Istio-based service mesh deployments requiring encrypted service-to-service communication; zero-trust network architectures where all traffic must be mutually authenticated; Kubernetes environments using Istio for security policy enforcement
- Does not apply to: environments not using Istio (Envoy alone does not provide the automated certificate provisioning described here); services that cannot tolerate the latency of TLS handshake overhead; environments where plaintext internal traffic is acceptable and mTLS overhead is undesirable

## Notes
- Grounded in official Istio project documentation (istio.io)
- Complements kb-concept-envoy-adaptive-concurrency.md and kb-concept-circuit-breaker-states.md for a comprehensive service mesh resilience and security picture
