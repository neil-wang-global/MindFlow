# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-002

## Source URL
- https://martinfowler.com/bliki/CQRS.html

## Fetch Timestamp
- 2026-04-01T10:32:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Martin Fowler is a recognized authority on software architecture; martinfowler.com is a canonical reference for enterprise patterns

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# CQRS

CQRS stands for Command Query Responsibility Segregation. It's a pattern that I first heard described by Greg Young. At its heart is the notion that you can use a different model to update information than the model you use to read information. For some situations, this separation can be valuable, but beware that for most systems CQRS adds risky complexity.

The mainstream approach people use for interacting with an information system is to treat it as a CRUD datastore. By this I mean that we have mental model of some record structure where we can create new records, read records, update existing records, and delete records when we're done with them. In the simplest case, our interactions are all about storing and retrieving these records.

As our needs become more sophisticated we steadily move away from that model. We may want to look at the information in a different way to the record store, perhaps collapsing multiple records into one, or forming virtual records by combining information for different places. On the update side we may find validation rules that only allow certain combinations of data to be stored, or may even infer data to be stored that's different from what we provide.

The change that CQRS introduces is to split that conceptual model into separate models for update and display, which it refers to as Command and Query respectively following the vocabulary of CommandQuerySeparation.

There's room for considerable variation here. The in-memory models may share the same database, in which case the database acts as the communication between the two models. However they may also use separate databases, effectively making the read-side's database into a real-time ReportingDatabase. In this case there needs to be some communication mechanism between the two models or their databases.

## When to use it

Like any pattern, CQRS is useful in some places, but not in others. Many systems do fit a CRUD mental model, and so should be done in that style. CQRS is a significant mental leap for all concerned, so shouldn't be tackled unless the benefit is worth the jump.

CQRS fits well with some complex domains that are well-suited to event-based programming models. Event Sourcing is a good example of this — CQRS with event sourcing allows you to easily test and reproduce states by replaying events.

Some suitable places to use CQRS:
- Highly collaborative domains where many users access the same data in parallel
- Complex domains with many different representations of the data
- Scenarios where a history of changes (audit trail) is needed

CQRS should not be applied to an entire system — use it only in specific bounded contexts where the benefit justifies the added complexity.

## CQRS and Event Sourcing

CQRS is often mentioned in conjunction with Event Sourcing. Event Sourcing ensures that all changes to application state are stored as a sequence of events. Not just can we query these events, we can also use the event log to reconstruct past states, and as a foundation to automatically adjust the state to cope with retroactive changes.

The combination works well because:
- Events provide a natural mechanism for keeping the read model in sync with the write model
- The event store serves as the write model, while projections built from events serve as the read model
- Temporal queries and audit trails come naturally from the event log
- The separation of concerns between commands and queries aligns with the separation between the event store and projections
