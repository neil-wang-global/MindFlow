# Knowledge Base Entry

## Type
- concept

## Summary
- Paxos achieves consensus through a two-phase protocol (Prepare/Accept) using majority quorum with monotonically increasing proposal numbers

## Source Lineage
- Task ID: 20260401-concurrent-03
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-03.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-03-paxos-protocol.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-03-paxos-protocol.md`
- Original Source Anchor: `tasks/20260401-concurrent-03/acquire/raw-sources/src-003-paxos-paper.md`
- Original Source URL: https://lamport.azurewebsites.net/pubs/paxos-simple.pdf

## Key Evidence
> "The algorithm operates in two phases: Phase 1 (Prepare): (a) A proposer selects a proposal number n and sends a prepare request with number n to a majority of acceptors. (b) If an acceptor receives a prepare request with number n greater than that of any prepare request to which it has already responded, then it responds with a promise not to accept any more proposals numbered less than n and with the highest-numbered proposal (if any) that it has accepted. Phase 2 (Accept): (a) If the proposer receives a response to its prepare requests from a majority of acceptors, then it sends an accept request with proposal number n and value v, where v is the value of the highest-numbered proposal among the responses, or any value if no proposal was reported. (b) If an acceptor receives an accept request for a proposal numbered n, it accepts the proposal unless it has already responded to a prepare request having a number greater than n."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-03-paxos-protocol.md`

## Applicability
- Applies to: distributed consensus, fault-tolerant state machine replication, distributed databases requiring strong consistency
- Does not apply to: Byzantine fault scenarios, systems requiring low-latency single-round consensus without leader

## Notes
- Multi-Paxos optimizes by electing a stable leader to skip Phase 1 for subsequent proposals
