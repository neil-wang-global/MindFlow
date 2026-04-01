# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-002

## Source URL
- https://martinfowler.com/articles/patterns-of-distributed-systems/paxos.html

## Fetch Timestamp
- 2026-04-01T10:11:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Martin Fowler's distributed systems patterns series

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Paxos — Patterns of Distributed Systems

Paxos is a consensus algorithm that allows a cluster of servers to agree on a single value even when some servers fail. It guarantees safety (consistency) under all non-Byzantine conditions and progress under sufficiently synchronous conditions.

The protocol uses three roles: Proposer (proposes values), Acceptor (votes on proposals), and Learner (learns the chosen value).

Multi-Paxos optimizes the basic protocol for a sequence of values by electing a stable leader. Once a leader is established, Phase 1 can be skipped for subsequent proposals, reducing the protocol to a single round-trip per consensus decision.

Key guarantees:
- Agreement: no two learners learn different values
- Validity: only proposed values can be learned
- Termination: if a majority of acceptors are alive and a proposer can communicate with them, a value is eventually chosen

Paxos tolerates up to f failures with 2f+1 acceptors. It cannot make progress if a majority of acceptors are unavailable.

The main challenge with Paxos is liveness — competing proposers can create a livelock scenario where no value is ever accepted. This is typically resolved with leader election.
