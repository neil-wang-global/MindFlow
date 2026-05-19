# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://kubernetes.io/docs/concepts/services-networking/service/

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Kubernetes project documentation

## Fetch Status
- success

## Fetch Completeness
- truncated
- WebFetch returned summarized/processed content rather than verbatim page text; tool-level processing converted HTML to structured summary; headless services section was referenced from TOC but detailed text was truncated

## Original Content

Kubernetes Services Documentation — Headless Services and gRPC Load Balancing Implications

The Kubernetes Services documentation covers the following relevant points for gRPC load balancing:

1) Headless Services — client-side (DNS) discovery for gRPC
- Use a headless Service (clusterIP: None) when you want clients to discover individual Pod endpoints (no cluster virtual IP). This is commonly used for client-side load balancing (the gRPC client resolves the service DNS name to multiple A records and performs client-side load balancing).
- Headless Service YAML (basic):
  apiVersion: v1
  kind: Service
  metadata:
    name: my-grpc-headless
  spec:
    clusterIP: None
    selector:
      app: my-grpc-backend
    ports:
      - name: grpc
        port: 50051
        protocol: TCP
        targetPort: 50051

- Behavior: DNS lookups for my-grpc-headless.default.svc.cluster.local return the Pod IPs (A records). gRPC clients that support DNS-based name resolution + client-side balancers (e.g., grpc-java, grpc-go, grpc-node with appropriate resolver and LB policy) can use those IPs and do pick_first, round_robin, or other policies.

2) ClusterIP / kube-proxy and gRPC (implications of HTTP/2 multiplexing)
- A normal Service (ClusterIP) exposes a single virtual IP. kube-proxy (e.g., iptables/ipvs) will select a backend per connection/packet depending on mode. Important implications for gRPC (HTTP/2):
  - HTTP/2 (which gRPC uses) multiplexes multiple RPC streams over a single long-lived TCP/TLS connection.
  - If kube-proxy / cloud load balancer routes per TCP connection, and the client holds a single connection to a single backend, multiple RPCs within that connection go to the same backend. This can cause uneven load distribution if clients reuse a small number of long-lived connections.
- Recommendations:
  - Prefer client-side balancing (headless + client LB) or use a layer-7 proxy (Envoy, Ingress/Gateway) that does request-level (stream-level / application-level) balancing.
  - If using Kubernetes Services with kube-proxy, understand that LB is generally per-connection (iptables) or per-packet (ipvs) and long-lived HTTP/2 connections will bias traffic to backends that receive those connections.

3) gRPC client-side load balancing details
- Typical patterns:
  - DNS + headless Service: gRPC client resolves DNS to multiple addresses and the client LB policy distributes requests. Good for gRPC because client can open multiple connections across endpoints, or use a round_robin policy to distribute per-RPC.
  - gRPC naming / xDS: gRPC supports more advanced resolvers (xDS) commonly used with Envoy control plane or with service mesh APIs.

4) Service mesh approaches (Envoy/Linkerd/others)
- Service meshes provide L7-aware proxies (sidecars or gateways) that handle gRPC correctly:
  - Envoy does HTTP/2-aware routing and can load balance at stream/request granularity, apply retries, circuit breaking, observability, mTLS, and use xDS for dynamic configuration.
  - With a mesh, each client Pod talks to a local sidecar proxy; the proxy load-balances to remote proxies/backends using policies configured by the control plane.
- Advantages for gRPC:
  - Avoids per-connection skew caused by HTTP/2 multiplexing because the proxy can open many upstream connections and distribute streams more evenly.
  - Supports advanced traffic control (per-RPC routing, canary, fault injection, retries).

5) Session stickiness and traffic policies
- Kubernetes Services support session affinity settings (clientIP-based) — this forces requests from same client IP to same backend (not desirable for typical gRPC multi-stream workloads).
- Use care: session affinity at the service level may conflict with gRPC client-side LB goals.

Service with selector example:
  apiVersion: v1
  kind: Service
  metadata:
    name: my-service
  spec:
    selector:
      app.kubernetes.io/name: MyApp
    ports:
      - protocol: TCP
        port: 80
        targetPort: 9376

Kubernetes updates EndpointSlices for a Service whenever the set of Pods changes; EndpointSlices are the canonical way to list endpoints for discovery.
