# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-01

## Summary
- DDD bounded contexts provide the structural framework for applying CAP trade-offs at the microservice level; each bounded context maps to one or more microservices and must own its domain model and database, making database selection a per-bounded-context decision.

## From Task Learning
- mind/learning/task-learning/tl-20260401-fix-val-01.md
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-fix-val-01/acquire/raw-sources/src-002-dotnet-data-sovereignty.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-fix-val-01/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Each DDD Bounded Context correlates to one business microservice (one or several services). This point about the Bounded Context pattern is expanded in the next section."

## Candidate Conclusion
- DDD bounded contexts provide the structural framework for applying CAP trade-offs at the microservice level. Each bounded context maps to one or more microservices, and each must own its domain model and database. This alignment means database selection is not a global architecture decision but a per-bounded-context decision, where the context's data model, access patterns, and consistency requirements determine the appropriate CAP trade-off.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-fix-val-01-bounded-context-db-selection.md

## Notes
- none
