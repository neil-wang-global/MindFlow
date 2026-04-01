# Knowledge Base Entry

## Type
- concept

## Summary
- Three mathematically defined jitter strategies exist for exponential backoff in distributed retry systems: (1) Full Jitter randomizes the entire delay from zero to the exponential ceiling, providing maximum spread; (2) Equal Jitter guarantees a minimum wait of half the exponential delay while adding randomness to the other half; (3) Decorrelated Jitter uses the previous sleep value rather than attempt number, creating state-dependent delays. Full Jitter provides the best performance in contention scenarios with lowest total completion time and fewest calls.

## Source Lineage
- Task ID: 20260401-concurrent-06
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-06.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-06-jitter-strategies.md
- Review File: mind/learning/reviews/review-20260401-concurrent-06-jitter-strategies.md
- Original Source Anchor: tasks/20260401-concurrent-06/acquire/raw-sources/src-001-aws-backoff-jitter.md
- Original Source URL: https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/

## Key Evidence
> "The solution is to add randomness — "jitter" — to the backoff time. We tested three jitter approaches:\n\n### Full Jitter\n\n```\nsleep = random_between(0, min(cap, base * 2 ** attempt))\n```\n\nFull Jitter randomizes the entire backoff value from zero to the exponential ceiling. This gives the best spread across retry attempts.\n\n### Equal Jitter\n\n```\ntemp = min(cap, base * 2 ** attempt)\nsleep = temp / 2 + random_between(0, temp / 2)\n```\n\nEqual Jitter takes half of the exponential backoff as a guaranteed minimum, then adds a random component for the other half. This provides a floor that ensures callers always wait at least some time.\n\n### Decorrelated Jitter\n\n```\nsleep = min(cap, random_between(base, sleep * 3))\n```\n\nDecorrelated Jitter is different from the other two: instead of using the attempt number to determine the exponential ceiling, it uses the previous sleep value. Each retry's delay depends on the last delay, creating a more decorrelated pattern."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-06-jitter-strategies.md

## Applicability
- Applies to: retry logic in distributed systems, client-server communication, microservice-to-microservice calls, message queue consumers, any scenario where multiple callers may retry simultaneously
- Does not apply to: non-retry delay scenarios, rate limiting (use token bucket instead), scenarios requiring deterministic timing, single-caller systems where thundering herd cannot occur

## Notes
- none
