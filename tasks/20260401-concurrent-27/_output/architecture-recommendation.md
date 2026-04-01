# Architecture Recommendation: Event-Driven vs Request-Response

## Task ID
- 20260401-concurrent-27

## Executive Summary

A hybrid architecture is recommended: use event-driven patterns for inter-service state change propagation and workload distribution; use request-response for synchronous queries and operations requiring immediate consistency. The choice is per-interaction-pattern, not per-service.

## Trade-Off Comparison

| Factor | Request-Response | Event-Driven |
|--------|-----------------|--------------|
| **Coupling** | Tight — services directly depend on each other | Loose — producers/consumers decoupled via broker |
| **Consistency** | Strong — immediate response confirms state | Eventual — consumers process at own pace |
| **Latency** | Predictable — synchronous round-trip | Variable — depends on broker and consumer throughput |
| **Scalability** | Limited — synchronous calls create bottlenecks | High — independent scaling of producers/consumers |
| **Resilience** | Cascading failure risk without circuit breakers | Resilient — temporal decoupling buffers failures |
| **Debugging** | Easier — synchronous call chains, stack traces | Harder — no shared call context, requires correlation IDs |
| **Operational Complexity** | Lower — no broker infrastructure needed | Higher — requires message broker, schema registry, DLQ monitoring |
| **Error Handling** | Direct — caller sees errors immediately | Indirect — dead-letter queues, compensating transactions |
| **Extensibility** | Requires API changes to add consumers | New consumers subscribe without modifying producers |

## Architectural Patterns Evaluated

### Event-Driven Topologies (from Azure Architecture Center)

1. **Broker topology**: Components broadcast events; highly decoupled, scalable, fault-tolerant. No central coordination. Risk: data inconsistency in distributed transactions without built-in restart/replay.

2. **Mediator topology**: Event mediator manages flow, maintains state, handles errors. More control and better consistency. Risk: mediator becomes bottleneck or single point of failure.

### Event-Driven Delivery Models

1. **Publish-subscribe**: Infrastructure tracks subscriptions, delivers to all subscribers. Events not persisted — new subscribers miss past events.

2. **Event streaming**: Events written to durable, ordered log. Clients read from any position. Supports replay, recovery, and late-arriving consumers.

### Choreography vs Orchestration (from Azure Architecture Center)

- **Choreography**: Services coordinate via events without central orchestrator. Minimizes coupling, supports independent deployment. Challenges: complex failure handling, difficulty with sequential workflows, distributed tracing.
- **Orchestration**: Central coordinator manages workflow. Simpler error handling and transaction management. Risk: single point of failure, bottleneck under load.

## Decision Criteria

Use the following criteria to determine which pattern applies to each interaction:

### Use Request-Response When:
- The caller requires an immediate response (user-facing queries, synchronous validation)
- Strong consistency is required across the interaction
- The workflow is simple CRUD with no downstream side effects
- The team lacks experience with distributed async systems
- Latency and throughput requirements are met by synchronous calls

### Use Event-Driven When:
- Multiple downstream services must react to the same state change
- The interaction can tolerate eventual consistency
- Real-time processing with minimum time lag is needed
- High volume/high velocity data ingestion is required
- Independent scalability of producers and consumers is a goal
- Temporal decoupling is needed for resilience

### Use Hybrid When:
- The service has both query interfaces and inter-service integration needs
- Different interactions within the same service have different consistency requirements
- The system needs the simplicity of request-response for user-facing APIs and the resilience of events for backend processing

## Recommendations

1. **Default to request-response for user-facing synchronous APIs** — apply circuit breakers, timeouts, and retries per Soul constraints (explicit failure handling, resilience patterns)

2. **Use event-driven for inter-service state change notifications** — ensure dead-letter queue monitoring to prevent silent degradation (Soul constraint: explicit failure handling over silent degradation)

3. **Adopt the broker topology** unless sequential workflow coordination is required — per Soul constraint favoring operational simplicity

4. **Mandate correlation IDs** in all event payloads from day one — observability across decoupled components is substantially harder to retrofit

5. **Design consumers for idempotency** — at-least-once delivery is the practical reality in most event-driven systems

6. **Establish event schema versioning strategy early** — producers and consumers deploy independently; breaking schema changes cascade failure

## Confidence Assessment

- **Medium** — the trade-off analysis is well-grounded in verified sources (Microsoft Azure Architecture Center documentation), but the specific recommendation is generic. Final choice depends on: concrete service traffic patterns, team operational maturity, existing infrastructure, and specific consistency requirements.

## Sources

- Inference output: tasks/20260401-concurrent-27/cache/inference-event-vs-request.md (accepted-into-analysis)
- Verified source src-002: https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven (Azure Architecture Center — Event-Driven Architecture Style)
- Verified source src-003: https://learn.microsoft.com/en-us/azure/architecture/patterns/choreography (Azure Architecture Center — Choreography Pattern)
- Soul constraints: mind/soul/core.md (resilience over raw performance, explicit failure handling, operational simplicity, data-driven decisions)
