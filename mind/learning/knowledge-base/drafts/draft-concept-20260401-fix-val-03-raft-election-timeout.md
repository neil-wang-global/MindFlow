# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-03

## Summary
- Raft prevents livelock from repeated split votes using randomized election timeouts (typically 150-300ms), ensuring one server times out first and wins before competitors start; elections typically resolve within one or two extra rounds

## From Task Learning
- `mind/learning/task-learning/tl-20260401-fix-val-03.md`
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-fix-val-03/acquire/raw-sources/src-001-raft-leader-election.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-fix-val-03/acquire/verification-report.md §ACQ-001`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-001)

## Original Excerpt
> "Randomized Election Timeout: This is Raft's mechanism for preventing and resolving split votes. Each server chooses its election timeout randomly from a fixed interval (typically 150-300 ms). This spreads out servers so that in most cases, only a single server times out first, wins the election before others time out, and sends heartbeats to reset their timers. Even if a split vote occurs, randomized timeouts ensure the next election is unlikely to produce another split."

## Candidate Conclusion
- Raft prevents livelock from repeated split votes by using randomized election timeouts drawn from a fixed interval (typically 150-300ms); this stochastic spread ensures that in most cases only one server times out first and wins the election before competitors start, and even after a split vote, the next round is unlikely to deadlock again — elections typically resolve within one or two extra rounds.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-fix-val-03-raft-election-timeout.md`

## Notes
- none
