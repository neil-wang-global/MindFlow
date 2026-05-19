# Knowledge Base Entry

## Type
- concept

## Summary
- Access patterns are the primary discriminator for database selection within microservices. A real-world application (drone delivery) demonstrates that even within a single system, four different bounded contexts selected four different database technologies (Redis for high-throughput status tracking, Data Lake for analytics, Cosmos DB for time-series lookup, DocumentDB for high-write document storage). The selection criteria are: read/write profile, query complexity, data lifespan, and consistency requirements — not theoretical CAP classification alone.

## Source Lineage
- Task ID: 20260401-fix-val-01
- Task Learning Record: mind/learning/task-learning/tl-20260401-fix-val-01.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-01-access-pattern-selection.md
- Review File: mind/learning/reviews/review-20260401-fix-val-01-access-pattern-db-selection.md
- Original Source Anchor: tasks/20260401-fix-val-01/acquire/raw-sources/src-001-azure-data-considerations.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/microservices/design/data-considerations

## Key Evidence
> "the delivery service requires a data store that emphasizes throughput (read and write) over long-term storage. The delivery service doesn't do complex queries or analysis. It only fetches the latest status for a specific delivery. The delivery service team chose Azure Managed Redis for its high read-write performance."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-fix-val-01-access-pattern-db-selection.md

## Applicability
- Applies to: microservice database technology selection; evaluating database options based on concrete workload characteristics; translating CAP trade-offs into practical technology choices
- Does not apply to: greenfield projects without established access patterns; systems where all services have identical workload profiles; database selection for non-microservice architectures

## Notes
- The drone delivery example demonstrates that theoretical CAP classification (CP/AP) is necessary but not sufficient for database selection — practical criteria like read/write throughput, query complexity, data lifespan, and cost optimization are equally important discriminators
