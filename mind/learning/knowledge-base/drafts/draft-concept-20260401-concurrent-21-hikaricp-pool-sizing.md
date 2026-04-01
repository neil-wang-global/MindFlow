# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-21

## Summary
- Connection pool sizing should follow the formula `connections = ((core_count * 2) + effective_spindle_count)`, producing smaller pools than intuition suggests, because larger pools cause CPU context switching and I/O contention

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-21.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-21/acquire/raw-sources/src-001-hikaricp-pool-sizing.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-concurrent-21/acquire/verification-report.md` §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "The PostgreSQL project published a formula that has been widely adopted:\n\n```\nconnections = ((core_count * 2) + effective_spindle_count)\n```\n\nWhere:\n- `core_count` is the number of CPU cores available on the database server\n- `effective_spindle_count` is the number of hard disk spindles (for modern SSDs, this is effectively 1)\n\nA server with a 4-core CPU and a single SSD-backed volume should have a pool size of roughly `((4 * 2) + 1) = 9`. Call it 10 as a nice round number."

## Candidate Conclusion
- Connection pool sizing should follow the formula `connections = ((core_count * 2) + effective_spindle_count)`, producing significantly smaller pools than intuition suggests. For a 4-core server with SSD, the optimal pool size is approximately 9-10 connections, even under high concurrent user load, because larger pools cause CPU context switching and I/O contention at the database level.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-21-hikaricp-pool-sizing.md

## Notes
- none
