# Cache Invalidation Strategies in Distributed Systems

## Overview

Cache invalidation is one of the two hard problems in computer science (Phil Karlton). In distributed systems, maintaining consistency between cached data and the source of truth requires deliberate strategy selection based on consistency requirements, latency tolerance, and failure mode characteristics. This document surveys four primary cache invalidation strategies: write-through, write-behind (write-back), TTL-based expiration, and event-driven invalidation.

## 1. Write-Through Invalidation

### Mechanism
Write-through caching updates the cache and the backing store synchronously as part of the same write operation. The write is considered complete only after both the cache and the persistent store have been updated. The typical flow is:

1. Client sends a write request
2. Cache layer receives the write
3. Cache writes to the backing store synchronously
4. Cache updates its own entry with the new value
5. Acknowledgment returned to the client

### Consistency Guarantees
- **Strong consistency**: The cache and backing store are always in sync at write completion.
- **Read-after-write consistency**: Any read immediately after a write will reflect the updated value.
- **No stale reads** under normal operation (single-cache-node scenarios).

### Latency Characteristics
- **Write latency**: Higher than cache-only writes, as every write incurs the backing store round-trip.
- **Read latency**: Low, as data is always present in cache after a write.
- Typical write latency overhead: 2-10ms additional per write (depending on backing store latency).

### Failure Modes
- **Backing store unavailable**: Write fails entirely; cache is not updated. This is the safest failure mode — no inconsistency.
- **Cache node failure after backing store write**: Data is in the backing store but not cached. Next read triggers a cache miss and repopulation.
- **Partial failure in distributed cache**: If the cache layer is distributed, a write may succeed on some nodes but fail on others, leading to inconsistency across cache replicas.

### Use Cases
- Financial transaction records where consistency is non-negotiable
- Configuration data that is read frequently but written infrequently
- Systems where write volume is low relative to read volume

### Trade-offs
| Dimension | Assessment |
|-----------|-----------|
| Consistency | Strong |
| Write latency | High (synchronous backing store write) |
| Read latency | Low (always cached) |
| Complexity | Low |
| Failure safety | High (fail-closed on write) |

---

## 2. Write-Behind (Write-Back) Invalidation

### Mechanism
Write-behind caching writes to the cache immediately and asynchronously propagates the change to the backing store. The write is acknowledged to the client as soon as the cache is updated, and a background process handles persistence.

1. Client sends a write request
2. Cache layer updates the cache entry immediately
3. Acknowledgment returned to the client
4. Background process batches and flushes dirty entries to the backing store

### Consistency Guarantees
- **Eventual consistency**: The backing store will eventually reflect the cached state, but there is a window of inconsistency.
- **Write-coalescing**: Multiple rapid writes to the same key may be coalesced, with only the final value written to the backing store.
- **No read-after-write consistency** for clients reading directly from the backing store (bypassing cache).

### Latency Characteristics
- **Write latency**: Very low — only cache write latency (sub-millisecond for in-memory caches).
- **Read latency**: Low — data always present in cache after write.
- **Background flush latency**: Configurable; typical batch intervals range from 100ms to several seconds.

### Failure Modes
- **Cache node failure before flush**: Data loss. Dirty entries not yet persisted are lost. This is the primary risk.
- **Backing store unavailable**: Dirty entries accumulate in the cache queue. Risk of queue overflow if the outage persists.
- **Ordering violations**: If the flush process does not preserve write order, the backing store may reflect an inconsistent state (e.g., overwriting a newer value with an older one).

### Use Cases
- High-throughput write workloads where latency is critical (gaming leaderboards, session stores)
- Workloads with high write-coalescing opportunity (counters, metrics aggregation)
- Systems where temporary data loss on cache failure is tolerable

### Trade-offs
| Dimension | Assessment |
|-----------|-----------|
| Consistency | Eventual |
| Write latency | Very low (async) |
| Read latency | Low (always cached) |
| Complexity | Medium-high (flush management, ordering) |
| Failure safety | Low (data loss risk on cache failure) |

---

## 3. TTL-Based (Time-to-Live) Expiration

### Mechanism
TTL-based invalidation assigns a time-to-live to each cache entry. After the TTL expires, the entry is considered stale and is either lazily evicted (on next access) or proactively purged (by a background sweeper).

1. Data is cached with a TTL value (e.g., 300 seconds)
2. Reads within TTL serve the cached value
3. After TTL expiration, the next read triggers a cache miss
4. The cache fetches the current value from the backing store and re-caches it with a new TTL

### Consistency Guarantees
- **Bounded staleness**: Data can be stale for at most the TTL duration.
- **No real-time consistency**: A write to the backing store is invisible to cache readers until TTL expiration.
- **Probabilistic freshness**: Shorter TTLs improve freshness at the cost of higher backing store load.

### Latency Characteristics
- **Write latency**: Not applicable (writes go directly to the backing store; cache is not actively invalidated).
- **Read latency**: Low during TTL window; cache miss penalty on expiration (backing store fetch + re-cache).
- **Thundering herd risk**: When a popular key expires, many concurrent reads may simultaneously hit the backing store.

