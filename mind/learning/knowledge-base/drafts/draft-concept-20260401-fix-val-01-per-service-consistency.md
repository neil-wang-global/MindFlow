# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-01

## Summary
- In microservice architectures, each service must independently determine its consistency requirement, defaulting to eventual consistency unless business requirements demand strong consistency (ACID). This per-component consistency decision is the operational translation of the CP/AP trade-off.

## From Task Learning
- mind/learning/task-learning/tl-20260401-fix-val-01.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-fix-val-01/acquire/raw-sources/src-001-azure-data-considerations.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-fix-val-01/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Define the required consistency level for each component, and prefer eventual consistency where possible. Identify areas in the system where you need strong consistency or atomicity, consistency, isolation, and durability (ACID) transactions. And identify areas where eventual consistency is acceptable."

## Candidate Conclusion
- In microservice architectures, the CAP theorem's practical implication is that each service must independently determine its consistency requirement. The default should be eventual consistency; strong consistency (ACID) should be applied only where business requirements demand it (e.g., financial transactions, source-of-truth services). This per-component consistency decision is the operational translation of the CP/AP trade-off.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-fix-val-01-per-service-consistency.md

## Notes
- none
