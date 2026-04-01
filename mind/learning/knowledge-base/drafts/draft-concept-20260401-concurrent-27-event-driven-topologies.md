# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-27

## Summary
- Event-driven architectures have two primary topologies: broker (decentralized, highly decoupled, scalable) and mediator (centralized flow control, better error handling but bottleneck risk)

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-27.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-27/acquire/raw-sources/src-002-azure-event-driven.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-27/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Broker topology: Components broadcast events to the entire system. Other components either act on the event or ignore the event. This topology is useful when the event processing flow is relatively simple. This topology is highly decoupled, which helps provide scalability, responsiveness, and component fault tolerance. Mediator topology: There's an event mediator that manages and controls the flow of events. The event mediator maintains the state and manages error handling and restart capabilities. This topology provides more control, better distributed error handling, and potentially better data consistency. However, it introduces increased coupling between components, and the event mediator can become a bottleneck or a reliability concern."

## Candidate Conclusion
- Event-driven architectures have two primary topologies — broker (decentralized, highly decoupled, scalable but risks data inconsistency) and mediator (centralized flow control, better error handling but introduces coupling and bottleneck risk). The topology choice depends on whether the system prioritizes decoupling and fault tolerance (broker) or coordinated error handling and consistency (mediator).

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-27-event-driven-topologies.md

## Notes
- Source is Microsoft Azure Architecture Center official documentation
