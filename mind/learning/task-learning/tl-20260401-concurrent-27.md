# Task Learning Record

## Task ID
- 20260401-concurrent-27

## Task Summary
- Evaluated the architectural trade-off between event-driven and request-response communication patterns for microservices
- Produced a hybrid architecture recommendation deliverable in _output/architecture-recommendation.md
- Triggered inference during Analysis to evaluate the question "Should this service use event-driven vs request-response architecture?"
- Acquired external knowledge on event-driven architecture from Microsoft Azure Architecture Center documentation

## External Acquisition

### ACQ-001: Event-driven architecture benefits research

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-27/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-002, src-003

## Candidate Knowledge

### [KDC-001] Event-driven architecture: two-topology model and when-to-use criteria

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-27/acquire/raw-sources/src-002-azure-event-driven.md
- **Verification Status**: passed
- **Original Excerpt**: > "Broker topology: Components broadcast events to the entire system. Other components either act on the event or ignore the event. This topology is useful when the event processing flow is relatively simple. This topology is highly decoupled, which helps provide scalability, responsiveness, and component fault tolerance. Mediator topology: There's an event mediator that manages and controls the flow of events. The event mediator maintains the state and manages error handling and restart capabilities. This topology provides more control, better distributed error handling, and potentially better data consistency. However, it introduces increased coupling between components, and the event mediator can become a bottleneck or a reliability concern."
- **Derived Conclusion**: Event-driven architectures have two primary topologies — broker (decentralized, highly decoupled, scalable but risks data inconsistency) and mediator (centralized flow control, better error handling but introduces coupling and bottleneck risk). The topology choice depends on whether the system prioritizes decoupling and fault tolerance (broker) or coordinated error handling and consistency (mediator).

## Potential Capability Impact
- none — no capability changes identified

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-27-event-driven-topologies.md

## Notes
- none
