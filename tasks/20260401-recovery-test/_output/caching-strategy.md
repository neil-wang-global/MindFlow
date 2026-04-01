# 3-Tier Caching Strategy for API Gateway

## 1. Overview

This document presents a complete caching strategy for an API gateway, organized into three distinct layers: edge, application, and data. The strategy covers cache layer responsibilities, eviction policies, invalidation patterns, TTL management, and cross-layer consistency guarantees.

Design decisions are guided by the following principles:
- Resilience over raw performance
- Evidence-based design over intuition
- Explicit failure handling over silent degradation

## 2. Cache Layer Architecture

### 2.1 Edge Cache (Layer 1)

| Property | Value |
|----------|-------|
| Position | CDN/reverse proxy, closest to client |
| Cached content | Full HTTP responses for public, non-personalized endpoints |
| Scope | Shared across all users |
| Purpose | Reduce latency for distributed clients; offload origin traffic |
| Eviction policy | TTL-based with stale-while-revalidate |

The edge cache handles the highest volume of cacheable traffic. It operates at CDN nodes and serves public content without requiring origin contact. Because invalidation control is limited at this layer, TTL-based expiration is the primary eviction mechanism.

### 2.2 Application Cache (Layer 2)

| Property | Value |
|----------|-------|
| Position | Within API gateway process, post-authentication |
| Cached content | Computed results, aggregated responses, per-user session data |
| Scope | Mixed (shared + per-user) |
| Purpose | Avoid redundant computation and database queries |
| Eviction policy | LRU with TTL cap |

The application cache sits inside the gateway process and provides sub-millisecond access. It handles both shared computations and user-scoped data with separate TTL caps to prevent stale personalized responses.

### 2.3 Data Cache (Layer 3)

| Property | Value |
|----------|-------|
| Position | Between gateway and backend stores |
| Cached content | Query results, serialized entities, external service responses |
| Scope | Shared across all gateway instances (Redis cluster) |
| Purpose | Reduce backend load; provide resilience during backend degradation |
| Eviction policy | LFU with adaptive TTL |

The data cache is a distributed layer (typically Redis) shared across all gateway instances. It serves as both a performance optimization and a resilience mechanism — during backend failures, the data cache can serve stale-but-available responses.

## 3. Eviction Policies

### 3.1 Edge Cache: TTL-Based with Stale-While-Revalidate

- Dynamic content: TTL 60-300 seconds
- Semi-static content: TTL 3600+ seconds
- Stale-while-revalidate window: 30 seconds
- Rationale: Limited invalidation control at CDN edge; TTL is the most reliable mechanism. Stale-while-revalidate prevents cache stampedes and maintains availability during origin slowdowns.

### 3.2 Application Cache: LRU with TTL Cap

- Shared entries TTL cap: 120 seconds
- Per-user entries TTL cap: 60 seconds
- Memory bound: 256 MB per gateway instance
- Rationale: Access patterns are skewed (small set dominates traffic). LRU is well-studied and predictable under skewed distributions. TTL caps prevent stale personalized data.

### 3.3 Data Cache: LFU with Adaptive TTL

- TTL range: 300-1800 seconds, adjusted by entity write frequency
- Capacity: Redis cluster maxmemory policy
- Rationale: Hot data (frequently queried entities) survives eviction pressure. Adaptive TTL reduces staleness for volatile entities while preserving stable reference data.

## 4. Cache Invalidation Patterns

### 4.1 Event-Driven Invalidation

For the application and data cache layers, use event-driven invalidation via a message bus:

1. **Write-through invalidation**: When a backend write occurs, publish an invalidation event to the message bus
2. **Subscriber pattern**: Each gateway instance subscribes to invalidation events for its cached entity types
3. **Invalidation scope**: Events carry entity type + entity ID; subscribers remove matching entries from local application cache and issue DELETE to the data cache

### 4.2 Purge API for Edge Cache

Since edge caches have limited invalidation control:

1. Expose a `/cache/purge` administrative endpoint
2. On critical data changes, trigger purge requests to CDN API for affected URL patterns
3. For non-critical changes, rely on TTL expiration (no active purge)

### 4.3 Cascading Invalidation

When an entity is invalidated at the data cache layer:

