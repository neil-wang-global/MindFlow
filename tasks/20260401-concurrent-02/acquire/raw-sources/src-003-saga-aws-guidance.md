# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001

## Source URL
- https://docs.aws.amazon.com/prescriptive-guidance/latest/modernization-data-persistence/saga-pattern.html

## Fetch Timestamp
- 2026-04-01T10:19:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — AWS official prescriptive guidance documentation; maintained by AWS Solutions Architects

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Saga pattern

The saga pattern is used to manage data consistency across microservices in distributed transaction scenarios. A saga is a sequence of local transactions where each transaction updates data within a single service. The first transaction in a saga is initiated by an external request corresponding to the system operation, and then each subsequent step is triggered by the completion of the previous one.

## Using sagas to maintain data consistency

Using sagas is one of the best ways to maintain data consistency in a system that uses multiple services, each of which has its own database. This concept was first published in a 1987 paper by Hector Garcia-Molina and Kenneth Salem of Princeton University. The paper proposed the concept of a saga as an alternative to long-lived transactions that lock database resources.

In distributed architectures, ACID compliance across databases isn't feasible. A saga provides transaction management using a sequence of local transactions. A local transaction is the atomic work effort performed by a saga participant. Each local transaction updates the database and publishes a message or event to trigger the next local transaction.

## Choreography-based saga

In a choreography-based saga implementation, coordination logic resides in the saga participants. The saga participants exchange events without a centralized point of control. With choreography, each local transaction publishes domain events that trigger local transactions in other services.

Benefits include simplicity, loose coupling, and no single point of failure. However, it can become difficult to understand and track when there are many saga participants, and there is a risk of cyclic dependencies.

## Orchestration-based saga

In an orchestration-based saga implementation, coordination logic resides in the saga orchestrator. The saga orchestrator manages all the transactions and tells the participants which operation to perform based on events. The orchestrator executes saga requests, stores and interprets the states of each task, and handles failure recovery with compensating transactions.

Benefits include centralized coordination, simplified participant logic, and easier monitoring. Drawbacks include orchestrator as single point of failure and additional infrastructure complexity.

## Compensating transactions

Each transaction in a saga can be undone by a compensating transaction. Compensating transactions must be idempotent so they can be retried safely. Three types of transactions exist in a saga:

1. **Compensable transactions** — transactions that can be reversed by processing a compensating transaction
2. **Pivot transaction** — the go/no-go point in the saga; if the pivot transaction commits, the saga runs until completion; it can be a transaction that is neither compensable nor retryable, or the last compensable transaction or the first retryable transaction
3. **Retryable transactions** — transactions that follow the pivot transaction and are guaranteed to succeed

## When to use sagas

Use the saga pattern when:
- You need to ensure data consistency in a distributed system without tight coupling
- You need to roll back or compensate if one of the operations in a sequence fails
- You are dealing with long-lived transactions and you don't want other database transactions to be blocked

Avoid the saga pattern when:
- Tight coupling is required
- A single database can handle all transactions
- Performance and latency are critical (saga coordination adds overhead)
