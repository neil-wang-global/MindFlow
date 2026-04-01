# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-02

## Summary
- Saga pattern solves distributed transactions across microservices using a sequence of local transactions coordinated through choreography (event-driven, decentralized) or orchestration (command-driven, centralized), with compensating transactions providing semantic rollback via three transaction types: compensatable, pivot, and retriable

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-02.md`
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-02/acquire/raw-sources/src-001-saga-microservices-io.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-concurrent-02/acquire/verification-report.md §ACQ-001`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-001)

## Original Excerpt
> "Implement each business transaction that spans multiple services as a saga. A saga is a sequence of local transactions. Each local transaction updates the database and publishes a message or event to trigger the next local transaction in the saga. If a local transaction fails because it violates a business rule then the saga executes a series of compensating transactions that undo the changes that were made by the preceding local transactions. There are two ways of coordination sagas: **Choreography** - each local transaction publishes domain events that trigger local transactions in other services. **Orchestration** - an orchestrator (object) tells the participants what local transactions to execute."

## Candidate Conclusion
- The Saga pattern solves distributed transactions across microservices by replacing 2PC with a sequence of local transactions coordinated through either event-driven choreography (decentralized, loosely coupled) or command-driven orchestration (centralized, explicit control flow). Compensating transactions provide semantic rollback — they undo the effect of preceding transactions without necessarily restoring exact prior state. Three transaction types exist: compensatable (can be undone), pivot (go/no-go decision point), and retriable (guaranteed to succeed after pivot).

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-02-saga-pattern.md`

## Notes
- none
