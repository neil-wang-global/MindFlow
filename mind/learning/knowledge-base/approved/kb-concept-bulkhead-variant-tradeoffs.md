# Knowledge Base Entry

## Type
- concept

## Summary
- Bulkhead variant selection involves a trade-off between isolation strength and resource overhead. Thread pools provide moderate isolation with moderate overhead, semaphores provide concurrency limiting with low overhead but no latency isolation, and process/container-level isolation provides the strongest isolation at the highest resource cost. The Azure documentation frames this as a technology-level decision that must balance isolation, cost, performance, and manageability.

## Source Lineage
- Task ID: 20260401-concurrent-22
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-22.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-22-bulkhead-variant-tradeoffs.md
- Review File: mind/learning/reviews/review-20260401-concurrent-22-bulkhead-variant-tradeoffs.md
- Original Source Anchor: tasks/20260401-concurrent-22/acquire/raw-sources/src-001-azure-bulkhead-pattern.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/patterns/bulkhead

## Key Evidence
> "When you partition services or consumers into bulkheads, consider the level of isolation offered by the technology and the overhead in terms of cost, performance, and manageability."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-22-bulkhead-variant-tradeoffs.md

## Applicability
- Applies to: architecture decisions involving bulkhead pattern implementation; selecting between thread pool, semaphore, and process-level isolation strategies; evaluating overhead vs isolation trade-offs for resilience patterns
- Does not apply to: non-distributed systems with no isolation requirements; systems with fixed isolation requirements (e.g., regulatory mandates that specify process-level isolation regardless of overhead)

## Notes
- Grounded in Microsoft Azure Architecture Center documentation; independently verified via ACQ-001
- The trade-off spectrum is: semaphore (lowest overhead, weakest isolation) -> thread pool (moderate overhead, moderate isolation) -> process/container (highest overhead, strongest isolation)
