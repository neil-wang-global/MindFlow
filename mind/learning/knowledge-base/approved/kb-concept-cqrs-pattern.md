# Knowledge Base Entry

## Type
- concept

## Summary
- CQRS separates read and write models into distinct objects/services, allowing each to be independently optimized. The write model enforces business rules and validates data; the read model provides denormalized views optimized for queries. When combined with Event Sourcing, the event store serves as the write model and projections built from events serve as the read model, with events providing the natural synchronization mechanism. CQRS should be applied selectively to specific bounded contexts where read/write asymmetry justifies the added complexity -- not as a system-wide architecture.

## Source Lineage
- Task ID: 20260401-concurrent-02
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-02.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-02-cqrs-pattern.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-02-cqrs-pattern.md`
- Original Source Anchor: `tasks/20260401-concurrent-02/acquire/raw-sources/src-005-cqrs-fowler.md`
- Original Source URL: https://martinfowler.com/bliki/CQRS.html

## Key Evidence
> "CQRS stands for Command Query Responsibility Segregation. It's a pattern that I first heard described by Greg Young. At its heart is the notion that you can use a different model to update information than the model you use to read information. For some situations, this separation can be valuable, but beware that for most systems CQRS adds risky complexity."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-02-cqrs-pattern.md`

## Applicability
- Applies to: highly collaborative domains with concurrent data access; systems with asymmetric read/write workloads; task-based UIs expressing business intent; scenarios requiring audit trails or temporal queries; bounded contexts where read optimization justifies complexity
- Does not apply to: simple CRUD domains; systems with simple business rules; situations where a single data model suffices for both reads and writes

## Notes
- CQRS and Event Sourcing are independent patterns that complement each other but neither requires the other
- Connects to existing CAP/PACELC knowledge: CQRS read replicas face the same consistency-latency trade-offs documented in kb-concept-pacelc-extension.md
