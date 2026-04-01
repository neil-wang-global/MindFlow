# Raw Source

## Source ID
- src-006

## ACQ Event
- ACQ-003

## Source URL
- https://decentralizedthoughts.github.io/2019-12-22-PBFT/

## Fetch Timestamp
- 2026-04-01T10:21:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Decentralized Thoughts academic blog by distributed systems researchers

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Understanding PBFT

Practical Byzantine Fault Tolerance (PBFT) is a consensus protocol designed to work in asynchronous environments with Byzantine failures. It was introduced by Castro and Liskov in 1999.

PBFT requires 3f+1 nodes to tolerate f Byzantine faults. The protocol operates through a three-phase commit process: pre-prepare, prepare, and commit.

The primary (leader) orders client requests by assigning sequence numbers. If the primary is faulty, replicas can trigger a view change to elect a new primary.

Key properties:
- Safety: all non-faulty replicas agree on the order of requests (even with Byzantine faults)
- Liveness: the system eventually responds to client requests (requires partial synchrony)
- Optimal resilience: 3f+1 is the minimum number of replicas for BFT consensus

PBFT communication complexity is O(n^2) per consensus round due to the all-to-all message exchange pattern. This limits scalability to tens of replicas in practice.

Compared to crash-fault-tolerant algorithms like Raft (2f+1 nodes for f crash faults), PBFT's 3f+1 requirement and higher message complexity reflect the cost of tolerating arbitrary (Byzantine) behavior.
