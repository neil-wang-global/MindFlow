# Knowledge Base Entry

## Type
- concept

## Summary
- The Saga pattern solves distributed transactions across microservices by replacing 2PC with a sequence of local transactions coordinated through either event-driven choreography (decentralized, loosely coupled) or command-driven orchestration (centralized, explicit control flow). Compensating transactions provide semantic rollback -- they undo the effect of preceding transactions without necessarily restoring exact prior state. Three transaction types exist: compensatable (can be undone), pivot (go/no-go decision point), and retriable (guaranteed to succeed after pivot).

## Source Lineage
- Task ID: 20260401-concurrent-02
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-02.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-02-saga-pattern.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-02-saga-pattern.md`
- Original Source Anchor: `tasks/20260401-concurrent-02/acquire/raw-sources/src-001-saga-microservices-io.md`
- Original Source URL: https://microservices.io/patterns/data/saga.html

## Key Evidence
> "Implement each business transaction that spans multiple services as a saga. A saga is a sequence of local transactions. Each local transaction updates the database and publishes a message or event to trigger the next local transaction in the saga. If a local transaction fails because it violates a business rule then the saga executes a series of compensating transactions that undo the changes that were made by the preceding local transactions. There are two ways of coordination sagas: **Choreography** - each local transaction publishes domain events that trigger local transactions in other services. **Orchestration** - an orchestrator (object) tells the participants what local transactions to execute."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-02-saga-pattern.md`

## Applicability
- Applies to: distributed microservice architectures requiring cross-service data consistency without 2PC; long-lived business transactions spanning multiple services; scenarios where eventual consistency is acceptable
- Does not apply to: single-database transactions; tightly coupled systems where ACID transactions suffice; latency-critical operations where saga coordination overhead is unacceptable

## Notes
- Concept originated in 1987 paper by Hector Garcia-Molina and Kenneth Salem (Princeton University) as alternative to long-lived database transactions
- Choreography suits simple workflows; orchestration suits complex workflows with many participants
