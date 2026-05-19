# Knowledge Base Entry

## Type
- concept

## Summary
- Raft leader election uses a RequestVote RPC mechanism where a candidate increments its term, self-votes, and solicits votes from all peers in parallel; each peer votes for at most one candidate per term (first-come-first-served), and the RPC includes log completeness information (last log index and term) enabling voters to reject candidates with less up-to-date logs, ensuring the Leader Completeness property

## Source Lineage
- Task ID: 20260401-fix-val-03
- Task Learning Record: `mind/learning/task-learning/tl-20260401-fix-val-03.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-03-raft-leader-election.md`
- Review File: `mind/learning/reviews/review-20260401-fix-val-03-raft-leader-election.md`
- Original Source Anchor: `tasks/20260401-fix-val-03/acquire/raw-sources/src-001-raft-leader-election.md`
- Original Source URL: https://raft.github.io/raft.pdf

## Key Evidence
> "RequestVote RPC: The candidate increments its current term, votes for itself, and sends RequestVote RPCs in parallel to all other servers in the cluster. Each server votes for at most one candidate per term, on a first-come-first-served basis. The RequestVote RPC includes the candidate's term number and log information (last log index and last log term) so that voters can ensure they only vote for candidates with logs at least as up-to-date as their own."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-fix-val-03-raft-leader-election.md`

## Applicability
- Applies to: Raft-based consensus systems, leader-based replicated state machines, understanding vote solicitation and leader election safety in crash-fault-tolerant distributed systems
- Does not apply to: Byzantine fault tolerance scenarios, leaderless consensus models (e.g., EPaxos), multi-leader replication

## Notes
- Complements existing `kb-concept-raft-consensus.md` which covers high-level Raft decomposition; this entry provides depth on the leader election subproblem
