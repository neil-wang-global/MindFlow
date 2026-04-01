# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://raft.github.io/raft.pdf

## Fetch Timestamp
- 2026-04-01T10:00:00Z

## Source Type
- Academic Article

## Credibility Assessment
- High — original Raft paper by Ongaro and Ousterhout (Stanford)

## Fetch Status
- success

## Fetch Completeness
- truncated — tool output limit; key sections preserved

## Original Content

In Search of an Understandable Consensus Algorithm (Extended Version)
Diego Ongaro and John Ousterhout, Stanford University

Raft is a consensus algorithm for managing a replicated log. It produces a result equivalent to (multi-)Paxos, and it is as efficient as Paxos, but its structure is different from Paxos; this makes Raft more understandable than Paxos and also provides a better foundation for building practical systems.

Raft separates the key elements of consensus — leader election, log replication, and safety — and it enforces a stronger degree of coherency to reduce the number of states that must be considered.

Leader Election: Raft uses a heartbeat mechanism to trigger leader election. A server begins an election by incrementing its current term and transitioning to candidate state. It votes for itself and issues RequestVote RPCs in parallel to each of the other servers.

Log Replication: The leader accepts log entries from clients, replicates them on other servers, and tells servers when it is safe to apply log entries to their state machines. A log entry is committed once the leader has replicated it on a majority of the servers.

Safety: Raft guarantees the Leader Completeness Property: if a log entry is committed in a given term, then that entry will be present in the logs of the leaders for all higher-numbered terms. This is ensured by the election restriction: a candidate must have all committed entries to win an election.
