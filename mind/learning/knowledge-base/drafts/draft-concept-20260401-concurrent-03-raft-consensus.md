# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-03

## Summary
- Raft consensus decomposes into three independent subproblems (leader election, log replication, safety), enforcing stronger coherency to reduce state space complexity

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-03.md`
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-03/acquire/raw-sources/src-001-raft-paper.md`
- ACQ Event: ACQ-001
- Verification Report: `tasks/20260401-concurrent-03/acquire/verification-report.md` §ACQ-001
- Verification Status: passed

## Original Excerpt
> "Raft separates the key elements of consensus — leader election, log replication, and safety — and it enforces a stronger degree of coherency to reduce the number of states that must be considered."

## Candidate Conclusion
Raft consensus decomposes into three independent subproblems (leader election, log replication, safety), enforcing stronger coherency than Paxos to reduce state space complexity

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-03-raft-consensus.md`

## Notes
- none
