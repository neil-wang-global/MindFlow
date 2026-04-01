# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-knowledge-gap-retry-test

## Summary
- Adaptive concurrency control uses a TCP Vegas-inspired gradient algorithm to dynamically adjust microservice concurrency limits based on baseline vs actual latency, eliminating the need for static manual tuning

## From Task Learning
- mind/learning/task-learning/tl-20260401-knowledge-gap-retry-test.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-knowledge-gap-retry-test/acquire/raw-sources/src-001-netflix-concurrency-limits.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-knowledge-gap-retry-test/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Our adaptive concurrency limiter applies the same principle to microservice requests:\n\n1. **Measure baseline latency**: Track the minimum observed latency (analogous to TCP Vegas's BaseRTT) as the latency when the service is unloaded.\n2. **Monitor actual latency**: Continuously measure the actual request latency under current load.\n3. **Detect queuing**: When actual latency significantly exceeds the baseline, infer that requests are queuing — the service is approaching its capacity.\n4. **Adjust the limit**: Use a gradient calculation to increase or decrease the concurrency limit:"

## Candidate Conclusion
- Adaptive concurrency control uses a gradient algorithm inspired by TCP Vegas to dynamically adjust concurrency limits in microservices. The algorithm measures baseline (unloaded) latency, monitors actual latency under load, detects queuing when actual latency exceeds baseline, and adjusts the limit using a gradient calculation (baseline_latency / actual_latency). This eliminates the need for static, manually-tuned concurrency limits.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-knowledge-gap-retry-test-adaptive-concurrency-gradient.md

## Notes
- This candidate resolves the open knowledge gap gap-20260331-retry-target-adaptive-concurrency; the prior attempt failed due to content mismatch (sources discussed static concurrency); this retry used targeted queries naming Netflix's concurrency-limits library
