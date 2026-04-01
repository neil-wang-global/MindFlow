# Knowledge Base Entry

## Type
- concept

## Summary
- Write-through caching enforces synchronous dual-write (cache + backing store) before acknowledging the write, providing strong consistency at the cost of write latency equal to cache-write plus backing-store-write

## Source Lineage
- Task ID: 20260401-concurrent-28
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-28.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-28-write-through-consistency.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-28-write-through-consistency.md`
- Original Source Anchor:
  - `tasks/20260401-concurrent-28/acquire/raw-sources/src-001-oracle-coherence-caching.md`
- Original Source URL:
  - https://docs.oracle.com/en/middleware/standalone/coherence/14.1.1.2206/develop-applications/cache-aside-write-through-write-behind.html

## Key Evidence
> "A write-through cache is a caching strategy where every write to the cache also results in a synchronous write to the underlying data store. The cache acts as a proxy for the data store, and the write operation is not considered complete until both the cache and the data store have been updated."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-28-write-through-consistency.md`

## Applicability
- Applies to: distributed cache design where strong consistency between cache and backing store is required; low-write, high-read workloads; financial and configuration data caching
- Does not apply to: high-throughput write workloads where write latency is the bottleneck; scenarios where eventual consistency is acceptable

## Notes
- Confirmed by Oracle Coherence official documentation; the pattern is general and applies beyond Oracle Coherence to any cache implementation
