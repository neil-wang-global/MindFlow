# Knowledge Base Entry

## Type
- concept

## Summary
- Raft prevents livelock from repeated split votes by using randomized election timeouts drawn from a fixed interval (typically 150-300ms); this stochastic spread ensures that in most cases only one server times out first and wins the election before competitors start, and even after a split vote, the next round is unlikely to deadlock again -- elections typically resolve within one or two extra rounds

## Source Lineage
- Task ID: 20260401-fix-val-03
- Task Learning Record: `mind/learning/task-learning/tl-20260401-fix-val-03.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-03-raft-election-timeout.md`
- Review File: `mind/learning/reviews/review-20260401-fix-val-03-raft-election-timeout.md`
- Original Source Anchor: `tasks/20260401-fix-val-03/acquire/raw-sources/src-001-raft-leader-election.md`
- Original Source URL: https://raft.github.io/raft.pdf

## Key Evidence
> "Randomized Election Timeout: This is Raft's mechanism for preventing and resolving split votes. Each server chooses its election timeout randomly from a fixed interval (typically 150-300 ms). This spreads out servers so that in most cases, only a single server times out first, wins the election before others time out, and sends heartbeats to reset their timers. Even if a split vote occurs, randomized timeouts ensure the next election is unlikely to produce another split."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-fix-val-03-raft-election-timeout.md`

## Applicability
- Applies to: Raft-based consensus systems, understanding split vote prevention and liveness guarantees in leader election protocols, distributed system timeout design
- Does not apply to: deterministic leader election protocols, Byzantine fault tolerance scenarios, protocols without election timeout (e.g., Paxos proposer selection)

## Notes
- Complements existing `kb-concept-raft-consensus.md` and new `kb-concept-raft-leader-election.md`; this entry focuses specifically on the randomized timeout mechanism for split vote prevention
