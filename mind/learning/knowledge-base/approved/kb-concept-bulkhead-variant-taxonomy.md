# Knowledge Base Entry

## Type
- concept

## Summary
- The bulkhead pattern has three primary consumer-side isolation variants: process-based isolation, thread pool isolation, and semaphore-based concurrency limiting. These are explicitly documented as distinct mechanisms in the Azure Architecture Center, with library frameworks (Resilience4j, Polly) providing implementation support for consumer-side bulkheads.

## Source Lineage
- Task ID: 20260401-concurrent-22
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-22.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-22-bulkhead-variant-taxonomy.md
- Review File: mind/learning/reviews/review-20260401-concurrent-22-bulkhead-variant-taxonomy.md
- Original Source Anchor: tasks/20260401-concurrent-22/acquire/raw-sources/src-001-azure-bulkhead-pattern.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/patterns/bulkhead

## Key Evidence
> "When you partition consumers into bulkheads, consider using processes, thread pools, and semaphores. Projects like resilience4j and Polly offer a framework for creating consumer bulkheads."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-22-bulkhead-variant-taxonomy.md

## Applicability
- Applies to: microservice architectures requiring fault isolation between service dependencies; consumer-side isolation where different downstream services must be protected from mutual resource exhaustion; any distributed system using synchronous calls to multiple external services
- Does not apply to: single-service monolithic applications; purely event-driven architectures where isolation is already provided by message broker partitioning; systems where resource overhead constraints make isolation impractical

## Notes
- Grounded in Microsoft Azure Architecture Center documentation; independently verified via ACQ-001
- The three variants represent a spectrum from lightweight (semaphore) to heavyweight (process-level) isolation, each with different trade-offs appropriate for different architectural contexts
