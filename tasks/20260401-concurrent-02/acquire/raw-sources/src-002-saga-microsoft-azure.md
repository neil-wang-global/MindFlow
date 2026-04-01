# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/saga/saga

## Fetch Timestamp
- 2026-04-01T10:18:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Microsoft Azure official architecture documentation; maintained by Microsoft cloud architecture team

## Fetch Status
- success

## Fetch Completeness
- truncated — tool output limit reached; core pattern description and implementation guidance captured

## Original Content

# Saga distributed transactions pattern

The Saga design pattern is a way to manage data consistency across microservices in distributed transaction scenarios. A saga is a sequence of transactions that updates each service and publishes a message or event to trigger the next transaction step. If a step fails, the saga executes compensating transactions that counteract the preceding transactions.

## Context and problem

A transaction is a single unit of logic or work, sometimes made up of multiple operations. Within a transaction, an event is a state change that occurs to an entity, and a command encapsulates all information needed to perform an action or trigger a later event.

Transactions must be atomic, consistent, isolated, and durable (ACID). Transactions within a single service are straightforward, but cross-service data consistency requires a cross-service transaction strategy.

In multi-service architectures, two-phase commit (2PC) protocols can block participants, reduce throughput, and create availability concerns. The Saga pattern provides an alternative.

## Saga overview

In a saga, each service that participates in the saga performs its own local transaction and publishes an event. Other services listen to that event and perform the next local transaction. If one local transaction fails, the saga executes a series of compensating transactions to roll back the changes.

### Choreography

In choreography, each service produces and listens to other services' events and decides if an action should be taken or not.

**Advantages:**
- Good for simple workflows that require few participants and don't need a coordination logic
- Doesn't require additional service implementation and maintenance
- Doesn't introduce a single point of failure, since the responsibilities are distributed across the saga participants

**Disadvantages:**
- Workflow can become confusing when adding new steps, as it's difficult to track which saga participants listen to which commands
- There's a risk of cyclic dependency between saga participants because they have to consume each other's commands
- Integration testing is difficult because all services must be running to simulate a transaction

### Orchestration

In orchestration, an orchestrator (object) takes responsibility for a saga's decision making and sequencing of business logic.

**Advantages:**
- Good for complex workflows involving many participants or new participants added over time
- Suitable when there is control over every participant in the process, and control over the flow of activities
- Doesn't introduce cyclic dependencies, because the orchestrator unilaterally depends on the saga participants
- Saga participants don't need to know about commands for other participants. Clear separation of concerns simplifies business logic

**Disadvantages:**
- Additional design complexity requires an implementation of a coordination logic
- There's an additional point of failure, because the orchestrator manages the complete workflow

### Compensating transactions

Transactions in a saga are executed sequentially. When the flow of saga transactions is interrupted, compensating transactions are run to reverse the preceding successful transactions.

Key principles:
- Compensating transactions are idempotent and retryable
- Steps that can fail have a compensating transaction
- Compensating transactions are executed in reverse order of the forward transactions
- A compensating transaction must semantically undo the effect of the prior transaction

**Saga execution coordinator (SEC)** is a core component that manages saga lifecycle:
1. Stores and interprets a saga as a sequence of steps, where each step maps to a command and compensating command
2. Executes steps in sequence
3. On failure, executes compensating commands in reverse order
4. Handles persistent log to recover from coordinator failures

## When to use this pattern

Use the Saga pattern when you need to:
- Ensure data consistency in a distributed system without tight coupling
- Roll back or compensate if one of the operations in the sequence fails

The Saga pattern is less suitable for:
- Tightly coupled transactions
- Compensating transactions that occur in earlier participants
- Cyclic dependencies
