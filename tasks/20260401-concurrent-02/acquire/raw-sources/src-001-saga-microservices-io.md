# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://microservices.io/patterns/data/saga.html

## Fetch Timestamp
- 2026-04-01T10:17:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Chris Richardson is the recognized authority on microservice patterns; microservices.io is the canonical pattern catalog

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Pattern: Saga

## Context

You have applied the Database per Service pattern. Each service has its own database. Some business transactions, however, span multiple services so you need a mechanism to implement transactions that span services. For example, let's imagine that you are building an e-commerce store where customers have a credit limit. The application must ensure that a new order will not exceed the customer's credit limit. Since Orders and Customers are in different databases owned by different services, the application cannot simply use a local ACID transaction.

## Problem

How to implement transactions that span services?

## Forces

- 2PC is not an option (coordinator is a single point of failure, chatty protocol, reduced throughput due to locks, not supported by many NoSQL databases or message brokers)

## Solution

Implement each business transaction that spans multiple services as a saga. A saga is a sequence of local transactions. Each local transaction updates the database and publishes a message or event to trigger the next local transaction in the saga. If a local transaction fails because it violates a business rule then the saga executes a series of compensating transactions that undo the changes that were made by the preceding local transactions.

There are two ways of coordination sagas:

**Choreography** - each local transaction publishes domain events that trigger local transactions in other services.

**Orchestration** - an orchestrator (object) tells the participants what local transactions to execute.

### Choreography-based saga

An e-commerce application that uses this approach would create an order using a choreography-based saga that consists of the following steps:

1. The Order Service receives the POST /orders request and creates an Order in a PENDING state
2. It then emits an Order Created event
3. The Customer Service's event handler attempts to reserve credit
4. It then emits an event indicating the outcome
5. The Order Service's event handler either approves or rejects the Order

### Orchestration-based saga

An e-commerce application that uses this approach would create an order using an orchestration-based saga that consists of the following steps:

1. The Order Service receives the POST /orders request and creates the Create Order saga orchestrator
2. The saga orchestrator creates an Order in the PENDING state
3. It then sends a Reserve Credit command to the Customer Service
4. The Customer Service attempts to reserve credit
5. It then sends back a reply message indicating the outcome
6. The saga orchestrator either approves or rejects the Order

## Resulting Context

This pattern has the following benefits:

- It enables an application to maintain data consistency across multiple services without using distributed transactions

This solution has the following drawbacks:

- The programming model is more complex. For example, a developer must design compensating transactions that explicitly undo changes made earlier in a saga.
- In order to be reliable, a service must atomically update its database and publish a message/event. It cannot use the traditional mechanism of a distributed transaction that spans the database and the message broker. Instead, it must use one of the patterns listed below.

There are also the following issues to address:

- In order to be reliable, a service must atomically update its database and publish a message/event.
- The client needs to be able to handle failure due to sagas that are rolled back due to the violation of a business rule.

### Compensating Transactions

A compensating transaction must be idempotent and retriable. Each step in a saga that could fail must have a corresponding compensating transaction. Compensating transactions must be semantically undoing — they don't necessarily restore the database to its original state but instead create a new state that semantically cancels the effect of the original transaction.

Three types of saga steps:
- **Compensatable transactions**: transactions that can potentially be compensated (have compensating transactions)
- **Pivot transaction**: the go/no-go point in the saga; if the pivot transaction commits, the saga runs until completion
- **Retriable transactions**: transactions that follow the pivot transaction and are guaranteed to succeed

## Related Patterns

- Database per Service pattern creates the need for this pattern
- The following patterns are ways to atomically update state and publish messages/events: Event Sourcing, Transactional Outbox
- A choreography-based saga can publish events using Aggregates and Domain Events
