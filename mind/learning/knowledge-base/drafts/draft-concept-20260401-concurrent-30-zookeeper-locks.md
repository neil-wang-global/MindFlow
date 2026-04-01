# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-30

## Summary
- ZooKeeper implements distributed locks as recipes using ephemeral sequential znodes with automatic crash cleanup, FIFO ordering, and targeted watches to avoid herd effect

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-30.md
- candidate knowledge item reference: KDC-005

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-30/acquire/raw-sources/src-005-zookeeper-locks.md
  - ACQ Event: ACQ-002
  - Verification Report: tasks/20260401-concurrent-30/acquire/verification-report.md §ACQ-002
  - Verification Status: passed

## Original Excerpt
> "Fully distributed locks that are globally synchronous, meaning at any snapshot in time no two clients think they hold the same lock. These can be implemented using ZooKeeper."

## Candidate Conclusion
ZooKeeper implements distributed locks as recipes built from coordination primitives (ephemeral sequential znodes) rather than as first-class operations. The design provides three key properties: automatic lock release on client crash via ephemeral nodes, fair FIFO ordering via sequential node numbering, and avoidance of the "herd effect" through targeted watches on immediate predecessor nodes. This approach supports both exclusive write locks and shared read locks.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-30-zookeeper-locks.md

## Notes
- none
