# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-22

## Summary
- Bulkhead variant selection involves a trade-off between isolation strength and resource overhead, balanced across isolation level, cost, performance, and manageability.

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-22.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-22/acquire/raw-sources/src-001-azure-bulkhead-pattern.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-22/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "When you partition services or consumers into bulkheads, consider the level of isolation offered by the technology and the overhead in terms of cost, performance, and manageability."

## Candidate Conclusion
Bulkhead variant selection involves a trade-off between isolation strength and resource overhead. Thread pools provide moderate isolation with moderate overhead, semaphores provide concurrency limiting with low overhead but no latency isolation, and process/container-level isolation provides the strongest isolation at the highest resource cost. The Azure documentation frames this as a technology-level decision that must balance isolation, cost, performance, and manageability.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-22-bulkhead-variant-tradeoffs.md

## Notes
- none
