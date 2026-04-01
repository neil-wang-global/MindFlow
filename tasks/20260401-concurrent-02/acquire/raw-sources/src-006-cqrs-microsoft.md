# Raw Source

## Source ID
- src-006

## ACQ Event
- ACQ-002

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/patterns/cqrs

## Fetch Timestamp
- 2026-04-01T10:33:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Microsoft Azure official architecture patterns documentation

## Fetch Status
- success

## Fetch Completeness
- truncated — tool output limit reached; core pattern description and guidance captured

## Original Content

# CQRS pattern

CQRS stands for Command and Query Responsibility Segregation, a pattern that separates read and update operations for a data store. Implementing CQRS in your application can maximize its performance, scalability, and security. The flexibility created by migrating to CQRS allows a system to better evolve over time and prevents update commands from causing merge conflicts at the domain level.

## Context and problem

In traditional architectures, the same data model is used to query and update a database. That's simple and works well for basic CRUD operations. In more complex applications, however, this approach can become unwieldy. For example, on the read side, the application may perform many different queries, returning data transfer objects (DTOs) with different shapes. Object mapping can become complicated. On the write side, the model may implement complex validation and business logic. As a result, you can end up with an overly complex model that does too much.

Read and write workloads are often asymmetrical, with very different performance and scale requirements.

## Solution

CQRS separates reads and writes into different models, using commands to update data and queries to read data.

- Commands should be task-based, rather than data-centric ("Book hotel room", not "set ReservationStatus to Reserved")
- Commands may be placed on a queue for asynchronous processing, rather than being processed synchronously
- Queries never modify the database. A query returns a DTO that does not encapsulate any domain knowledge

For greater isolation, you can physically separate the read data from the write data. In that case, the read database can use its own data schema that is optimized for queries.

## Benefits

- **Independent scaling**: CQRS allows the read and write workloads to scale independently
- **Optimized data schemas**: The read side can use a schema that is optimized for queries, while the write side uses a schema that is optimized for updates
- **Security**: It's easier to ensure that only the right domain entities are performing writes on the data
- **Separation of concerns**: Segregating the read and write sides can result in models that are more maintainable and flexible
- **Simpler queries**: By storing a materialized view in the read database, the application can avoid complex joins when querying

## Challenges

- **Complexity**: The basic idea of CQRS is simple. But it can lead to a more complex application design
- **Messaging**: Although CQRS does not require messaging, it's common to use messaging to process commands and publish update events
- **Eventual consistency**: If you separate the read and write databases, the read data may be stale

## CQRS with Event Sourcing

CQRS is often used along with the Event Sourcing pattern. With CQRS, the write model raises events when the state changes. The read model subscribes to these events and updates its data accordingly.

Event Sourcing stores a sequence of events rather than the current state. The event store is the write model and is the official source of truth. The read model provides materialized views of the data, typically in a highly denormalized form.

When combining CQRS with Event Sourcing:
- The event store is the write model; the read model provides materialized views
- New projections can be created by replaying the event stream
- Full audit trail of every change
- Temporal queries supported natively
- Commands validate business rules and emit events; queries read projections

## When to use this pattern

Consider CQRS for:
- Collaborative domains where many users access the same data
- Task-based UIs guided through complex processes
- Scenarios where performance of data reads must be fine-tuned separately from writes
- Scenarios where evolution of the model is expected

Not recommended for:
- Simple CRUD domains
- Simple business rules
