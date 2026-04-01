# Strangler Fig Pattern — Knowledge Acquisition Summary

## Task ID
- 20260401-concurrent-02

## Pattern
- Strangler Fig Pattern for Incremental Legacy Migration

## ACQ Event
- ACQ-003

## Verified Sources
- src-009: martinfowler.com (Martin Fowler's original article)
- src-010: Microsoft Azure architecture patterns
- src-011: AWS prescriptive guidance
- src-012: microservices.io (Chris Richardson's pattern catalog)

## Key Findings

### Core Concept
Named after the strangler fig tree that grows around and eventually replaces its host tree. The pattern incrementally replaces a legacy monolithic application by building new services around it, gradually migrating functionality until the old system can be decommissioned.

### Three-Phase Mechanism
1. **Identify**: Find seams in the legacy application where functionality can be extracted
2. **Transform**: Build new microservices implementing the identified functionality
3. **Redirect**: Use a routing layer to direct traffic from old to new implementation

### Anti-Corruption Layer (ACL)
- Isolates new system's domain model from legacy model
- Translates requests/responses between the two systems
- Types: Facade (simplifies interface), Adapter (converts interfaces), Translation service (bidirectional model translation)
- Term from Eric Evans' Domain-Driven Design
- Temporary infrastructure — removed after migration completes
- Must be kept thin to avoid becoming a second monolith

### Routing Strategies
- URL-based routing: by path or pattern
- Header-based routing: via feature flags in request headers
- Percentage-based routing: gradual traffic shift (canary deployment)
- Implementation options: API gateway, reverse proxy, load balancer

### Migration Phases
1. Assess and plan (map domain boundaries, identify least-coupled components)
2. Establish facade (deploy routing layer, route all to monolith initially)
3. Migrate incrementally (build service, update routing, verify, repeat)
4. Decommission (remove monolith routing, simplify facade)

### Benefits
- Lower risk than big-bang rewrites
- Incremental delivery of business value
- Old and new coexist during transition
- Rollback possible at any point by redirecting traffic
- Team learns and adjusts as migration progresses

### Considerations
- Maintaining two systems adds complexity
- Data synchronization between old and new required during transition
- Migration can stall without organizational commitment — requires deadlines
- Additional latency from routing layer
- Start with least-coupled, least-critical components
