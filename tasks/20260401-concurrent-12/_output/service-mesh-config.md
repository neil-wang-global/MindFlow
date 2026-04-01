# Service Mesh Configuration: Envoy Sidecar Proxy

## Overview

This document defines a service mesh configuration for an Envoy-based sidecar proxy deployment, covering three core areas: sidecar proxy deployment pattern, traffic management, and mutual TLS (mTLS) security. All design decisions are grounded in verified sources from official Envoy and Istio documentation, combined with approved knowledge base entries.

## 1. Sidecar Proxy Deployment Pattern

### Architecture

Envoy operates as an out-of-process, self-contained proxy deployed alongside every application server. This sidecar pattern forms a transparent communication mesh where each application sends and receives messages to and from localhost, remaining unaware of network topology.

**Source**: src-001 (envoyproxy.io — What is Envoy)

### Key Design Decisions

- **Language-agnostic**: Envoy sidecars bridge heterogeneous service stacks (Java, Go, Python, etc.) without requiring language-specific client libraries
- **Independent upgrade path**: Envoy can be deployed and upgraded across the infrastructure independently of application code, avoiding the painful library upgrade problem
- **L3/L4 + L7 filter chains**: Envoy's pluggable filter architecture supports both network-level (TCP/UDP proxy, TLS client certificate authentication) and application-level (HTTP routing, rate limiting, buffering) processing

### Sidecar Resource Scoping

Per Istio's Sidecar resource configuration, each Envoy proxy should be scoped to limit its service discovery footprint:

```yaml
apiVersion: networking.istio.io/v1
kind: Sidecar
metadata:
  name: default
  namespace: my-namespace
spec:
  egress:
  - hosts:
    - "./*"
    - "istio-system/*"
```

**Rationale**: In larger deployments, having every proxy configured to reach every service causes high memory usage. Scoping egress to the local namespace plus control plane is the recommended starting point.

**Source**: src-002 (istio.io — Traffic Management, Sidecars section)

## 2. Traffic Management

### Service Discovery

Istio's traffic management model relies on Envoy proxies deployed alongside services. Istio connects to the platform's service discovery system (e.g., Kubernetes API) to populate its service registry. Envoy proxies use this registry to direct traffic to relevant services.

**Source**: src-002 (istio.io — Traffic Management)

### Load Balancing

Default: Envoy uses a least-requests model (P2C — power-of-two-choices), routing each request to the host with fewer active requests from a random selection of two hosts.

Additional supported modes via DestinationRule:
- Random
- Weighted
- Round Robin
- Consistent Hash
- Ring Hash (Ketama algorithm)
- Maglev

**Recommended configuration** for production services:

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: my-service-dr
spec:
  host: my-service
  trafficPolicy:
    loadBalancer:
      simple: LEAST_REQUEST
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        h2UpgradePolicy: UPGRADE
        http2MaxRequests: 1000
```

**Source**: src-002 (istio.io — Traffic Management, Load Balancing Options)

### Routing with VirtualService

Traffic routing is configured via VirtualService resources that decouple client request destinations from actual workload instances:

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - my-service
  http:
  - match:
    - headers:
        x-canary:
          exact: "true"
    route:
    - destination:
        host: my-service
        subset: v2
  - route:
    - destination:
        host: my-service
        subset: v1
      weight: 90
    - destination:
        host: my-service
        subset: v2
      weight: 10
    timeout: 10s
    retries:
      attempts: 3
      perTryTimeout: 2s
```

**Source**: src-002 (istio.io — Traffic Management, Virtual Services)

### Circuit Breaking

Circuit breaker thresholds are configured in DestinationRule, applying per-host limits:

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: my-service-circuit-breaker
spec:
  host: my-service
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        http1MaxPendingRequests: 100
        http2MaxRequests: 1000
    outlierDetection:
      consecutive5xxErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
