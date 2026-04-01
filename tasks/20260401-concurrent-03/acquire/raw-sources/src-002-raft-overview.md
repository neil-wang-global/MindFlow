# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://raft.github.io/

## Fetch Timestamp
- 2026-04-01T10:01:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Raft consensus algorithm website

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

The Raft Consensus Algorithm

Raft is a consensus algorithm that is designed to be easy to understand. It's equivalent to Paxos in fault-tolerance and performance. The difference is that it's decomposed into relatively independent subproblems, and it cleanly addresses all major pieces needed for practical systems.

Raft implements consensus by first electing a distinguished leader, then giving the leader complete responsibility for managing the replicated log. The leader accepts log entries from clients, replicates them on other servers, and tells servers when it is safe to apply log entries to their state machines.

Key properties:
- Election Safety: at most one leader can be elected in a given term
- Leader Append-Only: a leader never overwrites or deletes entries in its log
- Log Matching: if two logs contain an entry with the same index and term, then the logs are identical in all entries up through the given index
- Leader Completeness: if a log entry is committed in a given term, then that entry will be present in the logs of the leaders for all higher-numbered terms
- State Machine Safety: if a server has applied a log entry at a given index to its state machine, no other server will ever apply a different log entry for the same index
