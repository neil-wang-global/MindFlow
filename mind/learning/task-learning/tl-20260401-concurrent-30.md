# Task Learning Record

## Task ID
- 20260401-concurrent-30

## Task Summary
- Researched distributed coordination mechanisms across two domains: leader election algorithms (Bully, Ring/Chang-Roberts) and distributed locking mechanisms (Redlock, Chubby, ZooKeeper locks)
- Produced consolidated research document at `_output/distributed-coordination-research.md` covering both topics with 5 verified primary sources

## External Acquisition

### ACQ-001: Leader Election Algorithms

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-30/acquire/verification-report.md` §ACQ-001
- **Passed Sources**: src-001, src-002

### ACQ-002: Distributed Locking Mechanisms

- **Trigger**: step-triggered: Step 2
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-30/acquire/verification-report.md` §ACQ-002
- **Passed Sources**: src-003, src-004, src-005

## Candidate Knowledge

### [KDC-001] Bully Algorithm Leader Election

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-30/acquire/raw-sources/src-001-bully-algorithm.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The Bully Algorithm was proposed by Hector Garcia-Molina in 1982. It is used in distributed systems to elect a coordinator (leader) among a group of processes."
- **Derived Conclusion**: The Bully algorithm is a leader election protocol for fully connected networks where the process with the highest ID always becomes coordinator. It uses three message types (ELECTION, ANSWER, COORDINATOR) and has O(n^2) worst-case message complexity. It is self-stabilizing after failures but requires all processes to know each other's IDs.

### [KDC-002] Chang-Roberts Ring Election Algorithm

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-30/acquire/raw-sources/src-002-ring-election.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The Chang-Roberts algorithm operates on a unidirectional ring topology."
- **Derived Conclusion**: The Chang-Roberts ring election algorithm achieves O(n log n) average-case message complexity on a unidirectional ring topology, improving over the Bully algorithm's O(n^2) average case. Each process only needs to know its ring neighbor, making it suitable for systems without full connectivity. The algorithm forwards election messages clockwise, with each process either forwarding higher-ID messages or replacing them with its own ID.

### [KDC-003] Redlock Distributed Lock Algorithm

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-30/acquire/raw-sources/src-003-redlock-algorithm.md`
- **Verification Status**: passed
- **Original Excerpt**: > "In the distributed version of the algorithm we assume we have N Redis masters. These nodes are totally independent, so we don't use replication or any other implicit coordination system."
- **Derived Conclusion**: Redlock achieves distributed mutual exclusion across N independent Redis masters (recommended N=5) using a majority quorum approach without replication. It provides three guarantees: mutual exclusion (safety), deadlock freedom via TTL auto-release (liveness A), and fault tolerance as long as majority nodes are up (liveness B). The algorithm addresses the safety violation possible with single-master-plus-replica Redis lock setups where master crash before replication can grant the same lock to two clients.

### [KDC-004] Chubby Coarse-Grained Lock Service

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-30/acquire/raw-sources/src-004-chubby-lock-service.md`
- **Verification Status**: passed
- **Original Excerpt**: > "We describe our experiences with the Chubby lock service, which is intended to provide coarse-grained locking as well as reliable (though low-volume) storage for a loosely-coupled distributed system. Chubby provides an interface much like a distributed file system with advisory locks, but the design emphasis is on availability and reliability, as opposed to high performance."
- **Derived Conclusion**: Google's Chubby is a coarse-grained lock service built on Paxos consensus with a 5-replica cell architecture. It provides advisory locks (exclusive and shared) with sequencer-based stale lock prevention, session-based liveness via KeepAlive heartbeats, and event notification. The design choice of a lock service over a consensus library was driven by developer familiarity with lock abstractions and the ability to co-locate a name service.

### [KDC-005] ZooKeeper Lock Recipes Using Ephemeral Sequential Znodes

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-30/acquire/raw-sources/src-005-zookeeper-locks.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Fully distributed locks that are globally synchronous, meaning at any snapshot in time no two clients think they hold the same lock. These can be implemented using ZooKeeper."
- **Derived Conclusion**: ZooKeeper implements distributed locks as recipes built from coordination primitives (ephemeral sequential znodes) rather than as first-class operations. The design provides three key properties: automatic lock release on client crash via ephemeral nodes, fair FIFO ordering via sequential node numbering, and avoidance of the "herd effect" through targeted watches on immediate predecessor nodes. This approach supports both exclusive write locks and shared read locks.

## Potential Capability Impact
- none — no existing capabilities were used or found insufficient

## Next Promotion Target
- KDC-001: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-bully-algorithm.md`
- KDC-002: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-ring-election.md`
- KDC-003: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-redlock-algorithm.md`
- KDC-004: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-chubby-lock-service.md`
- KDC-005: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-zookeeper-locks.md`

## Notes
- none
