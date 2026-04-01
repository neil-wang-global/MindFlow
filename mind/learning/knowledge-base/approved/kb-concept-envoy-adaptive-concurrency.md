# Knowledge Base Entry

## Type
- concept

## Summary
- The Envoy proxy implements an adaptive concurrency filter based on the gradient algorithm from Netflix's concurrency-limits library. This production-grade implementation dynamically adjusts outstanding request limits based on sampled latencies, providing an alternative to static max_requests circuit breakers in service mesh environments.

## Source Lineage
- Task ID: 20260401-knowledge-gap-retry-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-knowledge-gap-retry-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-knowledge-gap-retry-test-envoy-adaptive-concurrency.md
- Review File: mind/learning/reviews/review-20260401-knowledge-gap-retry-test-envoy-adaptive-concurrency.md
- Original Source Anchor: tasks/20260401-knowledge-gap-retry-test/acquire/raw-sources/src-002-envoy-adaptive-concurrency.md
- Original Source URL: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/adaptive_concurrency_filter

## Key Evidence
> "The adaptive concurrency filter dynamically adjusts the allowed number of outstanding requests to a service based on sampled latencies from prior requests. The filter is an implementation of the gradient-based concurrency limiting algorithm, similar to the approach described by Netflix's concurrency-limits library."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-knowledge-gap-retry-test-envoy-adaptive-concurrency.md

## Applicability
- Applies to: Envoy-based service mesh deployments where adaptive load management is needed; microservice architectures using sidecar proxies for traffic management; systems that want automated concurrency limiting without manual per-service configuration
- Does not apply to: environments not using Envoy or compatible L7 proxies; services where the minRTT measurement window's temporary throughput reduction is unacceptable; simple deployments where static circuit breaker thresholds are sufficient

## Notes
- Envoy's implementation is a production-validated instantiation of the gradient algorithm; it references Netflix's concurrency-limits library as the algorithmic inspiration
