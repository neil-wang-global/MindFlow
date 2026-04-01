# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-06

## Summary
- Three jitter strategies for exponential backoff: Full Jitter (random 0 to ceiling, best spread), Equal Jitter (guaranteed half-minimum plus random), Decorrelated Jitter (state-dependent using previous sleep value)

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-06.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-06/acquire/raw-sources/src-001-aws-backoff-jitter.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-06/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "The solution is to add randomness — "jitter" — to the backoff time. We tested three jitter approaches:\n\n### Full Jitter\n\n```\nsleep = random_between(0, min(cap, base * 2 ** attempt))\n```\n\nFull Jitter randomizes the entire backoff value from zero to the exponential ceiling. This gives the best spread across retry attempts.\n\n### Equal Jitter\n\n```\ntemp = min(cap, base * 2 ** attempt)\nsleep = temp / 2 + random_between(0, temp / 2)\n```\n\nEqual Jitter takes half of the exponential backoff as a guaranteed minimum, then adds a random component for the other half. This provides a floor that ensures callers always wait at least some time.\n\n### Decorrelated Jitter\n\n```\nsleep = min(cap, random_between(base, sleep * 3))\n```\n\nDecorrelated Jitter is different from the other two: instead of using the attempt number to determine the exponential ceiling, it uses the previous sleep value. Each retry's delay depends on the last delay, creating a more decorrelated pattern."

## Candidate Conclusion
- Three mathematically defined jitter strategies exist for exponential backoff in distributed retry systems: (1) Full Jitter randomizes the entire delay from zero to the exponential ceiling, providing maximum spread; (2) Equal Jitter guarantees a minimum wait of half the exponential delay while adding randomness to the other half; (3) Decorrelated Jitter uses the previous sleep value rather than attempt number, creating state-dependent delays. Full Jitter provides the best performance in contention scenarios with lowest total completion time and fewest calls.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-06-jitter-strategies.md

## Notes
- none
