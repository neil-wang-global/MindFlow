# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://en.wikipedia.org/wiki/CAP_theorem

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Wikipedia articles on well-established computer science theorems are heavily cited and cross-referenced with primary academic sources

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# The CAP Theorem: A Comprehensive Summary

## Definition

The CAP theorem (also called **Brewer's theorem**) is a fundamental principle in database theory stating that any distributed data store can guarantee at most two of three properties simultaneously:

1. **Consistency** — Every read returns the most recent write or an error. All clients observe identical data regardless of which node they query. Data written to one node must be replicated to all others before the write is confirmed successful. Notably, CAP consistency differs significantly from ACID consistency.

2. **Availability** — Every request to a non-failing node must produce a response, though not necessarily containing the latest data. This definition (from Gilbert and Lynch) differs from the software architecture concept of high availability.

3. **Partition Tolerance** — The system remains operational even when an arbitrary number of messages between nodes are dropped or delayed.

## The Core Trade-off

When a network partition occurs, system designers must choose: cancel the operation (preserving consistency but reducing availability) or proceed (maintaining availability but risking inconsistency). As the article notes, "if there is a network partition, one has to choose between consistency or availability." When no partition exists, all three properties can be satisfied simultaneously.

## Choosing Consistency vs. Availability

Selecting consistency means the system returns errors or timeouts when it cannot guarantee up-to-date information due to partitioning. Selecting availability means the system processes queries and returns the best available version of data, even if potentially stale.

Traditional ACID-oriented systems like relational databases favor consistency. Systems built around the BASE philosophy (common in NoSQL) generally favor availability. However, specific databases break this generalization: **MongoDB** and **Redis** maintain consistency while sacrificing availability during partitions, making them CP systems. **CouchDB**, **Cassandra**, and **ScyllaDB** are AP databases. The article states that "there are no NoSQL databases one would classify as CA." Most contemporary distributed databases provide configuration options allowing tuning of both properties.

Some cloud services pursue strong consistency while using private fiber networks and GPS clock synchronization to minimize partition frequency. Shared-nothing architectures may employ geographic sharding to maintain availability for locally-owned data without supporting arbitrary requests during partitions.

## History and Formal Proof

The theorem originated in autumn 1998, according to Eric Brewer of UC Berkeley. It was published as the CAP principle in 1999 by Armando Fox and Eric Brewer, then presented as a conjecture at the **2000 Symposium on Principles of Distributed Computing (PODC)**. In 2002, **Seth Gilbert and Nancy Lynch of MIT** published a formal proof, converting Brewer's conjecture into a theorem.

A predecessor result by **Birman and Friedman (1996)** had already established a trade-off between consistency and availability in distributed systems, though their result was "restricted this lower bound to non-commuting operations."

## Brewer's 2012 Clarifications

In 2012, Brewer revisited his theorem, explaining that the popular "two out of three" framing is "somewhat misleading" because designers only sacrifice consistency or availability when partitions actually occur. He emphasized that partition management and recovery techniques have advanced, and he highlighted the differing definitions of consistency between CAP and ACID.

## The PACELC Extension

The **PACELC theorem**, introduced by Daniel Abadi in 2010, extends CAP by addressing trade-offs even without partitions. The formulation: if a partition (P) occurs, choose between availability (A) and consistency (C); else (E), the trade-off is between latency (L) and consistency (C).

Experts like Marc Brooker suggest CAP is especially relevant for intermittently connected environments such as IoT devices and mobile applications, where physical conditions (power outages, elevators) cause partitions. For cloud-scale distributed systems, PACELC is considered more comprehensive since it accounts for latency-consistency trade-offs during normal operation.

## Database Classification Summary

| Category | Examples | Behavior During Partition |
|----------|----------|--------------------------|
| **CP** | MongoDB, Redis | Maintain consistency, sacrifice availability |
| **AP** | CouchDB, Cassandra, ScyllaDB | Maintain availability, sacrifice consistency |
| **CA** | No distributed/NoSQL databases classified here | Only possible without partitions |

## Related Concepts

The theorem connects to several related ideas: the Fallacies of Distributed Computing, Lambda architecture, Paxos and Raft consensus algorithms, and Zooko's triangle. It is also categorized as an instance of an inconsistent triad or trilemma in logic.
