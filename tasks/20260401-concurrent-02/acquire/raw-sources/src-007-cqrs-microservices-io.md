# Raw Source

## Source ID
- src-007

## ACQ Event
- ACQ-002

## Source URL
- https://microservices.io/patterns/data/cqrs.html

## Fetch Timestamp
- 2026-04-01T10:34:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Chris Richardson's canonical microservice pattern catalog

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Pattern: Command Query Responsibility Segregation (CQRS)

## Context

You have applied the Database per Service pattern. Each service has its own database. Some queries, however, need to join data from multiple services.

## Problem

How to implement a query that retrieves data from multiple services in a microservice architecture?

## Solution

Define a view database, which is a read-only replica that is designed to support that query. The application keeps the replica up to date by subscribing to Domain events published by the service that own the data.

## Benefits

- Supports multiple denormalized views that are scalable and performant
- Improved separation of concerns = simpler command and query models
- Necessary in an event sourced architecture

## Drawbacks

- Increased complexity
- Potential code duplication
- Replication lag / eventual consistency

## Related patterns

- Database per Service pattern creates the need for this pattern
- The API Composition pattern is an alternative solution
- Domain Event pattern provides the Domain events
- CQRS is often used with Event Sourcing

## Implementation Notes

A CQRS-based service consists of:
1. **Command side**: handles create, update, delete requests. Validates business rules. Writes to the command-side datastore. Publishes domain events.
2. **Query side**: handles queries. Subscribes to domain events and updates the query-side datastore (materialized views).

The command-side and query-side datastores can be different database technologies:
- Command side: relational database optimized for transactional writes
- Query side: document database or search engine optimized for queries

Synchronization between sides:
- Domain events published by the command side
- Eventual consistency is the norm — the query side may lag behind
- Consumers must be idempotent to handle duplicate events
