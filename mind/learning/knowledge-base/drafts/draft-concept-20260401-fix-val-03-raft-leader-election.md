# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-03

## Summary
- Raft leader election uses RequestVote RPC where a candidate increments its term, self-votes, and solicits votes from all peers in parallel; each peer votes for at most one candidate per term (first-come-first-served), with log completeness information ensuring the Leader Completeness property

## From Task Learning
- `mind/learning/task-learning/tl-20260401-fix-val-03.md`
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-fix-val-03/acquire/raw-sources/src-001-raft-leader-election.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-fix-val-03/acquire/verification-report.md §ACQ-001`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-001)

## Original Excerpt
> "RequestVote RPC: The candidate increments its current term, votes for itself, and sends RequestVote RPCs in parallel to all other servers in the cluster. Each server votes for at most one candidate per term, on a first-come-first-served basis. The RequestVote RPC includes the candidate's term number and log information (last log index and last log term) so that voters can ensure they only vote for candidates with logs at least as up-to-date as their own."

## Candidate Conclusion
- Raft leader election uses a RequestVote RPC mechanism where a candidate increments its term, self-votes, and solicits votes from all peers in parallel; each peer votes for at most one candidate per term (first-come-first-served), and the RPC includes log completeness information (last log index and term) enabling voters to reject candidates with less up-to-date logs, ensuring the Leader Completeness property.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-fix-val-03-raft-leader-election.md`

## Notes
- none
