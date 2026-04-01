# Knowledge Base Entry

## Type
- concept

## Summary
- Event-driven architectures have two primary topologies — broker (decentralized, highly decoupled, scalable but risks data inconsistency) and mediator (centralized flow control, better error handling but introduces coupling and bottleneck risk). The topology choice depends on whether the system prioritizes decoupling and fault tolerance (broker) or coordinated error handling and consistency (mediator).

## Source Lineage
- Task ID: 20260401-concurrent-27
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-27.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-27-event-driven-topologies.md
- Review File: mind/learning/reviews/review-20260401-concurrent-27-event-driven-topologies.md
- Original Source Anchor: tasks/20260401-concurrent-27/acquire/raw-sources/src-002-azure-event-driven.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven

## Key Evidence
> "Broker topology: Components broadcast events to the entire system. Other components either act on the event or ignore the event. This topology is useful when the event processing flow is relatively simple. This topology is highly decoupled, which helps provide scalability, responsiveness, and component fault tolerance. Mediator topology: There's an event mediator that manages and controls the flow of events. The event mediator maintains the state and manages error handling and restart capabilities. This topology provides more control, better distributed error handling, and potentially better data consistency. However, it introduces increased coupling between components, and the event mediator can become a bottleneck or a reliability concern."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-27-event-driven-topologies.md

## Applicability
- Applies to: microservice architecture design, event-driven system topology decisions, distributed systems communication pattern selection
- Does not apply to: monolithic applications, single-process event handling, in-process pub-sub patterns

## Notes
- Source is Microsoft Azure Architecture Center official documentation (2026)
