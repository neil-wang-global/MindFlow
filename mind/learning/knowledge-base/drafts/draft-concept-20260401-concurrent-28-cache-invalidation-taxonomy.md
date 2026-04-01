# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-28

## Summary
- Four cache invalidation strategies (write-through, write-behind, TTL-based, event-driven) form a taxonomy with distinct consistency-latency-complexity trade-offs

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-28.md`
- candidate knowledge item reference: KDC-001

## Source Type
- task-output

## Source Anchor
- `tasks/20260401-concurrent-28/_output/cache-invalidation-strategies.md §Comparison Matrix`

## Original Excerpt
> "| Strategy | Consistency | Write Latency | Read Latency | Complexity | Data Loss Risk | Best For |
|----------|-----------|---------------|-------------|-----------|---------------|----------|
| Write-Through | Strong | High | Low | Low | None | Low-write, high-read workloads |
| Write-Behind | Eventual | Very Low | Low | Medium-High | High (cache failure) | High-throughput writes |
| TTL-Based | Bounded staleness | N/A | Low (within TTL) | Low | None (staleness only) | Predictable change rates |
| Event-Driven | Near-real-time | Same as direct | Low | High | Medium (event loss) | Multi-region, CDC-ready systems |"

## Candidate Conclusion
- Four cache invalidation strategies form a taxonomy with distinct consistency-latency-complexity trade-offs: write-through provides strong consistency at high write latency; write-behind minimizes write latency but risks data loss; TTL-based offers bounded staleness with low complexity; event-driven achieves near-real-time consistency at high operational complexity.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-28-cache-invalidation-taxonomy.md`

## Notes
- none
