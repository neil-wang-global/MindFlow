# Saga Pattern — Knowledge Acquisition Summary

## Task ID
- 20260401-concurrent-02

## Pattern
- Saga Pattern for Distributed Transactions in Microservices

## ACQ Event
- ACQ-001

## Verified Sources
- src-001: microservices.io (Chris Richardson's canonical pattern catalog)
- src-002: Microsoft Azure architecture docs
- src-003: AWS prescriptive guidance

## Key Findings

### Core Concept
A saga is a sequence of local transactions where each service updates its own database and publishes a message/event to trigger the next transaction. If a local transaction fails, compensating transactions undo preceding changes.

### Choreography vs Orchestration

**Choreography**: Each service produces and listens to events independently. No central coordinator.
- Advantages: loose coupling, no single point of failure, simple for small workflows
- Disadvantages: hard to track with many participants, risk of cyclic dependencies, difficult integration testing

**Orchestration**: A central orchestrator manages the saga lifecycle, issuing commands and handling replies.
- Advantages: centralized control, clear separation of concerns, easier monitoring, good for complex workflows
- Disadvantages: orchestrator is single point of failure, additional design complexity

### Compensating Transactions
- Must be idempotent and retryable
- Semantically undo effects (not necessarily restore exact state)
- Three transaction types: compensatable (can be undone), pivot (go/no-go point), retriable (guaranteed to succeed after pivot)
- Execute in reverse order of forward transactions

### When to Use
- Data consistency across distributed services without tight coupling
- Long-lived transactions where database locks are unacceptable
- Avoid when: tight coupling required, single database sufficient, latency-critical operations

## Historical Note
- Concept first published in 1987 by Hector Garcia-Molina and Kenneth Salem (Princeton University) as alternative to long-lived transactions
