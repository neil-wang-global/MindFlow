# Raw Source

## Source ID
- src-008

## ACQ Event
- ACQ-002

## Source URL
- https://cqrs.wordpress.com/documents/cqrs-introduction/

## Fetch Timestamp
- 2026-04-01T10:35:00Z

## Source Type
- Blog Post

## Credibility Assessment
- High — Greg Young is the originator of the CQRS pattern; this is his personal writing on the topic

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# CQRS, Task Based UIs, Event Sourcing agh!

Many people have been talking about CQRS lately. Let me start by saying that there seems to be a lot of confusion about what CQRS is. Most of the confusion comes from people confusing CQRS with Event Sourcing which are two different things.

## What is CQRS?

CQRS is simply the creation of two objects where there was previously only one. The separation occurs based upon whether the methods are a command or a query (the same definition that is used by Meyer in Command and Query Separation, CQS).

The difference between CQS and CQRS is that every CQRS object is split into two objects, one containing the Commands one containing the Queries.

Commands are defined as methods that change state. Queries are defined as methods that return a value.

## Why Would I Want to Use CQRS?

Looking at many software systems today, you will notice that in general you can find the following properties:

1. There is a system that reads and writes to the same data store
2. There are far more reads than writes
3. Read and write requirements differ substantially
4. The reads need different shapes of data than what is stored

In many systems, the read side has radically different needs than the write side. The write side needs to enforce business rules, validate data, and ensure consistency. The read side needs to return data in shapes that match the UI or reporting needs, which often requires joins, aggregations, and transformations.

By splitting the read and write sides, each can be independently optimized for its specific concerns.

## CQRS and Event Sourcing

CQRS and Event Sourcing are not the same thing. CQRS can be used without Event Sourcing, and Event Sourcing can be used without CQRS. However, they complement each other well.

Event Sourcing means storing every state change as an event, rather than storing current state. The full history is preserved in the event store.

When combined with CQRS:
- The event store is the write model (command side)
- Projections built from events are the read model (query side)
- Events provide the synchronization mechanism between the two models
- New read models can be created at any time by replaying events

## Task-Based UIs

CQRS fits naturally with task-based UIs. Instead of CRUD forms that directly manipulate data, the UI presents tasks (commands) that represent business intentions:
- "Place Order" instead of "INSERT INTO orders"
- "Ship Product" instead of "UPDATE order SET status='shipped'"

This approach captures business intent, which is valuable for audit trails and process understanding.

## Common Misconceptions

1. CQRS requires Event Sourcing — False, they are independent patterns
2. CQRS requires separate databases — False, you can use a single database with separate read/write models
3. CQRS is suitable for all applications — False, it adds complexity and should only be used where the benefits justify it
4. CQRS means eventual consistency — Not necessarily, depends on whether separate databases are used
