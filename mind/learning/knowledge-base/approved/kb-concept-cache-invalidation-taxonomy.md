# Knowledge Base Entry

## Type
- concept

## Summary
- Four cache invalidation strategies (write-through, write-behind, TTL-based, event-driven) form a taxonomy with distinct consistency-latency-complexity trade-offs: write-through provides strong consistency at high write latency; write-behind minimizes write latency but risks data loss; TTL-based offers bounded staleness with low complexity; event-driven achieves near-real-time consistency at high operational complexity

## Source Lineage
- Task ID: 20260401-concurrent-28
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-28.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-28-cache-invalidation-taxonomy.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-28-cache-invalidation-taxonomy.md`
- Original Source Anchor:
  - `tasks/20260401-concurrent-28/_output/cache-invalidation-strategies.md §Comparison Matrix`

## Key Evidence
> "| Strategy | Consistency | Write Latency | Read Latency | Complexity | Data Loss Risk | Best For |
|----------|-----------|---------------|-------------|-----------|---------------|----------|
| Write-Through | Strong | High | Low | Low | None | Low-write, high-read workloads |
| Write-Behind | Eventual | Very Low | Low | Medium-High | High (cache failure) | High-throughput writes |
| TTL-Based | Bounded staleness | N/A | Low (within TTL) | Low | None (staleness only) | Predictable change rates |
| Event-Driven | Near-real-time | Same as direct | Low | High | Medium (event loss) | Multi-region, CDC-ready systems |"

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-28-cache-invalidation-taxonomy.md`

## Applicability
- Applies to: distributed system design decisions involving caching layer architecture; cache strategy selection for new services; trade-off analysis when choosing between consistency and latency
- Does not apply to: CPU-level cache invalidation; single-process in-memory caching without persistence; application-specific cache key design

## Notes
- This taxonomy covers the four most common strategies; hybrid approaches (e.g., TTL + event-driven) are common in production but are not listed as a separate strategy
