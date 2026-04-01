# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://developer.hashicorp.com/consul/docs/services/discovery/dns-overview

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official HashiCorp documentation for Consul, the primary source for Consul's DNS-based service discovery capabilities

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# DNS Overview

Consul provides a DNS interface that allows services to be discovered via DNS queries. This is the simplest way to integrate Consul into your existing infrastructure, as most applications already support DNS-based name resolution.

## DNS Query Formats

Consul listens for DNS queries on port 8600 by default. The following query formats are supported:

### Service Lookups

To look up a service, use the following format:

```
<service-name>.service[.<datacenter>].consul
```

For example, to find the `web` service in the default datacenter:

```
web.service.consul
```

By default, all nodes with a passing health check for the requested service are returned. Consul supports both A and SRV record queries.

- **A records** return the IP addresses of healthy service instances
- **SRV records** return the IP address, port, and additional metadata

### Tagged Service Lookups

To filter by tag, prepend the tag name:

```
<tag>.<service-name>.service.consul
```

For example, to find the `web` service instances tagged as `rails`:

```
rails.web.service.consul
```

### Node Lookups

```
<node-name>.node[.<datacenter>].consul
```

## DNS Caching and TTL

Consul allows you to configure TTL values for DNS responses. The `dns_config` section of the agent configuration supports:

- `node_ttl` — TTL for node lookups (default: 0, meaning no caching)
- `service_ttl` — map of service names to TTL values
- `allow_stale` — allows any Consul server, not just the leader, to service the request
- `max_stale` — limits how stale results can be when `allow_stale` is enabled

Short TTLs (e.g., 10-30 seconds) are recommended for service discovery to balance freshness with DNS query load.

## Health Check Integration

By default, DNS queries only return nodes that are passing all health checks. This behavior can be changed:

- Nodes with failing health checks are automatically removed from DNS results
- Custom health checks can be defined: HTTP, TCP, script, gRPC, TTL-based
- The `only_passing` flag controls whether to include nodes with warning-level checks

## DNS Forwarding

To use Consul DNS alongside your existing DNS infrastructure, you can configure DNS forwarding. Common approaches:

1. **systemd-resolved** — configure a stub listener that forwards `.consul` queries to Consul
2. **dnsmasq** — add a server directive for the `.consul` domain
3. **iptables** — redirect DNS queries for `.consul` to Consul's DNS port

## Prepared Queries

Prepared queries allow you to define complex service lookups that are accessible via DNS:

```
<query-name-or-id>.query.consul
```

Features include:
- Failover across datacenters
- Nearest-healthy routing based on network coordinates
- Tag filtering with regular expressions

## Multi-Datacenter Support

Consul's DNS interface supports cross-datacenter queries:

```
<service-name>.service.<datacenter>.consul
```

This allows services in one datacenter to discover services in another, enabling multi-datacenter architectures.

## Comparison with etcd

While Consul provides a built-in DNS interface for service discovery, etcd is primarily a distributed key-value store used as the backing store for Kubernetes. Key differences:

- **Consul**: purpose-built service discovery with native DNS, health checking, and service mesh (Consul Connect)
- **etcd**: general-purpose distributed KV store; service discovery must be built on top using the KV API
- **Consul**: native multi-datacenter federation
- **etcd**: single-cluster; multi-cluster requires additional tooling
- **Consul**: built-in health checks (HTTP, TCP, gRPC, script)
- **etcd**: no built-in health checking; relies on external mechanisms (e.g., Kubernetes liveness probes)

Both use the Raft consensus protocol for consistency, making them CP systems under the CAP theorem.
