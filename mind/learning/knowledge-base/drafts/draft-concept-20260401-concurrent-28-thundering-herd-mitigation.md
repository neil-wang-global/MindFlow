# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-28

## Summary
- Thundering herd in cache invalidation is mitigated by lease mechanisms granting refill rights to one reader

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-28.md`
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-28/acquire/raw-sources/src-002-facebook-tao.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-concurrent-28/acquire/verification-report.md §ACQ-001`
  - Verification Status: passed

## Original Excerpt
> "When a popular cache entry is invalidated, many concurrent reads may attempt to refill the entry simultaneously, causing a \"thundering herd\" on the database."

## Candidate Conclusion
- Facebook's TAO system confirms the thundering herd problem as a real production concern in cache invalidation, mitigated through lease mechanisms that grant refill rights to exactly one reader while others wait or receive stale data.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-28-thundering-herd-mitigation.md`

## Notes
- none
