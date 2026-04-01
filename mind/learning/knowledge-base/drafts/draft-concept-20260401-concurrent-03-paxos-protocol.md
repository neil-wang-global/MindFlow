# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-03

## Summary
- Paxos achieves consensus through a two-phase protocol (Prepare/Accept) using majority quorum with monotonically increasing proposal numbers

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-03.md`
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-03/acquire/raw-sources/src-003-paxos-paper.md`
- ACQ Event: ACQ-002
- Verification Report: `tasks/20260401-concurrent-03/acquire/verification-report.md` §ACQ-002
- Verification Status: passed

## Original Excerpt
> "The algorithm operates in two phases: Phase 1 (Prepare): (a) A proposer selects a proposal number n and sends a prepare request with number n to a majority of acceptors. (b) If an acceptor receives a prepare request with number n greater than that of any prepare request to which it has already responded, then it responds with a promise not to accept any more proposals numbered less than n and with the highest-numbered proposal (if any) that it has accepted. Phase 2 (Accept): (a) If the proposer receives a response to its prepare requests from a majority of acceptors, then it sends an accept request with proposal number n and value v, where v is the value of the highest-numbered proposal among the responses, or any value if no proposal was reported. (b) If an acceptor receives an accept request for a proposal numbered n, it accepts the proposal unless it has already responded to a prepare request having a number greater than n."

## Candidate Conclusion
Paxos achieves consensus through a two-phase protocol (Prepare/Accept) using majority quorum: proposers select monotonically increasing proposal numbers, acceptors promise exclusivity to highest-numbered proposals, and acceptance requires majority agreement

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-03-paxos-protocol.md`

## Notes
- none
