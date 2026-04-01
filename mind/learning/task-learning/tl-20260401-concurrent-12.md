# Task Learning Record

## Task ID
- 20260401-concurrent-12

## Task Summary
- Designed an Envoy-based service mesh configuration covering sidecar proxy deployment, traffic management, and mTLS
- Acquired external knowledge about Envoy proxy architecture, Istio traffic management, and Istio mTLS security from official documentation
- Produced _output/service-mesh-config.md as the primary deliverable

## External Acquisition

### ACQ-001: Envoy sidecar proxy patterns, traffic management, and mTLS

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-12/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-001, src-002, src-003

## Candidate Knowledge

### [KDC-001] Envoy sidecar proxy architecture — out-of-process transparent mesh

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-12/acquire/raw-sources/src-001-envoy-what-is-envoy.md
- **Verification Status**: passed
- **Original Excerpt**: > "Out of process architecture: Envoy is a self contained process that is designed to run alongside every application server. All of the Envoys form a transparent communication mesh in which each application sends and receives messages to and from localhost and is unaware of the network topology."
- **Derived Conclusion**: Envoy's sidecar proxy pattern deploys one Envoy instance alongside each application server, forming a transparent communication mesh. Applications interact only with localhost, remaining unaware of network topology. This out-of-process architecture decouples network concerns from application code, enabling language-agnostic service mesh deployment and independent proxy upgrades.

### [KDC-002] Istio traffic management via Envoy sidecar proxies

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-12/acquire/raw-sources/src-002-istio-traffic-management.md
- **Verification Status**: passed
- **Original Excerpt**: > "Istio's traffic management model relies on the Envoy proxies that are deployed along with your services. All traffic that your mesh services send and receive (data plane traffic) is proxied through Envoy, making it easy to direct and control traffic around your mesh without making any changes to your services."
- **Derived Conclusion**: Istio's traffic management model uses Envoy sidecar proxies as the data plane, proxying all mesh traffic through Envoy. This enables service-level traffic control (routing, load balancing, circuit breaking, retries, timeouts) without application code changes. Traffic policies are configured via Istio CRDs (VirtualService, DestinationRule, Gateway, Sidecar) which the control plane distributes to Envoy proxies.

### [KDC-003] Istio mTLS architecture with Envoy sidecar proxies

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-12/acquire/raw-sources/src-003-istio-security-mtls.md
- **Verification Status**: passed
- **Original Excerpt**: > "Mutual TLS authentication: Istio tunnels service-to-service communication through the client- and server-side PEPs (Envoy proxies). When a workload sends a request to another workload using mutual TLS authentication: Istio re-routes the outbound traffic from a client to the client's local sidecar Envoy. The client side Envoy starts a mutual TLS handshake with the server side Envoy. During the handshake, the client side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service. The client side Envoy and the server side Envoy establish a mutual TLS connection, and Istio forwards the traffic from the client side Envoy to the server side Envoy. The server side Envoy authorizes the request. If authorized, it forwards the traffic to the backend service through local TCP connections."
- **Derived Conclusion**: Istio implements mTLS transparently via Envoy sidecar proxies acting as Policy Enforcement Points (PEPs). The mTLS flow involves: client-side Envoy intercepting outbound traffic, performing a mutual TLS handshake with the server-side Envoy (including secure naming verification of the server's service account), establishing the encrypted connection, and forwarding authorized traffic to the backend. Certificates are provisioned automatically via istiod CA and distributed to Envoy via the Secret Discovery Service (SDS) API, with automated rotation. PeerAuthentication policies (PERMISSIVE, STRICT, DISABLE) control mTLS enforcement per namespace or workload.

## Potential Capability Impact
- none

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-12-envoy-sidecar-architecture.md
- KDC-002: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-12-istio-traffic-management.md
- KDC-003: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-12-istio-mtls-architecture.md

## Notes
- none