### Failure Modes
- **TTL too long**: Unacceptable staleness for clients expecting fresher data.
- **TTL too short**: Cache hit ratio degrades; backing store load approaches no-cache baseline.
- **Clock skew in distributed caches**: Different cache nodes may expire the same key at different times, serving inconsistent data.
- **Thundering herd**: Mitigated by jitter on TTL values, stale-while-revalidate patterns, or probabilistic early expiration.

### Use Cases
- Content delivery networks (CDN) for web assets
- DNS record caching
- API response caching where bounded staleness is acceptable
- Data that changes on predictable schedules (daily reports, hourly aggregations)

### Trade-offs
| Dimension | Assessment |
|-----------|-----------|
| Consistency | Bounded staleness (proportional to TTL) |
| Write latency | N/A (writes bypass cache) |
| Read latency | Low within TTL; miss penalty on expiration |
| Complexity | Low |
| Failure safety | Medium (staleness risk, thundering herd) |

---

## 4. Event-Driven Invalidation

### Mechanism
Event-driven invalidation uses an event bus (pub/sub, change-data-capture, or message queue) to propagate invalidation signals from the source of truth to cache nodes. When data changes, an event is published, and cache subscribers invalidate or update their local entries.

1. Client writes to the backing store
2. Backing store emits a change event (via CDC, database trigger, or application-level publish)
3. Cache nodes subscribe to the event stream
4. Upon receiving an invalidation event, cache nodes delete or update the affected entry

### Consistency Guarantees
- **Near-real-time consistency**: Latency is bounded by event propagation delay (typically milliseconds to low seconds).
- **Stronger than TTL**: No fixed staleness window; invalidation occurs on-change rather than on-expiration.
- **At-least-once semantics risk**: Duplicate events may cause redundant invalidations but not inconsistency. Lost events, however, lead to stale entries.

### Latency Characteristics
- **Write latency**: Same as direct backing store write (event is emitted asynchronously after write).
- **Read latency**: Low — data is cached until an invalidation event arrives.
- **Invalidation propagation delay**: Typically 10-500ms depending on event infrastructure (Kafka, Redis Pub/Sub, database CDC).

### Failure Modes
- **Event loss**: If the event bus drops a message, the cache entry becomes permanently stale until the next natural cache miss or manual purge.
- **Event ordering**: Out-of-order events can cause ABA problems (overwriting a newer value with an older invalidation).
- **Subscriber lag**: If a cache node falls behind on the event stream, it serves stale data during the catch-up period.
- **Event bus unavailability**: No new invalidations propagate; all caches serve potentially stale data until the bus recovers.

### Use Cases
- E-commerce product catalogs (price changes must propagate quickly)
- Multi-region cache architectures where active invalidation is cheaper than short TTLs
- Systems with database CDC infrastructure already in place (Debezium, DynamoDB Streams)
- Microservice architectures where services maintain local caches of shared reference data

### Trade-offs
| Dimension | Assessment |
|-----------|-----------|
| Consistency | Near-real-time (event propagation bounded) |
| Write latency | Same as direct write |
| Read latency | Low (cached until invalidation) |
| Complexity | High (event infrastructure, ordering, delivery guarantees) |
| Failure safety | Medium (event loss = permanent staleness) |

---

## Comparison Matrix

| Strategy | Consistency | Write Latency | Read Latency | Complexity | Data Loss Risk | Best For |
|----------|-----------|---------------|-------------|-----------|---------------|----------|
| Write-Through | Strong | High | Low | Low | None | Low-write, high-read workloads |
| Write-Behind | Eventual | Very Low | Low | Medium-High | High (cache failure) | High-throughput writes |
| TTL-Based | Bounded staleness | N/A | Low (within TTL) | Low | None (staleness only) | Predictable change rates |
| Event-Driven | Near-real-time | Same as direct | Low | High | Medium (event loss) | Multi-region, CDC-ready systems |

## Selection Guidance

1. **Start with TTL-based** for most read-heavy workloads where bounded staleness is acceptable. It is the simplest to implement and operate.
2. **Use write-through** when strong consistency is required and write volume is manageable. The synchronous write overhead is the primary cost.
3. **Consider write-behind** only when write throughput is the bottleneck and the system can tolerate data loss on cache node failure. Requires careful flush ordering and monitoring.
4. **Adopt event-driven invalidation** when you need near-real-time consistency across distributed caches and already have (or plan to invest in) an event infrastructure. The operational complexity is significant but the consistency-latency trade-off is favorable.
5. **Hybrid approaches** are common in production: TTL as a safety net combined with event-driven invalidation for active freshness. This provides both bounded staleness guarantees and near-real-time updates.

## References and Grounding Notes

- The write-through and write-behind patterns are well-documented in Jim Gray's transaction processing literature and are standard in CPU cache architectures (adapted to distributed caching).
- TTL-based expiration is the foundational mechanism in DNS (RFC 1035) and HTTP caching (RFC 7234).
- Event-driven invalidation via CDC is documented in Martin Kleppmann's "Designing Data-Intensive Applications" (Chapter 11: Stream Processing) and implemented by tools like Debezium.
- The thundering herd problem and mitigation strategies (jitter, probabilistic early expiration) are described in research from Facebook's TAO paper and Memcached scaling literature.
