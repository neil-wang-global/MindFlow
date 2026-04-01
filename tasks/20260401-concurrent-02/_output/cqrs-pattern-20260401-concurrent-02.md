# CQRS Pattern — Knowledge Acquisition Summary

## Task ID
- 20260401-concurrent-02

## Pattern
- CQRS (Command Query Responsibility Segregation)

## ACQ Event
- ACQ-002

## Verified Sources
- src-005: martinfowler.com (Martin Fowler's canonical CQRS article)
- src-006: Microsoft Azure architecture patterns
- src-007: microservices.io (Chris Richardson's pattern catalog)
- src-008: Greg Young's original CQRS introduction

## Key Findings

### Core Concept
CQRS separates read and write operations into different models. Commands handle state changes (create, update, delete); queries handle data retrieval. The split allows each side to be independently optimized.

### Origin and Definition
- Originated from CQS (Command Query Separation) by Bertrand Meyer
- Formalized as CQRS by Greg Young
- Key distinction from CQS: CQRS splits objects into two (command object + query object), not just methods

### Benefits
- Independent scaling of read and write workloads
- Optimized data schemas for each side
- Improved security (separate write authorization)
- Better separation of concerns
- Simpler queries via materialized views

### Challenges
- Increased complexity — should not be applied to entire systems
- Potential for eventual consistency when using separate databases
- Messaging infrastructure may be needed for synchronization

### CQRS + Event Sourcing Integration
- Event store serves as the write model (command side)
- Projections built from events serve as the read model (query side)
- Events synchronize the two models
- New read models can be created at any time by replaying events
- Full audit trail preserved naturally
- Important: CQRS does not require Event Sourcing (they are independent patterns that complement each other)

### Consistency Trade-offs
- Same database: strong consistency possible but limits scalability benefits
- Separate databases: eventual consistency is the norm
- Connects to existing CAP/PACELC knowledge: CQRS read replicas face the same PA/EL vs PC/EC trade-offs

### When to Use
- Highly collaborative domains with many concurrent users
- Complex domains with many different data representations
- Task-based UIs (commands express business intent, not CRUD operations)
- Scenarios requiring audit trails or temporal queries
- Not suitable for simple CRUD domains or simple business rules