1. Data cache entry removed (via event or TTL)
2. Application cache entries depending on that entity removed (via local subscriber)
3. Edge cache entries are NOT actively invalidated (rely on TTL) unless the purge API is explicitly invoked

This one-directional cascade (data -> application -> edge only on explicit purge) keeps the invalidation system simple and avoids distributed coordination complexity.

## 5. TTL Management Strategy

### 5.1 TTL Assignment Rules

| Layer | Content Type | TTL | Adjustment Trigger |
|-------|-------------|-----|--------------------|
| Edge | Public static | 3600s | Deployment event |
| Edge | Public dynamic | 60-300s | Traffic analysis (weekly) |
| Application | Shared computation | 120s | None (fixed cap) |
| Application | Per-user session | 60s | None (fixed cap) |
| Data | Stable reference | 1800s | Write frequency drops below threshold |
| Data | Volatile entity | 300s | Write frequency exceeds threshold |

### 5.2 Adaptive TTL for Data Cache

The data cache adjusts TTLs based on observed write frequency:

- Track write events per entity type over a sliding window (5 minutes)
- If write rate > 1 write/minute: set TTL to 300 seconds (minimum)
- If write rate < 1 write/10 minutes: set TTL to 1800 seconds (maximum)
- Linear interpolation between bounds for intermediate rates

This approach follows the explicit failure handling principle: high-churn entities get short TTLs to bound staleness, rather than silently serving outdated data.

## 6. Consistency Guarantees

### 6.1 Consistency Model

This caching strategy provides **eventual consistency** with bounded staleness:

- **Data cache**: Staleness bounded by adaptive TTL (300-1800 seconds) plus event-driven invalidation (sub-second propagation for connected instances)
- **Application cache**: Staleness bounded by TTL cap (60-120 seconds) plus local invalidation subscriber
- **Edge cache**: Staleness bounded by TTL (60-3600 seconds); no real-time consistency guarantee

### 6.2 Read-After-Write Consistency

For operations requiring read-after-write consistency:

1. **Bypass flag**: Clients may send a `Cache-Control: no-cache` header to bypass edge and application caches
2. **Version tag**: Write operations return a version tag; subsequent reads include the tag to ensure the response reflects at least that version
3. **Direct-read path**: Critical reads (e.g., after payment) bypass all cache layers and read directly from the backend

### 6.3 Cross-Layer Consistency Invariants

1. Data cache is always at least as fresh as application cache (application cache TTL <= data cache TTL)
2. Application cache is always at least as fresh as edge cache (application cache TTL <= edge cache TTL for the same content)
3. Invalidation propagates inward (data -> application) but not outward to edge (edge relies on TTL)

## 7. Failure Modes and Resilience

### 7.1 Cache Layer Failure Scenarios

| Failure | Impact | Mitigation |
|---------|--------|------------|
| Edge cache unavailable | Requests hit origin directly; latency increases | Gateway handles increased load; auto-scale |
| Application cache full | LRU eviction accelerates; cache hit rate drops | Monitor eviction rate; alert on sustained high eviction |
| Data cache (Redis) down | All misses go to backend; risk of backend overload | Circuit breaker on backend; serve stale application cache entries with extended TTL |
| Backend database down | No cache fills possible; existing cache entries serve until TTL | Extend TTLs on data cache entries during outage (grace period mode) |

### 7.2 Grace Period Mode

When the backend is unreachable:

1. Data cache entries that would normally expire get a grace extension (TTL + 300 seconds)
2. Application cache entries serve with a relaxed TTL cap (doubled)
3. Edge cache continues normally (already TTL-based, unaffected)
4. All grace-extended responses include a `X-Cache-Degraded: true` header

This aligns with the resilience principle: degraded but available service is preferred over hard failure.

## 8. Monitoring and Observability

Key metrics to track per layer:

- **Hit rate**: Target >90% for edge, >70% for application, >80% for data
- **Eviction rate**: Alert when eviction rate exceeds 10% of total entries per minute
- **Staleness distribution**: P50/P95/P99 of actual staleness at read time
- **Invalidation latency**: Time from write event to cache removal (data + application layers)
- **Grace period activations**: Count and duration of degraded-mode episodes
