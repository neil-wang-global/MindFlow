# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-07

## Summary
- Health endpoint monitoring pattern recommends tiered endpoint exposure with per-dependency granularity, distinguishing critical from non-critical dependencies for health status determination

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-07.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-07/acquire/raw-sources/src-002-azure-health-endpoint-monitoring.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-07/acquire/verification-report.md §ACQ-001
  - Verification Status: passed (confirmed in Passed Sources for ACQ-001)

## Original Excerpt
> "Determine the number of endpoints to expose for an application. One approach is to expose at least one endpoint for the core services that the application uses and another for lower-priority services. With this approach, you can assign different levels of importance to each monitoring result. Also consider exposing extra endpoints. You can expose one for each core service to increase monitoring granularity. For example, a health verification check might check the database, the storage, and an external geocoding service that an application uses. Each might require a different level of uptime and response time. The geocoding service or some other background task might be unavailable for a few minutes. But the application might still be healthy."

## Candidate Conclusion
- The health endpoint monitoring pattern recommends tiered endpoint exposure: separate endpoints for core vs lower-priority services, with per-dependency granularity for monitoring. Critical insight: non-critical dependencies being unavailable does not necessarily mean the application is unhealthy — the health check design should distinguish between critical dependencies (whose failure means the service cannot process requests) and non-critical dependencies (whose failure degrades but does not eliminate service capability).

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-07-health-endpoint-monitoring.md

## Notes
- Source: Microsoft Azure Architecture Center (learn.microsoft.com)