```

**Design alignment**: This configuration implements the three-state circuit breaker pattern (Closed -> Open -> Half-Open) documented in approved KB entry `kb-concept-circuit-breaker-states.md`. Outlier detection provides the failure counting and ejection mechanism that maps to the Open state. The `baseEjectionTime` parameter maps to the timeout timer for the Open-to-Half-Open transition.

**Source**: src-002 (istio.io — Traffic Management, Circuit Breakers) + approved KB (kb-concept-circuit-breaker-states.md)

### Adaptive Concurrency

For services requiring dynamic concurrency limiting, Envoy's adaptive concurrency filter can be used instead of or alongside static circuit breakers:

**Design alignment**: Per approved KB entry `kb-concept-envoy-adaptive-concurrency.md`, Envoy implements an adaptive concurrency filter using the gradient algorithm from Netflix's concurrency-limits library. This dynamically adjusts outstanding request limits based on sampled latencies, providing automated concurrency control without manual per-service threshold configuration.

**Source**: Approved KB (kb-concept-envoy-adaptive-concurrency.md)

### Gateway Configuration

Ingress/egress traffic is managed through Gateway resources applied to standalone edge Envoy proxies:

```yaml
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: mesh-gateway
spec:
  selector:
    app: istio-ingressgateway
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - "*.example.com"
    tls:
      mode: SIMPLE
      credentialName: example-tls-cert
```

**Source**: src-002 (istio.io — Traffic Management, Gateways)

## 3. Mutual TLS (mTLS) Configuration

### Security Architecture

Istio's security architecture provides:
- A Certificate Authority (CA) for key and certificate management (istiod)
- Authentication and authorization policies distributed to Envoy proxies
- Sidecar proxies acting as Policy Enforcement Points (PEPs)

Security goals: security by default, defense in depth, zero-trust network.

**Source**: src-003 (istio.io — Security)

### Identity Provisioning

Istio provisions strong identities to every workload using X.509 certificates via the following automated flow:
1. istiod offers a gRPC service for certificate signing requests (CSRs)
2. Istio agent creates private key and CSR, sends CSR to istiod for signing
3. CA in istiod validates credentials and signs the CSR
4. Envoy requests certificate and key from Istio agent via Secret Discovery Service (SDS) API
5. Istio agent monitors certificate expiration for automated rotation

**Source**: src-003 (istio.io — Security, Identity and Certificate Management)

### mTLS Traffic Flow

When mutual TLS is enabled, service-to-service communication follows this path:
1. Client application sends request to localhost (intercepted by client sidecar Envoy)
2. Client Envoy initiates mTLS handshake with server Envoy
3. Client Envoy performs secure naming check (verifies server's service account is authorized)
4. mTLS connection established between client and server Envoys
5. Server Envoy authorizes the request based on authorization policies
6. Authorized traffic forwarded to backend service via local TCP connection

**TLS Configuration**: TLSv1_2 minimum, with cipher suites: ECDHE-ECDSA-AES256-GCM-SHA384, ECDHE-RSA-AES256-GCM-SHA384, ECDHE-ECDSA-AES128-GCM-SHA256, ECDHE-RSA-AES128-GCM-SHA256, AES256-GCM-SHA384, AES128-GCM-SHA256.

**Source**: src-003 (istio.io — Security, Mutual TLS Authentication)

### PeerAuthentication Policy

**Recommended production configuration** (namespace-wide STRICT mTLS):

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: default
  namespace: my-namespace
spec:
  mtls:
    mode: STRICT
```

**Migration path** (PERMISSIVE during rollout, then switch to STRICT):

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: default
  namespace: my-namespace
spec:
  mtls:
    mode: PERMISSIVE
```

**Modes**:
- PERMISSIVE: Accepts both mutual TLS and plaintext (use during migration)
- STRICT: Only accepts mutual TLS traffic (production target)
- DISABLE: No mTLS enforcement (not recommended for production)

**Source**: src-003 (istio.io — Security, Peer Authentication)

### Authorization Policy

Fine-grained access control via AuthorizationPolicy:

```yaml
apiVersion: security.istio.io/v1
kind: AuthorizationPolicy
metadata:
  name: my-service-authz
  namespace: my-namespace
spec:
  selector:
    matchLabels:
      app: my-service
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/allowed-namespace/sa/allowed-service"]
    to:
    - operation:
        methods: ["GET", "POST"]
```

**Source**: src-003 (istio.io — Security, Authorization)

## Source References

| Source ID | URL | Type | Credibility |
|-----------|-----|------|-------------|
| src-001 | https://www.envoyproxy.io/docs/envoy/latest/intro/what_is_envoy | Technical Documentation | High |
| src-002 | https://istio.io/latest/docs/concepts/traffic-management/ | Technical Documentation | High |
| src-003 | https://istio.io/latest/docs/concepts/security | Technical Documentation | High |
| KB-1 | kb-concept-circuit-breaker-states.md | Approved Knowledge | Accepted |
| KB-2 | kb-concept-envoy-adaptive-concurrency.md | Approved Knowledge | Accepted |
