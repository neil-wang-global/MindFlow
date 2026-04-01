# Step 1 Output: CAP Theorem Research

## Sources Used
- src-001: https://en.wikipedia.org/wiki/CAP_theorem (passed verification)
- src-002: https://en.wikipedia.org/wiki/PACELC_theorem (passed verification)

## CAP Theorem Definition
The CAP theorem (Brewer's theorem) states that any distributed data store can guarantee at most two of three properties simultaneously:
1. **Consistency (C)** — Every read returns the most recent write or an error
2. **Availability (A)** — Every request to a non-failing node must produce a response
3. **Partition Tolerance (P)** — The system remains operational despite network partitions

## History
- 1996: Birman and Friedman established a predecessor trade-off result (restricted to non-commuting operations)
- 1998: Brewer originated the idea
- 1999: Published as CAP principle by Fox and Brewer
- 2000: Presented as a conjecture at PODC
- 2002: Seth Gilbert and Nancy Lynch (MIT) published formal proof
- 2012: Brewer clarified that "two out of three" is "somewhat misleading"

## Formal Properties
- CAP consistency differs from ACID consistency
- Availability in CAP (per Gilbert & Lynch) differs from high availability in software architecture
- Partition tolerance means operation continues despite arbitrary message loss/delay
- When no partition exists, all three can be satisfied simultaneously

## Core Trade-off
Since network partitions are unavoidable in distributed systems, the practical choice is between:
- **CP (Consistency + Partition Tolerance)**: System returns errors/timeouts during partitions. Examples: MongoDB, Redis, HBase
- **AP (Availability + Partition Tolerance)**: System returns potentially stale data during partitions. Examples: Cassandra, CouchDB, ScyllaDB, DynamoDB
- **CA (Consistency + Availability)**: Only possible without partitions (single-node/non-distributed). No distributed NoSQL databases are classified as CA.

## Proof Sketch (from Gilbert & Lynch 2002)
- Defined formal models for consistency (atomic/linearizable), availability, and partition tolerance
- Proved impossibility for asynchronous networks using adversarial argument
- During a network partition, a system must choose between consistency and availability
- Also showed limitations in synchronous networks with some relaxations possible

## Database Classification
| Category | Examples | Behavior During Partition |
|----------|----------|--------------------------|
| CP | MongoDB, Redis | Maintain consistency, sacrifice availability |
| AP | CouchDB, Cassandra, ScyllaDB | Maintain availability, sacrifice consistency |
| CA | Traditional RDBMS (PostgreSQL, MySQL) when non-distributed | Only possible without partitions |

## PACELC Extension
The PACELC theorem (Abadi, 2010/2012) extends CAP:
- If Partition → choose Availability vs Consistency
- Else → choose Latency vs Consistency

Four configurations:
- PA/EL: Availability + low latency (Dynamo, Cassandra, Riak)
- PC/EC: Consistency always (VoltDB, Megastore, PostgreSQL, HBase)
- PA/EC: Availability during partitions, consistency otherwise (MongoDB)
- PC/EL: Consistency during partitions, latency otherwise (PNUTS)

## Modern Considerations
- Many systems offer tunable consistency (Cassandra, Cosmos DB)
- Google Spanner uses TrueTime/GPS for strong consistency with minimized partition frequency
- CAP most relevant for intermittently connected environments (IoT, mobile)
- PACELC more comprehensive for cloud-scale distributed systems

## Related Concepts
- Fallacies of Distributed Computing
- Paxos and Raft consensus algorithms
- BASE philosophy (vs ACID)
