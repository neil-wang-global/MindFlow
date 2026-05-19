# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-01

## Summary
- Access patterns (read/write profile, query complexity, data lifespan, consistency requirements) are the primary discriminator for database selection within microservices, as demonstrated by a drone delivery application using four different databases for four bounded contexts.

## From Task Learning
- mind/learning/task-learning/tl-20260401-fix-val-01.md
- candidate knowledge item reference: KDC-004

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-fix-val-01/acquire/raw-sources/src-001-azure-data-considerations.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-fix-val-01/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "the delivery service requires a data store that emphasizes throughput (read and write) over long-term storage. The delivery service doesn't do complex queries or analysis. It only fetches the latest status for a specific delivery. The delivery service team chose Azure Managed Redis for its high read-write performance."

## Candidate Conclusion
- Access patterns are the primary discriminator for database selection within microservices. A real-world application (drone delivery) demonstrates that even within a single system, four different bounded contexts selected four different database technologies (Redis for high-throughput status tracking, Data Lake for analytics, Cosmos DB for time-series lookup, DocumentDB for high-write document storage). The selection criteria are: read/write profile, query complexity, data lifespan, and consistency requirements — not theoretical CAP classification alone.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-fix-val-01-access-pattern-selection.md

## Notes
- none
