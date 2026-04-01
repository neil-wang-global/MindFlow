# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-003

## Source URL
- https://pmg.csail.mit.edu/papers/osdi99.pdf

## Fetch Timestamp
- 2026-04-01T10:20:00Z

## Source Type
- Academic Article

## Credibility Assessment
- High — Castro and Liskov's original PBFT paper (MIT)

## Fetch Status
- success

## Fetch Completeness
- truncated — tool output limit; key sections preserved

## Original Content

Practical Byzantine Fault Tolerance
Miguel Castro and Barbara Liskov, MIT

This paper describes a new replication algorithm that is able to tolerate Byzantine faults. The algorithm provides liveness and safety provided at most floor((n-1)/3) out of a total of n replicas are faulty.

The algorithm works in three phases:

1. Pre-prepare: The primary assigns a sequence number to the request and multicasts a pre-prepare message to the other replicas.

2. Prepare: If a backup accepts the pre-prepare message, it enters the prepare phase by multicasting a prepare message to all other replicas. A replica is prepared when it has the pre-prepare and 2f matching prepare messages.

3. Commit: When a replica is prepared, it multicasts a commit message. A replica commits when it has 2f+1 matching commit messages (including its own).

The algorithm requires 3f+1 replicas to tolerate f Byzantine failures. This bound is optimal — any algorithm solving Byzantine agreement requires at least 3f+1 replicas.

View changes are used when the primary appears faulty. A backup triggers a view change by multicasting a view-change message after a timeout expires without completing a request.
