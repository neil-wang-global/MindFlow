# Task Learning Record

## Task ID
- 20260401-concurrent-02

## Task Summary
- Systematically acquired verified knowledge on three microservice design patterns (Saga, CQRS, Strangler Fig) from primary sources
- Produced 3 knowledge acquisition events (ACQ-001, ACQ-002, ACQ-003) with 12 raw sources total, 11 passed verification
- Generated 3 knowledge artifact summaries in _output/

## External Acquisition

### ACQ-001: Saga Pattern — choreography vs orchestration, compensating transactions

- **Trigger**: step-triggered: Step 2
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-02/acquire/verification-report.md` §ACQ-001
- **Passed Sources**: src-001, src-002, src-003

### ACQ-002: CQRS Pattern — command-query separation, event sourcing integration

- **Trigger**: step-triggered: Step 3
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-02/acquire/verification-report.md` §ACQ-002
- **Passed Sources**: src-005, src-006, src-007, src-008

### ACQ-003: Strangler Fig Pattern — incremental migration, anti-corruption layer

- **Trigger**: step-triggered: Step 4
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-02/acquire/verification-report.md` §ACQ-003
- **Passed Sources**: src-009, src-010, src-011, src-012

## Candidate Knowledge

### [KDC-001] Saga Pattern: Choreography vs Orchestration and Compensating Transactions

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-02/acquire/raw-sources/src-001-saga-microservices-io.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Implement each business transaction that spans multiple services as a saga. A saga is a sequence of local transactions. Each local transaction updates the database and publishes a message or event to trigger the next local transaction in the saga. If a local transaction fails because it violates a business rule then the saga executes a series of compensating transactions that undo the changes that were made by the preceding local transactions. There are two ways of coordination sagas: **Choreography** - each local transaction publishes domain events that trigger local transactions in other services. **Orchestration** - an orchestrator (object) tells the participants what local transactions to execute."
- **Derived Conclusion**: The Saga pattern solves distributed transactions across microservices by replacing 2PC with a sequence of local transactions coordinated through either event-driven choreography (decentralized, loosely coupled) or command-driven orchestration (centralized, explicit control flow). Compensating transactions provide semantic rollback — they undo the effect of preceding transactions without necessarily restoring exact prior state. Three transaction types exist: compensatable (can be undone), pivot (go/no-go decision point), and retriable (guaranteed to succeed after pivot).

### [KDC-002] CQRS: Command-Query Separation with Event Sourcing Integration

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-02/acquire/raw-sources/src-005-cqrs-fowler.md`
- **Verification Status**: passed
- **Original Excerpt**: > "CQRS stands for Command Query Responsibility Segregation. It's a pattern that I first heard described by Greg Young. At its heart is the notion that you can use a different model to update information than the model you use to read information. For some situations, this separation can be valuable, but beware that for most systems CQRS adds risky complexity."
- **Derived Conclusion**: CQRS separates read and write models into distinct objects/services, allowing each to be independently optimized. The write model enforces business rules and validates data; the read model provides denormalized views optimized for queries. When combined with Event Sourcing, the event store serves as the write model and projections built from events serve as the read model, with events providing the natural synchronization mechanism. CQRS should be applied selectively to specific bounded contexts where read/write asymmetry justifies the added complexity — not as a system-wide architecture.

### [KDC-003] Strangler Fig Pattern: Incremental Migration with Anti-Corruption Layer

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-003
- **Source Anchor**: `tasks/20260401-concurrent-02/acquire/raw-sources/src-009-strangler-fig-fowler.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The alternative is to gradually create a new system around the edges of the old, letting it grow slowly over several years until the old system is strangled. An important part of the Strangler Fig Application pattern is that the old and new can coexist, giving the new system time to grow and potentially for you to learn from the new system before making too many commitments."
- **Derived Conclusion**: The Strangler Fig pattern enables incremental legacy migration by building new microservices around the existing monolith, using a routing layer (proxy/facade/API gateway) to progressively redirect traffic from old to new implementations. The Anti-Corruption Layer (from Eric Evans' DDD) serves as a translator between old and new domain models, preventing legacy design decisions from polluting the new system. The three-phase mechanism (identify seams, transform by building new services, redirect via routing) eliminates big-bang rewrite risk and allows rollback at any point by redirecting traffic back to the legacy system.

## Potential Capability Impact
- No capability changes required; existing web-search and source-verification capabilities were sufficient

## Next Promotion Target
- KDC-001: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-02-saga-pattern.md`
- KDC-002: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-02-cqrs-pattern.md`
- KDC-003: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-02-strangler-fig-pattern.md`

## Notes
- none
