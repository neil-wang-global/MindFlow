# Step 2: Distributed Locking Research Notes

## ACQ Event
- ACQ-002

## Sources Used
- src-003 (Redlock algorithm — Redis official documentation)
- src-004 (Chubby lock service — Google Research OSDI 2006 paper)
- src-005 (ZooKeeper locks — Apache ZooKeeper official documentation)

## Redlock Algorithm (Redis)

### Design
- Uses N=5 independent Redis masters (no replication between them)
- Lock acquisition requires majority quorum (at least 3 of 5)
- Client acquires lock with same key/random-value across all instances
- Lock validity = initial TTL minus acquisition time elapsed

### Safety Properties
- Mutual exclusion: only one client can hold lock (guaranteed by majority quorum)
- Deadlock-free: auto-release via TTL expiry
- Fault tolerant: works as long as majority of nodes are up

### Key Issue
- Failover-based single-instance Redis lock is unsafe: master crash before replication can cause safety violation (two clients hold same lock)
- Redlock addresses this by requiring independent majority quorum

### Trade-offs
- Relies on bounded clock drift assumption
- Higher latency than single-node lock (must contact N nodes)
- Criticized by Kleppmann for reliance on timing assumptions

## Google Chubby Lock Service

### Design
- 5-replica cell using Paxos consensus
- All operations through elected master
- File-system-like interface (`/ls/cell/path`)
- Advisory locks (not mandatory) on files and directories

### Lock Types
- Exclusive (writer) mode: one holder
- Shared (reader) mode: multiple holders
- Sequencers: opaque byte strings proving lock ownership (prevents stale locks)

### Key Features
- Session-based: clients maintain KeepAlive heartbeats
- Ephemeral lock release on session expiry (prevents deadlocks from crashed clients)
- Event notification system (lock acquired, contents modified, master failover)
- Consistent caching with master-driven invalidation

### Design Philosophy
- Lock service rather than consensus library — easier for developers
- Coarse-grained locking (minutes to hours, not milliseconds)
- Also serves as name service and small metadata store

## Apache ZooKeeper Locks

### Design
- Built from ZooKeeper primitives (ephemeral sequential znodes)
- Not first-class lock operations — implemented as "recipes"
- Leverages ordered znodes for fair queueing

### Write Lock Protocol
1. Create ephemeral sequential znode under lock path
2. Get all children; if yours is lowest, you hold the lock
3. Otherwise, watch the next-lowest node and wait

### Read Lock Protocol
1. Create ephemeral sequential znode with `read-` prefix
2. If no lower `write-` nodes exist, you hold the read lock
3. Otherwise, watch the nearest lower `write-` node

### Key Properties
- Ephemeral nodes: automatic cleanup on client crash (prevents deadlocks)
- Sequential nodes: natural ordering ensures fairness (FIFO)
- Targeted watches: only watch predecessor, avoiding "herd effect"
- Reader-writer lock support (shared reads, exclusive writes)

## Comparison Across Systems

| Property | Redlock | Chubby | ZooKeeper |
|----------|---------|--------|-----------|
| Consensus | Majority quorum (no Paxos) | Paxos | ZAB (ZooKeeper Atomic Broadcast) |
| Lock granularity | Fine-grained | Coarse-grained | Either |
| Deadlock prevention | TTL auto-release | Session expiry | Ephemeral nodes |
| Fairness | No ordering guarantee | No ordering guarantee | Sequential znode ordering |
| Herd avoidance | N/A | Event subscriptions | Targeted watches |
| Lock type | Exclusive only | Exclusive + Shared | Exclusive + Shared |
