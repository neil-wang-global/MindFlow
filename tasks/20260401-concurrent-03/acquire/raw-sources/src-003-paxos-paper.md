# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-002

## Source URL
- https://lamport.azurewebsites.net/pubs/paxos-simple.pdf

## Fetch Timestamp
- 2026-04-01T10:10:00Z

## Source Type
- Academic Article

## Credibility Assessment
- High — Leslie Lamport's simplified Paxos explanation

## Fetch Status
- success

## Fetch Completeness
- truncated — tool output limit; key sections preserved

## Original Content

Paxos Made Simple
Leslie Lamport
01 Nov 2001

The Paxos algorithm for implementing a fault-tolerant distributed system has been regarded as difficult to understand. This paper gives a simple description of the algorithm.

The consensus algorithm involves three classes of agents: proposers, acceptors, and learners. A single agent may act as more than one kind of agent.

The algorithm operates in two phases:

Phase 1 (Prepare):
(a) A proposer selects a proposal number n and sends a prepare request with number n to a majority of acceptors.
(b) If an acceptor receives a prepare request with number n greater than that of any prepare request to which it has already responded, then it responds with a promise not to accept any more proposals numbered less than n and with the highest-numbered proposal (if any) that it has accepted.

Phase 2 (Accept):
(a) If the proposer receives a response to its prepare requests from a majority of acceptors, then it sends an accept request with proposal number n and value v, where v is the value of the highest-numbered proposal among the responses, or any value if no proposal was reported.
(b) If an acceptor receives an accept request for a proposal numbered n, it accepts the proposal unless it has already responded to a prepare request having a number greater than n.

Safety is guaranteed: only a single value is chosen, and a value is chosen only after it has been proposed.
