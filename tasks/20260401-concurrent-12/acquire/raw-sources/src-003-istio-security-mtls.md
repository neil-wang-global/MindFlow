# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001

## Source URL
- https://istio.io/latest/docs/concepts/security

## Fetch Timestamp
- 2026-04-01T10:04:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Istio project documentation hosted on istio.io

## Fetch Status
- success

## Fetch Completeness
- truncated
- Page content is extensive; captured the core mTLS architecture, identity provisioning, authentication, and authorization sections. Some peripheral sections (detailed authorization examples) were not included due to tool output limits.

## Original Content

Breaking down a monolithic application into atomic services offers various benefits, including better agility, better scalability and better ability to reuse services. However, microservices also have particular security needs: To defend against man-in-the-middle attacks, they need traffic encryption. To provide flexible service access control, they need mutual TLS and fine-grained access policies. To determine who did what at what time, they need auditing tools.

Istio Security provides a comprehensive security solution to solve these issues. The Istio security features provide strong identity, powerful policy, transparent TLS encryption, and authentication, authorization and audit (AAA) tools to protect your services and data. The goals of Istio security are: Security by default (no changes needed to application code and infrastructure), Defense in depth (integrate with existing security systems to provide multiple layers of defense), Zero-trust network (build security solutions on distrusted networks).

High-level architecture: Security in Istio involves multiple components: A Certificate Authority (CA) for key and certificate management; The configuration API server distributes to the proxies: authentication policies, authorization policies, secure naming information; Sidecar and perimeter proxies work as Policy Enforcement Points (PEPs) to secure communication between clients and servers; A set of Envoy proxy extensions to manage telemetry and auditing.

Istio identity: The Istio identity model uses the first-class service identity to determine the identity of a request's origin. Istio securely provisions strong identities to every workload with X.509 certificates. Istio agents, running alongside each Envoy proxy, work together with istiod to automate key and certificate rotation at scale.

Identity provisioning flow: istiod offers a gRPC service to take certificate signing requests (CSRs). When started, the Istio agent creates the private key and CSR, and then sends the CSR with its credentials to istiod for signing. The CA in istiod validates the credentials carried in the CSR and signs the CSR to generate the certificate. When a workload is started, Envoy requests the certificate and key from the Istio agent via the Envoy secret discovery service (SDS) API. The Istio agent sends the certificates received from istiod and the private key to Envoy via the Envoy SDS API. Istio agent monitors the expiration of the workload certificate for certificate and key rotation.

Mutual TLS authentication: Istio tunnels service-to-service communication through the client- and server-side PEPs (Envoy proxies). When a workload sends a request to another workload using mutual TLS authentication: Istio re-routes the outbound traffic from a client to the client's local sidecar Envoy. The client side Envoy starts a mutual TLS handshake with the server side Envoy. During the handshake, the client side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service. The client side Envoy and the server side Envoy establish a mutual TLS connection, and Istio forwards the traffic from the client side Envoy to the server side Envoy. The server side Envoy authorizes the request. If authorized, it forwards the traffic to the backend service through local TCP connections.

Istio configures TLSv1_2 as the minimum TLS version for both client and server with the following cipher suites: ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, AES256-GCM-SHA384, AES128-GCM-SHA256.

Permissive mode: Istio mutual TLS has a permissive mode, which allows a service to accept both plaintext traffic and mutual TLS traffic at the same time. This is useful during migrations.

Peer authentication: Peer authentication policies specify the mutual TLS mode Istio enforces on target workloads. The following modes are supported: PERMISSIVE (accept both mutual TLS and plain text traffic), STRICT (only accept mutual TLS traffic), DISABLE (mutual TLS is disabled).

PeerAuthentication example for namespace-wide STRICT mTLS:
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "example-policy"
  namespace: "foo"
spec:
  mtls:
    mode: STRICT

Authorization: Istio's authorization features provide mesh-, namespace-, and workload-wide access control. The authorization policy enforces access control to the inbound traffic in the server side Envoy proxy. Each Envoy proxy runs an authorization engine that authorizes requests at runtime.
