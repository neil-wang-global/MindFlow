# Distributed Locking Mechanisms — Comparative Analysis

## Task ID
- 20260401-fix-val-07

## Overview

This document compares three distributed locking mechanisms: Redis-based (Redlock), ZooKeeper-based (recipes), and etcd-based (concurrency package). Each represents a fundamentally different architectural approach to achieving mutual exclusion in distributed systems.

## 1. Redis-Based Distributed Locks (Redlock Algorithm)

### Mechanism
- Uses N independent Redis master instances (recommended N=5)
- Client acquires lock on each instance using `SET key value NX PX ttl`
- Lock is held if acquired on majority (>N/2) within validity window
- Validity = TTL - elapsed_time - clock_drift_factor

### Key Properties
- **Safety**: Mutual exclusion via majority quorum; unique token prevents accidental unlock
- **Liveness**: TTL-based deadlock freedom; retries with random backoff
- **Fault Tolerance**: Tolerates floor((N-1)/2) node failures

### Architecture
- No consensus protocol — relies on independent, uncoordinated Redis masters
- Clock drift is an explicit assumption in the validity calculation
- Atomic release via Lua script: delete-if-value-matches

### Source
- Official Redis documentation: https://redis.io/docs/latest/develop/use/patterns/distributed-locks/

## 2. ZooKeeper-Based Distributed Locks (Recipes)

### Mechanism
- Client creates ephemeral sequential znode under lock path (e.g., `/locks/write-0000000001`)
- Client with lowest sequence number holds the lock
- Non-holders watch their immediate predecessor znode only
- Session expiry automatically deletes ephemeral znodes (deadlock prevention)

### Key Properties
- **Safety**: ZAB consensus ensures linearizable ordering of znode operations
- **Liveness**: Ephemeral nodes auto-deleted on session timeout
- **Fairness**: FIFO ordering via sequential znode numbering
- **Herd Effect Avoidance**: Watch-predecessor pattern ensures O(1) notifications per release

### Read-Write Lock Extension
- Write locks: `write-` prefix znodes; holder has lowest sequence among all children
- Read locks: `read-` prefix znodes; holder has no lower `write-` prefix children
- Multiple readers can hold simultaneously; writers are exclusive

### Architecture
- Consensus-backed coordination service (ZAB protocol)
- Locks are "recipes" — built from primitive operations, not first-class API
- Session-based liveness with heartbeats

### Source
- Official ZooKeeper documentation: https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks

## 3. etcd-Based Distributed Locks (Concurrency Package)

### Mechanism
- Client creates a Session with an associated lease (TTL-based)
- Mutex created with `concurrency.NewMutex(session, "/prefix/")`
- `Lock()` creates a key under the prefix with the session's lease attached
- Fairness via revision-based ordering — waiters watch for deletion of key with next-lowest revision
- `TryLock()` provides non-blocking lock attempt (returns `ErrLocked` if held)

### Key Properties
- **Safety**: Raft consensus ensures linearizable key-value operations
- **Liveness**: Lease TTL with automatic keep-alive; expiry deletes associated keys
- **Fairness**: Global revision ordering provides FIFO semantics
- **API**: Implements Go `sync.Locker` interface; context-aware cancellation

### Error Handling
- `ErrLocked`: lock held by another session (TryLock only)
- `ErrSessionExpired`: lease expired
- `ErrLockReleased`: double-unlock protection

### Architecture
- Consensus-backed key-value store (Raft protocol)
- First-class concurrency primitives in the client library
- Session wraps lease with automatic keep-alive

### Source
- Official etcd concurrency package: https://pkg.go.dev/go.etcd.io/etcd/client/v3/concurrency

## Comparative Analysis

| Dimension | Redis/Redlock | ZooKeeper | etcd |
|-----------|--------------|-----------|------|
| **Consensus** | None (independent masters) | ZAB | Raft |
| **Lock Primitive** | SET NX PX + quorum | Ephemeral sequential znodes | Leased keys + revisions |
| **Ordering** | No built-in ordering | Sequential znode numbers | Global revision numbers |
| **Failure Detection** | TTL expiry (passive) | Session timeout (heartbeat) | Lease TTL (keep-alive) |
| **Herd Avoidance** | N/A (no waiter queue) | Watch predecessor znode | Watch preceding revision |
| **Read-Write Locks** | Not built-in | Native recipe support | Not in standard package |
| **Fencing Support** | No native fencing token | Znode sequence as fencing | Revision as fencing token |
| **API Style** | Low-level SET/GET + Lua | Primitive composition (recipes) | High-level sync.Locker |
| **Fault Tolerance** | Majority of N masters | ZooKeeper ensemble quorum | etcd cluster quorum |
| **Clock Dependency** | Critical (drift in validity) | Minimal (session heartbeats) | Minimal (lease heartbeats) |

## Key Architectural Differences

1. **Consensus vs. Quorum**: Redlock uses a stateless majority quorum across independent masters without consensus. ZooKeeper and etcd both use consensus protocols (ZAB and Raft respectively) providing stronger ordering guarantees.

2. **Liveness Mechanism**: All three use time-based mechanisms but differently — Redlock uses passive TTL expiry, ZooKeeper uses session heartbeats with ephemeral node deletion, etcd uses lease keep-alive with automatic key deletion.

3. **Fairness**: Redlock provides no ordering guarantee for competing clients. ZooKeeper uses sequential znode numbering for FIFO ordering. etcd uses global key revisions for FIFO ordering.

4. **ZooKeeper vs. etcd**: Both are consensus-backed coordination services. ZooKeeper treats locks as "recipes" built from primitives (create, getChildren, exists with watch). etcd provides first-class Mutex and Session types in its client library. Both avoid herd effects through predecessor-watching patterns.

## Recommendations

- **Efficiency-only locking** (best-effort): Single Redis instance with `SET NX PX` may suffice; Redlock adds complexity for multi-node fault tolerance
- **Correctness-critical locking**: Use ZooKeeper or etcd with fencing tokens (sequential znode numbers or key revisions)
- **Read-write lock needs**: ZooKeeper has native recipe support; etcd and Redis require custom implementation
- **Go ecosystem**: etcd concurrency package provides the most ergonomic API with sync.Locker compatibility
