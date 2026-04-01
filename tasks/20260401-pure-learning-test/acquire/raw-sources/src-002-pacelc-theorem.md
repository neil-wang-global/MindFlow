# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://en.wikipedia.org/wiki/PACELC_theorem

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Wikipedia article on well-established distributed systems theorem with academic citations

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# PACELC Design Principle: Extending the CAP Theorem

## Core Concept

The PACELC design principle extends the CAP theorem for distributed database systems. It addresses what happens both **during** and **in the absence of** network partitions:

- **During a partition (P):** Systems must choose between **availability (A)** and **consistency (C)** — this is the classic CAP tradeoff.
- **Else (E), when operating normally:** Systems must choose between **latency (L)** and **consistency (C)**.

As Daniel Abadi argued, "Ignoring the consistency/latency trade-off of replicated systems is a major oversight [in CAP]."

## Why CAP Alone Is Insufficient

The CAP theorem (expressible as "PAC") proves that no distributed data store can simultaneously guarantee consistency and availability when partitions occur. However, partitions are relatively rare events. PACELC highlights that even under normal conditions, replicating data forces a tradeoff: achieving atomic consistency requires at least one full network round trip, increasing latency. Lower-latency systems relax consistency to achieve faster responses.

## Four Configuration Models

| Configuration | Behavior |
|---|---|
| **PA/EL** | Prioritizes availability during partitions and low latency otherwise; sacrifices consistency in both cases |
| **PA/EC** | Chooses availability during partitions but consistency when running normally |
| **PC/EL** | Chooses consistency during partitions but favors lower latency otherwise |
| **PC/EC** | Prioritizes consistency at all times, accepting costs to both availability and latency |

PC/EC and PA/EL represent the most cognitively straightforward models. PC/EC systems deliver "a firm guarantee of atomic consistency, as in ACID," while PA/EL systems offer high availability and low latency with relaxed consistency. The conditional models (PA/EC and PC/EL) are more complex — developers must handle cases where consistency guarantees don't hold.

## Database Classifications

**PA/EL systems** (availability + low latency preferred): Amazon's early internal Dynamo, Cassandra, Riak, and Cosmos DB (in default configuration).

**PC/EC systems** (consistency always preferred): VoltDB/H-Store, Megastore, MySQL Cluster, PostgreSQL, Bigtable, and HBase.

**PA/EC systems** (availability during partitions, consistency otherwise): MongoDB and Hazelcast IMDG fall here, though Hazelcast can be reconfigured.

**PC/EL systems**: PNUTS chooses consistency during partitions but favors latency otherwise.

Several systems offer **tunable tradeoffs** — Cassandra, Riak, and Dynamo have user-adjustable settings for the latency/consistency balance, while Cosmos DB provides five selectable consistency levels.

## Historical Context

Abadi first described PACELC in a 2010 blog post and formalized it in a 2012 paper. Wojciech Golab of the University of Waterloo provided a formal proof in a 2018 SIGACT News article.

## Practical Relevance

Some experts suggest CAP remains most relevant for intermittently connected environments like IoT devices and mobile apps, where physical conditions cause partitions. For cloud-based distributed systems that rarely experience true partitions, PACELC provides a more comprehensive framework by surfacing the latency-consistency tradeoff that dominates everyday operation.
