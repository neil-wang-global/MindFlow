# Knowledge Base Entry

## Type
- concept

## Summary
- DDD bounded contexts provide the structural framework for applying CAP trade-offs at the microservice level. Each bounded context maps to one or more microservices, and each must own its domain model and database. This alignment means database selection is not a global architecture decision but a per-bounded-context decision, where the context's data model, access patterns, and consistency requirements determine the appropriate CAP trade-off.

## Source Lineage
- Task ID: 20260401-fix-val-01
- Task Learning Record: mind/learning/task-learning/tl-20260401-fix-val-01.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-01-bounded-context-db-selection.md
- Review File: mind/learning/reviews/review-20260401-fix-val-01-bounded-context-db-selection.md
- Original Source Anchor: tasks/20260401-fix-val-01/acquire/raw-sources/src-002-dotnet-data-sovereignty.md
- Original Source URL: https://learn.microsoft.com/en-us/dotnet/architecture/microservices/architect-microservice-container-applications/data-sovereignty-per-microservice

## Key Evidence
> "Each DDD Bounded Context correlates to one business microservice (one or several services). This point about the Bounded Context pattern is expanded in the next section."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-fix-val-01-bounded-context-db-selection.md

## Applicability
- Applies to: microservice architecture design guided by DDD; determining service boundaries and their associated data stores; translating bounded context analysis into database selection decisions
- Does not apply to: systems not using DDD bounded context modeling; microservices without clear domain boundaries; purely technical (non-domain-driven) service decomposition

## Notes
- The bounded context to microservice mapping is not always 1:1 — a bounded context may be composed of several physical services, but data ownership remains at the bounded context level
