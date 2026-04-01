# Knowledge Base Entry

## Type
- concept

## Summary
- Thundering herd in cache invalidation occurs when a popular entry is invalidated and many concurrent reads simultaneously attempt to refill, mitigated through lease mechanisms granting refill rights to exactly one reader

## Source Lineage
- Task ID: 20260401-concurrent-28
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-28.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-28-thundering-herd-mitigation.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-28-thundering-herd-mitigation.md`
- Original Source Anchor:
  - `tasks/20260401-concurrent-28/acquire/raw-sources/src-002-facebook-tao.md`
- Original Source URL:
  - https://engineering.fb.com/2013/06/25/core-infra/tao-the-power-of-the-graph/

## Key Evidence
> "When a popular cache entry is invalidated, many concurrent reads may attempt to refill the entry simultaneously, causing a \"thundering herd\" on the database."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-28-thundering-herd-mitigation.md`

## Applicability
- Applies to: distributed cache architectures with high read concurrency; systems using TTL-based or event-driven invalidation on popular keys; multi-tier cache hierarchies
- Does not apply to: low-concurrency caching scenarios; caches where key popularity is uniformly distributed

## Notes
- Documented from Facebook's TAO production system; additional mitigation strategies beyond leases include stale-while-revalidate and refill suppression (coalescing concurrent backing store queries)
