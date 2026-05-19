# gRPC Load Balancing Strategies in Kubernetes

## Summary

gRPC uses HTTP/2 with persistent, multiplexed connections where multiple RPC streams share a single TCP connection. Kubernetes default load balancing (kube-proxy via iptables/IPVS) operates at L4 (TCP connection level), selecting a backend pod per connection. Once a gRPC channel establishes its TCP connection, all subsequent RPCs are multiplexed over that single connection to the same pod, defeating per-request load distribution. This differs from HTTP/1.1, where non-multiplexed requests and connection cycling naturally distribute load across backends.

## The Core Problem

- HTTP/2 design: single long-lived TCP connection with request multiplexing
- Kubernetes kube-proxy: L4 load balancing selects backend per TCP connection
- Result: all gRPC RPCs from a client pin to one backend pod
- HTTP/1.1 does not have this problem because it naturally cycles TCP connections (no multiplexing, connection expiration)

## Solution Approach 1: Client-Side Load Balancing

The gRPC client itself maintains connections to multiple backend pods and distributes RPCs across them.

### Headless Services + DNS Resolution
- Kubernetes headless services (clusterIP: None) return individual pod IPs as DNS A records
- gRPC clients resolve the service DNS name to multiple addresses
- Built-in gRPC LB policies (pick_first, round_robin) distribute RPCs across connections
- Limitations: DNS caching can cause stale endpoints; not all gRPC client libraries support this equally; cannot use standard ClusterIP services

### xDS-Based (Proxyless gRPC)
- gRPC natively supports the xDS protocol (since gRPC 1.30+)
- A control plane (e.g., Istio istiod, Traffic Director) pushes endpoint and routing configuration to gRPC clients via xDS API
- Clients perform load balancing decisions locally without a proxy
- Eliminates proxy overhead while maintaining dynamic endpoint discovery

### Trade-offs (Client-Side)
- Pros: no extra hop/latency, no additional infrastructure, high performance
- Cons: complex client logic, requires per-language implementation, requires headless services or xDS control plane, clients must handle endpoint changes

## Solution Approach 2: Proxy-Based (L7) Load Balancing

An L7-aware proxy intercepts gRPC traffic and distributes individual RPCs across backend pods.

### Service Mesh Sidecar (Envoy/Linkerd)
- Each pod gets a sidecar proxy that understands HTTP/2 framing
- The proxy terminates the client's HTTP/2 connection and opens separate connections to backends
- Individual gRPC RPCs are distributed at the stream/request level (L7)
- Transparent to application code (no client changes needed)
- Examples: Istio (Envoy sidecar), Linkerd (ultralight Rust proxy)

### Standalone L7 Proxy/Gateway
- Envoy, NGINX, or Traefik deployed as a central proxy/gateway
- Handles gRPC load balancing at ingress or between services
- Potential bottleneck as a centralized component

### Trade-offs (Proxy-Based)
- Pros: transparent to applications, centralized control/observability, works with any language, supports advanced features (circuit breaking, retries, mTLS, canary routing)
- Cons: added latency (extra network hop), resource overhead (especially sidecar per pod), infrastructure complexity

## Comparison Matrix

| Aspect | Client-Side (Headless + DNS) | Client-Side (xDS/Proxyless) | Proxy-Based (Sidecar Mesh) | Proxy-Based (Gateway) |
|--------|-------|-------|-------|-------|
| Latency overhead | None | None | Per-hop sidecar latency | Per-hop gateway latency |
| Client changes required | Yes (LB policy config) | Yes (xDS config) | No | No |
| Language dependency | Per-language gRPC support | Per-language xDS support | Language-agnostic | Language-agnostic |
| Dynamic endpoint updates | Limited (DNS TTL) | Real-time (xDS push) | Real-time (control plane) | Real-time (control plane) |
| Advanced features | None built-in | Policy-based | Full (retries, CB, mTLS) | Full (retries, CB, mTLS) |
| Resource overhead | Minimal | Minimal | Sidecar per pod | Central proxy |
| Operational complexity | Low | Medium (control plane) | High (mesh infrastructure) | Medium |

## Source Grounding
- src-001: https://kubernetes.io/blog/2018/11/07/grpc-load-balancing-on-kubernetes-without-tears/ (Kubernetes blog by William Morgan, Buoyant)
- src-002: https://kubernetes.io/docs/concepts/services-networking/service/ (Kubernetes Services documentation)
