# Distributed Coordination Research

## Task ID
- 20260401-concurrent-30

## Overview

This document consolidates research on distributed coordination mechanisms across two domains: leader election algorithms and distributed locking mechanisms. Both domains address the fundamental challenge of achieving coordination among distributed processes in the presence of failures.

---

## Part 1: Leader Election Algorithms

Leader election is a fundamental distributed computing problem where a set of processes must agree on a single process to act as coordinator. The elected leader handles centralized tasks such as mutual exclusion, transaction management, and failure recovery.

### 1.1 Bully Algorithm (Garcia-Molina, 1982)

**Source**: src-001 (Colorado State University CS551 course material)

The Bully algorithm operates on a fully connected network where every process knows all other processes' IDs.

**Mechanism**:
- When a process detects coordinator failure (via timeout), it sends ELECTION messages to all higher-ID processes
- If no ANSWER is received within timeout, the initiator declares itself coordinator via COORDINATOR messages
- If an ANSWER is received, the responder initiates its own election
- The highest-alive-ID process always wins (hence "bully")

**Message Complexity**:
- Best case: O(n) — second-highest ID detects failure
- Worst case: O(n^2) — lowest-ID process initiates cascade

**Failure Handling**:
- Self-stabilizing: any process detecting coordinator failure restarts election
- Handles coordinator failure during election by restarting

**Limitations**:
- Requires complete process knowledge (all IDs known to all)
- High worst-case message overhead
- Not suitable for networks with frequent partitions
- Highest ID always wins regardless of capability

### 1.2 Ring Algorithm (Chang-Roberts, 1979)

**Source**: src-002 (UIC distributed computing textbook Chapter 9)

The Chang-Roberts algorithm operates on a unidirectional ring topology.

**Mechanism**:
- Any process initiates by sending ELECTION message with its ID clockwise
- Forwarding rules: forward if incoming ID > own ID; replace with own if incoming ID < own ID
- When a process receives its own ID, it is the leader; sends COORDINATOR message around ring

**Message Complexity**:
- Best case: O(n) — highest-ID process initiates
- Worst case: O(n^2) — decreasing ID order around ring
- Average case: O(n log n) (proven by Chang and Roberts)

**Comparison with Bully**:

| Property | Bully | Ring (Chang-Roberts) |
|----------|-------|---------------------|
| Topology | Fully connected | Unidirectional ring |
| Average messages | O(n^2) | O(n log n) |
| Process knowledge | All IDs required | Only neighbor known |
| Failure recovery | Simple restart | More complex |

**Key Insight**: In asynchronous systems without failure detectors, leader election is equivalent to consensus (FLP impossibility applies). Modern systems (ZooKeeper, Raft, etcd) embed election within consensus protocols.

---

## Part 2: Distributed Locking Mechanisms

Distributed locks provide mutual exclusion across processes in a distributed system. Three major approaches are examined: Redlock (Redis-based), Chubby (Google), and ZooKeeper locks (Apache).

### 2.1 Redlock Algorithm (Redis)

**Source**: src-003 (Redis official documentation)

Redlock is a distributed lock algorithm designed for Redis deployments with multiple independent masters.

**Design**: N=5 independent Redis masters with no replication between them. Lock acquisition requires majority quorum (at least 3 of 5).

**Properties**:
- Safety: mutual exclusion via majority quorum (N/2+1 SET NX operations needed)
- Liveness A: deadlock-free via TTL auto-release
- Liveness B: fault tolerant as long as majority of nodes are up

**Lock Acquisition**:
1. Record current time
2. Try to acquire lock on all N instances sequentially with small per-instance timeout
3. Lock is acquired if majority respond AND total elapsed time < lock validity time
4. Effective validity = initial TTL minus acquisition time
5. On failure, unlock all instances

**Key Concern**: Single-instance Redis lock with replication is unsafe — master crash before replication creates a window where two clients hold the same lock.

### 2.2 Google Chubby Lock Service (Burrows, OSDI 2006)

**Source**: src-004 (Google Research paper)

Chubby is a lock service designed for coarse-grained locking in loosely-coupled distributed systems, built on Paxos consensus.

**Architecture**: 5-replica cell with Paxos-elected master. All operations route through master. File-system-like interface (`/ls/cell/path`).

**Lock Semantics**:
- Advisory locks (not mandatory) on files and directories
- Exclusive (writer) and Shared (reader) modes
- Sequencers: opaque byte strings proving lock ownership — prevents stale lock usage

**Design Rationale**: Lock service rather than consensus library because (1) developers are more familiar with locks, (2) reduces number of servers needed, (3) provides name service capability.

**Session Management**: KeepAlive heartbeats maintain sessions. Session expiry releases locks automatically, preventing deadlocks from crashed clients.

### 2.3 Apache ZooKeeper Locks

**Source**: src-005 (Apache ZooKeeper official documentation)

ZooKeeper implements distributed locks as "recipes" built from its coordination primitives rather than as first-class operations.

**Write Lock Protocol**:
1. Create ephemeral sequential znode under lock path
2. Get all children; if yours has lowest sequence number, you hold the lock
3. Otherwise, watch the node with next-lowest sequence number and wait

**Read Lock Protocol**:
1. Create ephemeral sequential znode with `read-` prefix
2. If no lower `write-` nodes exist, you hold the read lock
3. Otherwise, watch nearest lower `write-` node

**Key Design Properties**:
- Ephemeral nodes: automatic cleanup on client crash prevents deadlocks
- Sequential nodes: monotonically increasing numbers provide fair FIFO ordering
- Targeted watches: only watch predecessor, avoiding the "herd effect" where all waiters wake up simultaneously

### 2.4 Cross-System Comparison

| Property | Redlock | Chubby | ZooKeeper |
|----------|---------|--------|-----------|
| Consensus | Majority quorum | Paxos | ZAB |
| Lock granularity | Fine-grained | Coarse-grained | Either |
| Deadlock prevention | TTL auto-release | Session expiry | Ephemeral nodes |
| Fairness | No ordering | No ordering | Sequential znode ordering |
| Herd avoidance | N/A | Event subscriptions | Targeted watches |
| Lock types | Exclusive only | Exclusive + Shared | Exclusive + Shared |
| Implementation | Algorithm specification | Dedicated service | Built from primitives |

---

## Summary

Distributed coordination mechanisms span a spectrum from simple algorithms (Bully, Ring) to production lock services (Chubby, ZooKeeper) and algorithm specifications (Redlock). Key trade-offs include:

1. **Topology assumptions**: Bully requires full connectivity; Ring requires ring topology; lock services abstract topology behind a service layer
2. **Failure model**: All assume crash-stop; practical systems add session/TTL mechanisms for automatic lock release
3. **Consistency guarantees**: Stronger guarantees (Paxos/ZAB-based) come with higher latency; weaker guarantees (Redlock quorum) trade correctness edge cases for performance
4. **Fairness**: Only ZooKeeper provides built-in FIFO ordering via sequential znodes

## Sources

- src-001: https://www.cs.colostate.edu/~cs551/CourseNotes/Synchronization/BullyExample.html (ACQ-001)
- src-002: https://www.cs.uic.edu/~ajayk/Chapter9.pdf (ACQ-001)
- src-003: https://redis.io/docs/latest/develop/use/patterns/distributed-locks/ (ACQ-002)
- src-004: https://static.googleusercontent.com/media/research.google.com/en//archive/chubby-osdi06.pdf (ACQ-002)
- src-005: https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks (ACQ-002)
