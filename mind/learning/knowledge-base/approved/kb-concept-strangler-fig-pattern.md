# Knowledge Base Entry

## Type
- concept

## Summary
- The Strangler Fig pattern enables incremental legacy migration by building new microservices around the existing monolith, using a routing layer (proxy/facade/API gateway) to progressively redirect traffic from old to new implementations. The Anti-Corruption Layer (from Eric Evans' DDD) serves as a translator between old and new domain models, preventing legacy design decisions from polluting the new system. The three-phase mechanism (identify seams, transform by building new services, redirect via routing) eliminates big-bang rewrite risk and allows rollback at any point by redirecting traffic back to the legacy system.

## Source Lineage
- Task ID: 20260401-concurrent-02
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-02.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-02-strangler-fig-pattern.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-02-strangler-fig-pattern.md`
- Original Source Anchor: `tasks/20260401-concurrent-02/acquire/raw-sources/src-009-strangler-fig-fowler.md`
- Original Source URL: https://martinfowler.com/bliki/StranglerFigApplication.html

## Key Evidence
> "The alternative is to gradually create a new system around the edges of the old, letting it grow slowly over several years until the old system is strangled. An important part of the Strangler Fig Application pattern is that the old and new can coexist, giving the new system time to grow and potentially for you to learn from the new system before making too many commitments."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-02-strangler-fig-pattern.md`

## Applicability
- Applies to: legacy monolith modernization to microservices; situations where big-bang rewrite risk is unacceptable; systems that can be decomposed along functional boundaries; teams that need incremental delivery of value during migration
- Does not apply to: greenfield microservice development; systems too small to justify migration overhead; cases where the legacy system has no clear functional seams for extraction

## Notes
- Named by Martin Fowler after the strangler fig tree observed in Australian rainforests
- Anti-Corruption Layer concept originates from Eric Evans' Domain-Driven Design
- Migration can stall without organizational commitment -- requires active management and deadlines
