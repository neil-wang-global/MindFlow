# Knowledge Base Entry

## Type
- concept

## Summary
- Adaptive concurrency control uses a gradient algorithm inspired by TCP Vegas to dynamically adjust concurrency limits in microservices. The algorithm measures baseline (unloaded) latency, monitors actual latency under load, detects queuing when actual latency exceeds baseline, and adjusts the limit using a gradient calculation (baseline_latency / actual_latency). This eliminates the need for static, manually-tuned concurrency limits.

## Source Lineage
- Task ID: 20260401-knowledge-gap-retry-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-knowledge-gap-retry-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-knowledge-gap-retry-test-adaptive-concurrency-gradient.md
- Review File: mind/learning/reviews/review-20260401-knowledge-gap-retry-test-adaptive-concurrency-gradient.md
- Original Source Anchor: tasks/20260401-knowledge-gap-retry-test/acquire/raw-sources/src-001-netflix-concurrency-limits.md
- Original Source URL: https://netflixtechblog.medium.com/performance-under-load-3e6fa9a60581

## Key Evidence
> "Our adaptive concurrency limiter applies the same principle to microservice requests:\n\n1. **Measure baseline latency**: Track the minimum observed latency (analogous to TCP Vegas's BaseRTT) as the latency when the service is unloaded.\n2. **Monitor actual latency**: Continuously measure the actual request latency under current load.\n3. **Detect queuing**: When actual latency significantly exceeds the baseline, infer that requests are queuing — the service is approaching its capacity.\n4. **Adjust the limit**: Use a gradient calculation to increase or decrease the concurrency limit:"

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-knowledge-gap-retry-test-adaptive-concurrency-gradient.md

## Applicability
- Applies to: microservice architectures where services communicate over the network and need dynamic load management; particularly valuable when services have variable capacity due to deployment changes, infrastructure scaling, or varying downstream performance
- Does not apply to: systems with fixed, well-characterized throughput where static limits are sufficient; single-process applications without network-based service calls; environments where latency measurement overhead is unacceptable

## Notes
- Based on Netflix's open-source concurrency-limits library; the algorithm is analogous to TCP Vegas congestion avoidance applied to microservice request concurrency
