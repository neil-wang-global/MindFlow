# Knowledge Base Entry

## Type
- concept

## Summary
- PBFT achieves Byzantine fault tolerance through a three-phase commit protocol requiring 3f+1 replicas, with 2f matching messages needed at each phase

## Source Lineage
- Task ID: 20260401-concurrent-03
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-03.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-03-pbft-consensus.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-03-pbft-consensus.md`
- Original Source Anchor: `tasks/20260401-concurrent-03/acquire/raw-sources/src-005-pbft-paper.md`
- Original Source URL: https://pmg.csail.mit.edu/papers/osdi99.pdf

## Key Evidence
> "The algorithm works in three phases: 1. Pre-prepare: The primary assigns a sequence number to the request and multicasts a pre-prepare message to the other replicas. 2. Prepare: If a backup accepts the pre-prepare message, it enters the prepare phase by multicasting a prepare message to all other replicas. A replica is prepared when it has the pre-prepare and 2f matching prepare messages. 3. Commit: When a replica is prepared, it multicasts a commit message. A replica commits when it has 2f+1 matching commit messages (including its own)."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-03-pbft-consensus.md`

## Applicability
- Applies to: Byzantine fault-tolerant consensus, permissioned blockchain systems, systems requiring tolerance of arbitrary node failures
- Does not apply to: crash-only fault models (where Raft/Paxos are more efficient), large-scale systems (O(n^2) complexity limits scalability)

## Notes
- PBFT requires 3f+1 nodes vs 2f+1 for crash-fault algorithms like Raft; the extra overhead reflects the cost of tolerating arbitrary behavior
