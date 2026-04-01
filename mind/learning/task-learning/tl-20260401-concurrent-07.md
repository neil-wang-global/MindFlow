# Task Learning Record

## Task ID
- 20260401-concurrent-07

## Task Summary
- Built a health check endpoint design specification for a microservice, covering liveness, readiness, and startup probe endpoints with distinct shallow/deep check strategies, dependency health aggregation, and circuit breaker integration
- Acquired external knowledge about health check patterns via ACQ-001 from Kubernetes documentation and Microsoft Azure Architecture Center
- Produced deliverable: tasks/20260401-concurrent-07/_output/health-check-endpoint.md

## External Acquisition

### ACQ-001: Health check endpoint patterns

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-07/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] Kubernetes liveness vs readiness vs startup probes

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-07/acquire/raw-sources/src-001-kubernetes-probes.md
- **Verification Status**: passed
- **Original Excerpt**: > "Liveness probe: tells kubelet whether to restart a container. Use it to detect and recover from unrecoverable app failures (deadlocks, hung main thread). Readiness probe: tells kubelet (and Services) whether a container is ready to receive traffic. When not ready the Pod is removed from service endpoints. Startup probe: tells kubelet whether the application in the container has finished starting. If a startup probe is configured, the kubelet disables liveness and readiness probes until the startup probe succeeds — useful for slow-starting apps so they aren't killed early."
- **Derived Conclusion**: Kubernetes defines three distinct probe types with different failure semantics: liveness probes trigger container restart on failure (for deadlock/hang recovery), readiness probes remove pods from service endpoints without restart (for traffic routing control), and startup probes gate liveness/readiness activation during initialization (preventing premature kills of slow-starting containers). This three-probe model maps directly to shallow checks (liveness), deep checks (readiness), and initialization checks (startup).

### [KDC-002] Health endpoint monitoring pattern with dependency health checks

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-07/acquire/raw-sources/src-002-azure-health-endpoint-monitoring.md
- **Verification Status**: passed
- **Original Excerpt**: > "Determine the number of endpoints to expose for an application. One approach is to expose at least one endpoint for the core services that the application uses and another for lower-priority services. With this approach, you can assign different levels of importance to each monitoring result. Also consider exposing extra endpoints. You can expose one for each core service to increase monitoring granularity. For example, a health verification check might check the database, the storage, and an external geocoding service that an application uses. Each might require a different level of uptime and response time. The geocoding service or some other background task might be unavailable for a few minutes. But the application might still be healthy."
- **Derived Conclusion**: The health endpoint monitoring pattern recommends tiered endpoint exposure: separate endpoints for core vs lower-priority services, with per-dependency granularity for monitoring. Critical insight: non-critical dependencies being unavailable does not necessarily mean the application is unhealthy — the health check design should distinguish between critical dependencies (whose failure means the service cannot process requests) and non-critical dependencies (whose failure degrades but does not eliminate service capability).

## Potential Capability Impact
- Consider creating cap-health-check-design.md if health check endpoint design becomes a recurring task type

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-07-health-probe-types.md
- KDC-002: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-07-health-endpoint-monitoring.md

## Notes
- none
