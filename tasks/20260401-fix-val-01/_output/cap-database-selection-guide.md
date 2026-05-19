# CAP Theorem: Practical Database Selection Guide for Microservice Architectures

## Overview

This document synthesizes practical implications of the CAP theorem for database selection in microservice architectures. It extends beyond foundational CAP knowledge (impossibility theorem, CP/AP classification, PACELC extension) to provide actionable guidance for per-service database selection aligned with Domain-Driven Design bounded contexts.

## 1. Database-per-Service Pattern: The Foundational Principle

Each microservice must own its domain data and logic under an autonomous lifecycle with independent deployment. Two services must not share a data store — not the same schema, and not the same set of database tables. Services may share the same physical database server, but logical isolation must be maintained.

**Source**: Microsoft Azure Architecture Center (src-001), Microsoft .NET Microservices Architecture Guide (src-002)

**Rationale**: Shared data schemas create unintentional coupling. Schema changes would require coordinated updates across every dependent service, breaking microservice lifecycle autonomy. Each microservice has unique data models, queries, and read/write patterns that are best served by an independently optimized data store.

## 2. Polyglot Persistence as a Natural Consequence

The database-per-service pattern naturally leads to polyglot persistence — using multiple data storage technologies within a single application. Different bounded contexts have different data model requirements:

- One service may need schema-on-read capabilities of a document database
- Another may need referential integrity from an RDBMS
- A third may need high read-write throughput from an in-memory store

**Source**: src-001 ("This approach naturally leads to polyglot persistence"), src-002 ("microservices-based applications often use a mixture of SQL and NoSQL databases, which is sometimes called the polyglot persistence approach")

## 3. Per-Service Consistency Level Decision Framework

The most critical practical implication of the CAP theorem in microservices is this: **define the required consistency level for each component independently, and prefer eventual consistency where possible.**

### Decision Criteria per Bounded Context

| Criterion | Strong Consistency (CP) | Eventual Consistency (AP) |
|-----------|------------------------|--------------------------|
| Transaction integrity required | Yes — financial, ordering | No — recommendations, analytics |
| Data is source of truth | Yes — this service is the authoritative owner | No — service holds a copy/subset |
| Cross-service joins needed | Indicates service boundary may need redrawing | Normal — use event-driven replication |
| Read/write profile | Write-heavy with consistency constraints | Read-heavy or write-heavy with throughput priority |
| Access pattern | Complex queries, referential integrity | Simple lookups, high throughput |

**Source**: src-001 ("Define the required consistency level for each component, and prefer eventual consistency where possible. Identify areas in the system where you need strong consistency or ACID transactions. And identify areas where eventual consistency is acceptable.")

### Single Source of Truth Pattern

When strong consistency is required, designate one service as the source of truth for a given entity. Other services hold eventually consistent copies. Example from src-001: in an e-commerce system, the order service is the source of truth for transaction history; the recommendation service listens to order events but is not authoritative for refund processing.

## 4. Concrete Database Selection by Access Pattern (Drone Delivery Example)

The Azure Architecture Center provides a concrete worked example demonstrating how different bounded contexts within a single application lead to different database selections:

| Service | Access Pattern | Consistency Need | Selected Database | Rationale |
|---------|---------------|-----------------|-------------------|-----------|
| Delivery service | High read-write throughput, latest status only | Eventual (short-lived data) | Redis (in-memory cache) | Emphasizes throughput over long-term storage; no complex queries |
| Delivery history (analytics) | Large dataset analysis, schema-on-read | Eventual | Azure Data Lake Storage | Optimized for data analytics over large datasets |
| Delivery history (lookup) | Individual ID-based lookups | Eventual | Azure Cosmos DB | Quick time-series data lookup; records archived after ~1 month |
| Package service | High write throughput, simple queries by ID | Eventual | Document database (Cosmos DB) | Non-relational data; no complex joins needed; sharded collections |

**Source**: src-001 (drone delivery application example)

**Key insight**: Even within a single application, four different data stores serve four different bounded contexts. The selection is driven by access patterns and consistency requirements, not by a single database technology preference.

## 5. Bounded Context Alignment with DDD

The relationship between bounded contexts and database selection is formalized through Domain-Driven Design:

- Each DDD Bounded Context correlates to one business microservice
- Each Bounded Context must have its own model and database
- Domain entities may have different names and attributes across bounded contexts (e.g., "User" in user-profile BC vs. "Buyer" in ordering BC share the same identity but different domain models)
- Store only the data that a service needs — the shipping bounded context needs customer-delivery associations but not billing addresses

**Source**: src-002 ("Each DDD Bounded Context correlates to one business microservice (one or several services)")

## 6. Cross-Service Data Consistency Patterns

When CAP trade-offs force eventual consistency across service boundaries:

1. **Event-driven architecture**: Services publish events on data changes; other services subscribe and maintain local copies. Publish event schemas (JSON Schema, Protobuf, Avro) to avoid tight coupling.
2. **Transaction patterns**: Use Scheduler Agent Supervisor and Compensating Transaction patterns to maintain consistency across multiple services. Store work-in-progress state on durable queues.
3. **Service boundary evaluation**: If two services continually exchange information creating chatty APIs, the service boundary may need redrawing — merge the services or refactor.

**Source**: src-001 (approaches to managing data), src-002 (data access via API endpoints or messaging only)

## 7. Trade-offs and Operational Considerations

**Benefits of polyglot persistence**:
- Loosely coupled services
- Better performance through per-service optimization
- Independent scalability
- Cost optimization per workload

**Challenges**:
- Data redundancy across stores
- Loss of cross-service ACID transactions — must use eventual consistency patterns
- Loss of cross-service SQL joins — requires API composition or event-driven replication
- Increased operational complexity (multiple database technologies to manage)
- Distributed data management complexity

**Source**: src-001, src-002

## Key Takeaways

1. **No single database technology is correct** — selection must be per-service based on bounded context requirements
2. **Prefer eventual consistency** unless there is a specific business requirement for strong consistency (ACID)
3. **Access patterns drive selection** — read/write profile, query complexity, throughput requirements, and data lifespan are the primary discriminators
4. **Bounded context alignment is critical** — DDD bounded contexts map to microservices, and each bounded context determines its own CAP trade-off
5. **The real CAP choice in microservices is not "pick two"** but rather: for each service, determine whether consistency or availability matters more during partitions, and whether latency or consistency matters more during normal operation (PACELC)
