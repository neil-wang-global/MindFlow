# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-30

## Summary
- Bully algorithm: leader election protocol for fully connected networks where highest-ID process becomes coordinator using ELECTION/ANSWER/COORDINATOR messages with O(n^2) worst-case complexity

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-30.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-30/acquire/raw-sources/src-001-bully-algorithm.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-30/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "The Bully Algorithm was proposed by Hector Garcia-Molina in 1982. It is used in distributed systems to elect a coordinator (leader) among a group of processes."

## Candidate Conclusion
The Bully algorithm is a leader election protocol for fully connected networks where the process with the highest ID always becomes coordinator. It uses three message types (ELECTION, ANSWER, COORDINATOR) and has O(n^2) worst-case message complexity. It is self-stabilizing after failures but requires all processes to know each other's IDs.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-30-bully-algorithm.md

## Notes
- none
