# Knowledge Base Entry

## Type
- concept

## Summary
- The health endpoint monitoring pattern recommends tiered endpoint exposure: separate endpoints for core vs lower-priority services, with per-dependency granularity for monitoring. Non-critical dependencies being unavailable does not necessarily mean the application is unhealthy — the health check design should distinguish between critical dependencies (whose failure means the service cannot process requests) and non-critical dependencies (whose failure degrades but does not eliminate service capability).

## Source Lineage
- Task ID: 20260401-concurrent-07
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-07.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-07-health-endpoint-monitoring.md
- Review File: mind/learning/reviews/review-20260401-concurrent-07-health-endpoint-monitoring.md
- Original Source Anchor: tasks/20260401-concurrent-07/acquire/raw-sources/src-002-azure-health-endpoint-monitoring.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring

## Key Evidence
> "Determine the number of endpoints to expose for an application. One approach is to expose at least one endpoint for the core services that the application uses and another for lower-priority services. With this approach, you can assign different levels of importance to each monitoring result. Also consider exposing extra endpoints. You can expose one for each core service to increase monitoring granularity. For example, a health verification check might check the database, the storage, and an external geocoding service that an application uses. Each might require a different level of uptime and response time. The geocoding service or some other background task might be unavailable for a few minutes. But the application might still be healthy."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-07-health-endpoint-monitoring.md

## Applicability
- Applies to: microservice architectures requiring health monitoring of service dependencies; cloud-hosted applications with multiple backend dependencies; systems using load balancers or service meshes that route based on health status
- Does not apply to: single-dependency applications where all-or-nothing health is sufficient; systems where all dependencies are equally critical and no degraded mode exists; internal tooling with no traffic routing based on health state

## Notes
- Grounded in Microsoft Azure Architecture Center documentation; independently verified via ACQ-001
- The critical vs non-critical dependency classification enables a three-tier health model (UP/DEGRADED/DOWN) rather than binary health
