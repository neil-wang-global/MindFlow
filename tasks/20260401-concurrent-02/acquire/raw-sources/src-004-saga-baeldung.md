# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-001

## Source URL
- https://www.baeldung.com/cs/saga-pattern-microservices

## Fetch Timestamp
- 2026-04-01T10:20:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- Medium — Baeldung is a well-known technical education site with peer-reviewed content; not an original source but provides structured technical explanations

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Saga Pattern in Microservices

## Overview

In this tutorial, we'll look at the Saga pattern for implementing distributed transactions in microservice-based applications.

## The Problem

In a monolithic application, a single database transaction can ensure data consistency. However, in a microservices architecture, each service has its own database. A business transaction that spans multiple services cannot use a single ACID transaction.

The traditional approach of using distributed transactions (2PC - Two-Phase Commit) has significant drawbacks in a microservices environment: reduced availability due to locking, reduced throughput, and the coordinator becoming a single point of failure.

## The Saga Pattern

A saga is a sequence of local transactions. Each local transaction updates the database of a single service and publishes a message or event. If a local transaction fails because of a business rule violation, the saga executes compensating transactions to undo the changes.

### Choreography-based Saga

In choreography, there is no central coordinator. Each service produces events after completing its local transaction and listens to events from other services.

Example flow for an order:
1. Order Service creates order (PENDING) and emits OrderCreated event
2. Payment Service receives event, processes payment, emits PaymentProcessed
3. Inventory Service receives event, reserves stock, emits StockReserved
4. Order Service receives event, confirms order (CONFIRMED)

If payment fails: Payment Service emits PaymentFailed, Order Service cancels the order (compensating transaction).

### Orchestration-based Saga

In orchestration, a single orchestrator is responsible for managing the overall transaction status. It issues commands to each service and handles their replies.

Example flow:
1. Saga Orchestrator receives CreateOrder command
2. Orchestrator sends ProcessPayment to Payment Service
3. On success reply, Orchestrator sends ReserveStock to Inventory Service
4. On success reply, Orchestrator sends ConfirmOrder to Order Service
5. On any failure, Orchestrator triggers compensating transactions in reverse

### Comparison

| Aspect | Choreography | Orchestration |
|--------|-------------|---------------|
| Coupling | Loose | Tight (to orchestrator) |
| Complexity | Grows with participants | Centralized |
| Failure point | Distributed | Orchestrator |
| Visibility | Hard to track | Easy to monitor |
| Best for | Simple sagas | Complex sagas |

### Compensating Transactions

Key properties:
- Must be idempotent
- Must be retryable
- Must semantically undo the original transaction (not necessarily restore exact state)
- Should be designed alongside forward transactions

The saga execution order matters: compensating transactions run in reverse order of the forward transactions.

## Conclusion

The Saga pattern is essential for maintaining data consistency in microservice architectures where traditional distributed transactions are impractical. The choice between choreography and orchestration depends on the complexity of the workflow and the desired level of coupling.
