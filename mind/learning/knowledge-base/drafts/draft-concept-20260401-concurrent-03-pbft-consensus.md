# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-03

## Summary
- PBFT achieves Byzantine fault tolerance through a three-phase commit protocol requiring 3f+1 replicas, with 2f matching messages needed at each phase

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-03.md`
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-03/acquire/raw-sources/src-005-pbft-paper.md`
- ACQ Event: ACQ-003
- Verification Report: `tasks/20260401-concurrent-03/acquire/verification-report.md` §ACQ-003
- Verification Status: passed

## Original Excerpt
> "The algorithm works in three phases: 1. Pre-prepare: The primary assigns a sequence number to the request and multicasts a pre-prepare message to the other replicas. 2. Prepare: If a backup accepts the pre-prepare message, it enters the prepare phase by multicasting a prepare message to all other replicas. A replica is prepared when it has the pre-prepare and 2f matching prepare messages. 3. Commit: When a replica is prepared, it multicasts a commit message. A replica commits when it has 2f+1 matching commit messages (including its own)."

## Candidate Conclusion
PBFT achieves Byzantine fault tolerance through a three-phase commit protocol (pre-prepare, prepare, commit) requiring 3f+1 replicas for f Byzantine faults, where agreement requires collecting 2f matching messages at each phase

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-03-pbft-consensus.md`

## Notes
- none
