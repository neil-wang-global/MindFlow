# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-02

## Summary
- CQRS separates read and write models into distinct objects/services for independent optimization; when combined with Event Sourcing, the event store serves as write model and projections as read model; should be applied selectively to bounded contexts with read/write asymmetry

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-02.md`
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-02/acquire/raw-sources/src-005-cqrs-fowler.md`
  - ACQ Event: ACQ-002
  - Verification Report: `tasks/20260401-concurrent-02/acquire/verification-report.md §ACQ-002`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-002)

## Original Excerpt
> "CQRS stands for Command Query Responsibility Segregation. It's a pattern that I first heard described by Greg Young. At its heart is the notion that you can use a different model to update information than the model you use to read information. For some situations, this separation can be valuable, but beware that for most systems CQRS adds risky complexity."

## Candidate Conclusion
- CQRS separates read and write models into distinct objects/services, allowing each to be independently optimized. The write model enforces business rules and validates data; the read model provides denormalized views optimized for queries. When combined with Event Sourcing, the event store serves as the write model and projections built from events serve as the read model, with events providing the natural synchronization mechanism. CQRS should be applied selectively to specific bounded contexts where read/write asymmetry justifies the added complexity — not as a system-wide architecture.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-02-cqrs-pattern.md`

## Notes
- none
