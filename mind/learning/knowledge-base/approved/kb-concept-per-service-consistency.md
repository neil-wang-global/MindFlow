# Knowledge Base Entry

## Type
- concept

## Summary
- In microservice architectures, the CAP theorem's practical implication is that each service must independently determine its consistency requirement. The default should be eventual consistency; strong consistency (ACID) should be applied only where business requirements demand it (e.g., financial transactions, source-of-truth services). This per-component consistency decision is the operational translation of the CP/AP trade-off.

## Source Lineage
- Task ID: 20260401-fix-val-01
- Task Learning Record: mind/learning/task-learning/tl-20260401-fix-val-01.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-01-per-service-consistency.md
- Review File: mind/learning/reviews/review-20260401-fix-val-01-per-service-consistency.md
- Original Source Anchor: tasks/20260401-fix-val-01/acquire/raw-sources/src-001-azure-data-considerations.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/microservices/design/data-considerations

## Key Evidence
> "Define the required consistency level for each component, and prefer eventual consistency where possible. Identify areas in the system where you need strong consistency or atomicity, consistency, isolation, and durability (ACID) transactions. And identify areas where eventual consistency is acceptable."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-fix-val-01-per-service-consistency.md

## Applicability
- Applies to: microservice architecture design decisions where each service must choose between strong and eventual consistency; determining CP vs AP per bounded context; systems where different services have different consistency requirements
- Does not apply to: monolithic applications with a single shared database; systems where all components require the same consistency level; theoretical CAP analysis without implementation context

## Notes
- Extends the foundational CAP knowledge (kb-concept-cap-impossibility.md, kb-concept-cap-classification.md) with practical implementation guidance
- The "prefer eventual consistency" default aligns with the PACELC perspective (kb-concept-pacelc-extension.md) where latency-consistency trade-offs during normal operation favor eventual consistency for most services
