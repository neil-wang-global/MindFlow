# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001 — cache invalidation pattern evidence grounding

## Source URL
- https://docs.oracle.com/en/middleware/standalone/coherence/14.1.1.2206/develop-applications/cache-aside-write-through-write-behind.html

## Fetch Timestamp
- 2026-04-01T14:35:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Oracle official product documentation for Coherence distributed cache

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Cache Aside, Write-Through, and Write-Behind Caching

Oracle Coherence supports several caching strategies that control how data flows between the cache and the backing data store.

## Write-Through Caching

A write-through cache is a caching strategy where every write to the cache also results in a synchronous write to the underlying data store. The cache acts as a proxy for the data store, and the write operation is not considered complete until both the cache and the data store have been updated.

**How it works:**

1. The application writes data to the cache.
2. The cache immediately and synchronously writes the data to the backing store.
3. The write operation returns to the caller only after both writes succeed.

**Key characteristics:**

- **Data consistency**: The cache and backing store are always in sync. There is no window of inconsistency between the two.
- **Write latency**: Write operations are slower because they must wait for the backing store write to complete. The total write latency is the sum of the cache write latency and the backing store write latency.
- **Read performance**: Subsequent reads are always served from the cache with the most current data, eliminating cache misses for recently written data.
- **Failure behavior**: If the backing store write fails, the cache write is also rolled back, maintaining consistency. This fail-closed behavior ensures that the cache never contains data that is not in the backing store.

**When to use write-through:**

- Applications that require strong consistency between cached data and the backing store
- Systems where write frequency is low relative to read frequency
- Scenarios where data loss on cache failure is unacceptable

## Write-Behind (Write-Back) Caching

A write-behind cache (also called write-back) is a caching strategy where writes are applied to the cache immediately but are propagated to the backing store asynchronously. The cache acknowledges the write to the caller before the backing store has been updated.

**How it works:**

1. The application writes data to the cache.
2. The cache acknowledges the write immediately.
3. The cache queues the modified entry for asynchronous write to the backing store.
4. A background thread (the write-behind thread) periodically flushes queued entries to the backing store.

**Key characteristics:**

- **Write latency**: Extremely low because the application only waits for the cache write. The backing store write happens asynchronously.
- **Write coalescing**: Multiple rapid modifications to the same cache entry may be coalesced, with only the final value written to the backing store. This reduces backing store write load.
- **Data loss risk**: If the cache node fails before the queued entries are flushed, those entries are lost. This is the primary trade-off of write-behind caching.
- **Ordering**: The write-behind queue must preserve write order for the same key to avoid overwriting newer values with older ones. Cross-key ordering is typically not guaranteed.

**Configuration options:**

- `write-delay`: The maximum time an entry can remain in the write queue before being flushed (default: 0, meaning synchronous write-through behavior).
- `write-batch-factor`: The percentage of the write-delay interval at which a batch write is triggered.
- `write-requeue-threshold`: The number of failed write attempts before an entry is requeued.

**When to use write-behind:**

- High-throughput write workloads where latency is the primary concern
- Applications where temporary data loss on cache failure is acceptable
- Workloads where write coalescing provides significant backing store load reduction

## Cache-Aside Pattern

In cache-aside (also called lazy-loading), the application is responsible for managing the cache. The cache does not interact with the backing store directly.

**How it works:**

1. On read: Check the cache first. On cache miss, read from the backing store, populate the cache, and return the result.
2. On write: Write directly to the backing store. Optionally invalidate or update the cache entry.

**Key characteristics:**

- **Simplicity**: The application controls all cache interactions.
- **Stale data risk**: If the cache entry is not invalidated on write, subsequent reads may return stale data until the entry expires (via TTL) or is evicted.
- **Cache miss cost**: The first read after eviction or invalidation incurs the backing store latency.
