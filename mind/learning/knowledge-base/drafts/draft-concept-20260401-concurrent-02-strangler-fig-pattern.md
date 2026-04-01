# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-02

## Summary
- Strangler Fig pattern enables incremental legacy migration by building new microservices around existing monolith with routing layer for progressive traffic redirection and Anti-Corruption Layer for domain model isolation between old and new systems

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-02.md`
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-02/acquire/raw-sources/src-009-strangler-fig-fowler.md`
  - ACQ Event: ACQ-003
  - Verification Report: `tasks/20260401-concurrent-02/acquire/verification-report.md §ACQ-003`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-003)

## Original Excerpt
> "The alternative is to gradually create a new system around the edges of the old, letting it grow slowly over several years until the old system is strangled. An important part of the Strangler Fig Application pattern is that the old and new can coexist, giving the new system time to grow and potentially for you to learn from the new system before making too many commitments."

## Candidate Conclusion
- The Strangler Fig pattern enables incremental legacy migration by building new microservices around the existing monolith, using a routing layer (proxy/facade/API gateway) to progressively redirect traffic from old to new implementations. The Anti-Corruption Layer (from Eric Evans' DDD) serves as a translator between old and new domain models, preventing legacy design decisions from polluting the new system. The three-phase mechanism (identify seams, transform by building new services, redirect via routing) eliminates big-bang rewrite risk and allows rollback at any point by redirecting traffic back to the legacy system.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-02-strangler-fig-pattern.md`

## Notes
- none
