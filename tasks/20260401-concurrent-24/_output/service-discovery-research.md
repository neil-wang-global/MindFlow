# Service Discovery Patterns Research

## Task ID
- 20260401-concurrent-24

## Overview

Service discovery is a fundamental pattern in distributed systems and microservices architectures. When services run in dynamic environments (containers, VMs, cloud instances), their network locations (IP addresses and ports) change frequently. Service discovery solves the problem of how one service finds and communicates with another.

## 1. DNS-Based Service Discovery

DNS-based service discovery uses the Domain Name System to resolve service names to network locations. This is the simplest integration path because most applications already support DNS name resolution.

### How It Works

- Services register their network locations with a DNS-aware service registry
- Clients resolve service names using standard DNS queries
- DNS A records return IP addresses; SRV records return IP address, port, and metadata

### Consul's DNS Interface

Consul provides a native DNS interface on port 8600 with the following query formats:

- **Service lookups**: `<service-name>.service[.<datacenter>].consul`
- **Tagged lookups**: `<tag>.<service-name>.service.consul`
- **Node lookups**: `<node-name>.node[.<datacenter>].consul`
- **Prepared queries**: `<query-name>.query.consul` (supports failover and nearest-healthy routing)

Consul integrates health checking directly into DNS responses: only nodes passing all health checks are returned by default. TTL values are configurable via `dns_config` (recommended: 10-30 seconds for service discovery).

DNS forwarding enables coexistence with existing DNS infrastructure via systemd-resolved, dnsmasq, or iptables redirection.

### Kubernetes DNS

Kubernetes provides built-in DNS via CoreDNS, automatically creating DNS entries for services (e.g., `my-service.my-namespace.svc.cluster.local`).

### Limitations

- **DNS caching/TTL**: stale records can route to dead instances
- **Limited load balancing**: basic DNS round-robin may be insufficient
- **Propagation delays**: DNS updates are not instantaneous

## 2. Client-Side vs Server-Side Discovery

### Client-Side Discovery

The client is responsible for querying the service registry, selecting an available instance, and load balancing requests.

**How it works:**
1. Service instances register their network location with the service registry on startup
2. The registry entry is refreshed via heartbeat
3. The client queries the service registry to find available instances
4. The client uses a load-balancing algorithm to select an instance and makes the request

**Benefits:**
- Fewer moving parts and network hops than server-side discovery
- More control over load balancing logic

**Drawbacks:**
- Couples the client to the service registry
- Requires implementing discovery logic in each programming language/framework

**Examples:** Netflix Eureka with Netflix Ribbon, Consul HTTP API

### Server-Side Discovery

A load balancer or router sits between the client and services. The router queries the service registry and forwards requests to available instances.

**How it works:**
1. Service instances register their network location with the service registry
2. The client sends a request to the router (load balancer)
3. The router queries the service registry and forwards the request to an available instance

**Benefits:**
- Simpler client code (no discovery logic needed)
- Language/framework agnostic
- Many deployment environments provide this built-in

**Drawbacks:**
- The router/load balancer is an additional moving part
- Can become a bottleneck or single point of failure
- Additional network hop

**Examples:** AWS Elastic Load Balancer, Kubernetes kube-proxy, Consul Connect service mesh

## 3. Consul vs etcd

| Feature | Consul | etcd |
|---------|--------|------|
| Primary purpose | Service discovery and service mesh | Distributed key-value store |
| Service discovery | Built-in (DNS + HTTP API) | Must be built on top of KV API |
| Health checking | Built-in (HTTP, TCP, gRPC, script, TTL) | No built-in; relies on external mechanisms |
| DNS interface | Native | None |
| Multi-datacenter | Native federation | Single-cluster; requires additional tooling |
| Service mesh | Yes (Consul Connect with sidecar proxies) | No |
| Key-value store | Built-in | Primary function |
| Consensus | Raft (CP system) | Raft (CP system) |
| Ecosystem | HashiCorp (Vault, Nomad, Terraform) | Kubernetes-native (k8s backing store) |

### When to use Consul
- Primary need is service discovery with health checking
- Multi-datacenter deployments
- Need a service mesh
- Want DNS-based discovery out of the box

### When to use etcd
- Already in the Kubernetes ecosystem (etcd is the k8s backing store)
- Need a general-purpose distributed KV store
- Requirements are for configuration management and leader election
- Service discovery will be handled by Kubernetes built-in mechanisms

## Sources

- src-001: Chris Richardson, microservices.io — Client-side and Server-side Service Discovery Patterns (https://microservices.io/patterns/client-side-discovery.html)
- src-002: HashiCorp, Consul DNS Overview — official documentation (https://developer.hashicorp.com/consul/docs/services/discovery/dns-overview)
