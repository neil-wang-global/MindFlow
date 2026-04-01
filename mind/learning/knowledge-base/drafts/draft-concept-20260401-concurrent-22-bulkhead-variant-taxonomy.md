# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-22

## Summary
- The bulkhead pattern has three primary consumer-side isolation variants: process-based, thread pool, and semaphore-based concurrency limiting, with library frameworks providing implementation support.

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-22.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-22/acquire/raw-sources/src-001-azure-bulkhead-pattern.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-22/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "When you partition consumers into bulkheads, consider using processes, thread pools, and semaphores. Projects like resilience4j and Polly offer a framework for creating consumer bulkheads."

## Candidate Conclusion
The bulkhead pattern has three primary consumer-side isolation variants: process-based isolation, thread pool isolation, and semaphore-based concurrency limiting. These are explicitly documented as distinct mechanisms in the Azure Architecture Center, with library frameworks (Resilience4j, Polly) providing implementation support for consumer-side bulkheads.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-22-bulkhead-variant-taxonomy.md

## Notes
- none
