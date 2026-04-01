# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-30

## Summary
- Redlock achieves distributed mutual exclusion across N independent Redis masters using majority quorum without replication, providing safety, deadlock freedom, and fault tolerance

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-30.md
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-30/acquire/raw-sources/src-003-redlock-algorithm.md
  - ACQ Event: ACQ-002
  - Verification Report: tasks/20260401-concurrent-30/acquire/verification-report.md §ACQ-002
  - Verification Status: passed

## Original Excerpt
> "In the distributed version of the algorithm we assume we have N Redis masters. These nodes are totally independent, so we don't use replication or any other implicit coordination system."

## Candidate Conclusion
Redlock achieves distributed mutual exclusion across N independent Redis masters (recommended N=5) using a majority quorum approach without replication. It provides three guarantees: mutual exclusion (safety), deadlock freedom via TTL auto-release (liveness A), and fault tolerance as long as majority nodes are up (liveness B). The algorithm addresses the safety violation possible with single-master-plus-replica Redis lock setups where master crash before replication can grant the same lock to two clients.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-30-redlock-algorithm.md

## Notes
- none
