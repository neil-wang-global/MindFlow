# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001 — cache invalidation pattern evidence grounding

## Source URL
- https://engineering.fb.com/2013/06/25/core-infra/tao-the-power-of-the-graph/

## Fetch Timestamp
- 2026-04-01T14:36:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Facebook (Meta) engineering blog, first-party production experience documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# TAO: The Power of the Graph

Facebook serves billions of reads per second from its social graph. TAO (The Associations and Objects) is the system that makes this possible.

## Architecture

TAO is a geographically distributed data store that serves Facebook's social graph. It is optimized for read-heavy workloads and uses a multi-tier caching architecture.

**Cache tiers:**

- **Leader cache**: One per database shard. Handles all writes and serves reads for data not in follower caches.
- **Follower caches**: Multiple per leader. Serve the majority of read traffic. Follower caches are deployed in multiple data centers.

## Cache Invalidation

TAO uses an event-driven cache invalidation mechanism to maintain consistency across its multi-tier cache hierarchy.

**Write path:**

1. A write request arrives at the leader cache.
2. The leader writes to the database synchronously (write-through to the backing store).
3. After the database write succeeds, the leader sends asynchronous invalidation messages to all follower caches.
4. Follower caches invalidate the affected entries upon receiving the message.

**Consistency model:**

- TAO provides **read-after-write consistency** within a single leader region.
- Cross-region consistency is **eventual**, bounded by the invalidation message propagation delay (typically under 1 second).
- The system tolerates temporary staleness in follower caches as a deliberate trade-off for read throughput.

## Thundering Herd Mitigation

When a popular cache entry is invalidated, many concurrent reads may attempt to refill the entry simultaneously, causing a "thundering herd" on the database.

**TAO's mitigation strategy:**

- **Lease mechanism**: When a cache miss occurs, the cache grants a "lease" to exactly one reader. Other readers for the same key are either served stale data or wait for the lease holder to populate the cache.
- **Stale-while-revalidate**: Follower caches may serve slightly stale data while the lease holder fetches the fresh value from the leader or database. This prevents all concurrent readers from hitting the backing store simultaneously.
- **Refill suppression**: The leader cache tracks in-flight database reads. Multiple concurrent requests for the same key result in only one database query; subsequent requestors receive the result of the in-flight query.

## Performance at Scale

- TAO serves over 1 billion read requests per second.
- The cache hit ratio exceeds 96% on average.
- Write throughput is approximately 1 million writes per second.
- Invalidation messages propagate to follower caches within 25-500ms depending on geographic distance.

## Lessons Learned

- **TTL as safety net**: Even with event-driven invalidation, TAO uses TTL-based expiration as a secondary consistency mechanism. If an invalidation message is lost (network partition, message queue overflow), the TTL ensures bounded staleness.
- **Granular invalidation**: Invalidation at the key level (rather than cache-wide flush) minimizes unnecessary cache misses.
- **Monitoring invalidation lag**: TAO monitors the delay between writes and invalidation delivery. Spikes in invalidation lag indicate network issues or queue congestion.
