# Eviction Policies by Cache Layer

## Overview
This document defines the eviction policy for each cache layer, with rationale grounded in each layer's characteristics as defined in step-1-cache-layers.md.

## Layer 1: Edge Cache — TTL-Based Eviction with Stale-While-Revalidate

- **Policy**: Pure TTL-based expiration with `stale-while-revalidate` extension
- **TTL Range**: 60-300 seconds for dynamic content; 3600+ seconds for semi-static content
- **Eviction trigger**: Entries expire after TTL; stale entries may be served for up to 30 seconds while async revalidation occurs
- **Rationale**: Edge caches (CDN nodes) have limited invalidation control. TTL-based eviction is the most reliable mechanism at this layer. The stale-while-revalidate pattern aligns with the Soul constraint of resilience over raw performance — it prevents cache stampedes and maintains availability during origin slowdowns.
- **Cache warming**: Pre-warm popular endpoints on deployment via synthetic requests to edge nodes
- **Cold-start handling**: First request after TTL expiry triggers synchronous origin fetch; subsequent requests benefit from stale-while-revalidate window

## Layer 2: Application Cache — LRU with TTL Cap

- **Policy**: LRU (Least Recently Used) eviction with a maximum TTL cap per entry category
- **TTL Caps**: Shared entries: 120 seconds; Per-user entries: 60 seconds
- **Memory bound**: Fixed memory allocation (e.g., 256 MB per gateway instance)
- **Eviction trigger**: LRU eviction when memory bound is reached; TTL expiry for time-sensitive data
- **Rationale**: LRU suits the application cache because access patterns at this layer are skewed — a small set of computations and user sessions dominate traffic. The TTL cap prevents stale personalized data from persisting. This follows the evidence-based design principle: LRU is well-studied and predictable under skewed distributions.
- **Cache warming**: On gateway startup, pre-load the top-N most frequently accessed shared computation results from the data cache layer
- **Cold-start handling**: Cache miss falls through to the data cache layer; no blocking penalty beyond a single additional hop

## Layer 3: Data Cache — LFU with Adaptive TTL

- **Policy**: LFU (Least Frequently Used) eviction with adaptive TTL based on data volatility
- **TTL Range**: 300-1800 seconds, adjusted per entity type based on observed write frequency
- **Memory/Storage bound**: Distributed cache cluster capacity (e.g., Redis cluster with defined maxmemory)
- **Eviction trigger**: LFU eviction when capacity is reached; adaptive TTL expiry based on entity write rates
- **Rationale**: The data cache layer serves as the shared cross-instance store. LFU is preferred here because frequently queried entities (hot data) should survive eviction pressure, while rarely accessed entities should yield capacity. Adaptive TTL addresses the explicit failure handling constraint — entities with high write rates get shorter TTLs to reduce staleness risk, while stable reference data gets longer TTLs.
- **Cache warming**: On cluster scale-out, replicate hot-key sets from existing nodes; on cold start, populate from a snapshot of the most recent query result set
- **Cold-start handling**: Miss falls through to the backend database; circuit breaker pattern protects the backend if miss rate exceeds threshold during cold start
