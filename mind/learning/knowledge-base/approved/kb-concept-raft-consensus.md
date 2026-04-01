# Knowledge Base Entry

## Type
- concept

## Summary
- Raft consensus decomposes into three independent subproblems (leader election, log replication, safety), enforcing stronger coherency to reduce state space complexity

## Source Lineage
- Task ID: 20260401-concurrent-03
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-03.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-03-raft-consensus.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-03-raft-consensus.md`
- Original Source Anchor: `tasks/20260401-concurrent-03/acquire/raw-sources/src-001-raft-paper.md`
- Original Source URL: https://raft.github.io/raft.pdf

## Key Evidence
> "Raft separates the key elements of consensus — leader election, log replication, and safety — and it enforces a stronger degree of coherency to reduce the number of states that must be considered."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-03-raft-consensus.md`

## Applicability
- Applies to: crash-fault-tolerant consensus in distributed systems, replicated state machines, leader-based replication
- Does not apply to: Byzantine fault tolerance scenarios, leaderless consensus models

## Notes
- Raft is equivalent to multi-Paxos in guarantees but designed for understandability
