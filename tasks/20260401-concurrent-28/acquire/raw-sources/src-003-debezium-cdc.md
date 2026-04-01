# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001 — cache invalidation pattern evidence grounding

## Source URL
- https://debezium.io/documentation/reference/stable/tutorial.html

## Fetch Timestamp
- 2026-04-01T14:37:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Debezium project documentation (Red Hat / community-maintained open source)

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Debezium Tutorial

Debezium is an open source distributed platform for change data capture (CDC). It captures row-level changes in databases and streams them as events to Apache Kafka.

## What is Change Data Capture?

Change Data Capture (CDC) is a set of software design patterns used to determine and track data that has changed so that action can be taken using the changed data. CDC captures changes made to the data in a database and makes those changes available as events in an event stream.

**How CDC works with database logs:**

Most databases maintain a transaction log (also called write-ahead log, redo log, or binlog) that records all changes to the data before they are committed. Debezium reads this log to capture changes without impacting database performance.

## Architecture

```
Database → Debezium Connector → Kafka → Consumer Applications
```

**Components:**

1. **Source Database**: The database whose changes are being captured (MySQL, PostgreSQL, MongoDB, SQL Server, Oracle, etc.)
2. **Debezium Connector**: A Kafka Connect source connector that reads the database's transaction log
3. **Apache Kafka**: The event streaming platform that receives and stores change events
4. **Consumer Applications**: Applications that subscribe to Kafka topics to react to changes

## Change Event Structure

Each change event contains:

- **before**: The state of the row before the change (null for inserts)
- **after**: The state of the row after the change (null for deletes)
- **source**: Metadata about the source database, table, and position in the transaction log
- **op**: The type of operation: `c` (create), `u` (update), `d` (delete), `r` (read/snapshot)
- **ts_ms**: The timestamp of the change

## Use Cases for Cache Invalidation

Debezium is commonly used for cache invalidation in distributed systems:

1. **Direct invalidation**: Consumer application receives a change event and invalidates or updates the corresponding cache entry
2. **Selective invalidation**: Change events are filtered by table or column to invalidate only affected cache entries
3. **Cross-service invalidation**: In microservice architectures, services maintain local caches of shared data; Debezium events notify all services when the source data changes

**Latency characteristics:**

- Database write to Kafka: typically 10-100ms (depends on connector polling interval and commit log read latency)
- Kafka to consumer: typically 1-50ms (depends on consumer poll interval)
- Total end-to-end invalidation latency: typically 50-500ms

**Delivery guarantees:**

- Debezium provides **at-least-once** delivery: events may be delivered more than once but will not be lost under normal operation
- **Ordering**: Events for the same database row are delivered in order (same Kafka partition)
- **Exactly-once**: Achievable with Kafka transactions and idempotent consumers, but adds latency

## Event Loss Scenarios

Despite at-least-once semantics, events can be lost in certain failure scenarios:

- **Connector crash before offset commit**: If the connector crashes after reading the log but before committing the Kafka offset, the event will be replayed on restart (duplicate, not loss)
- **Database log rotation**: If the connector falls too far behind, older log entries may be purged by the database, causing a gap. Debezium detects this and can trigger a full snapshot to recover.
- **Kafka broker failure**: With replication factor >= 3 and `acks=all`, Kafka provides durability guarantees. Without these settings, broker failure can cause event loss.
