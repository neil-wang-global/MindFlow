# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-24

## Summary
- Consul provides native DNS-based service discovery where health check results are integrated directly into DNS responses, automatically excluding unhealthy nodes

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-24.md
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-24/acquire/raw-sources/src-002-consul-dns-discovery.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-24/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "By default, DNS queries only return nodes that are passing all health checks. This behavior can be changed:"

## Candidate Conclusion
- Consul provides native DNS-based service discovery where health check results are integrated directly into DNS responses. Unhealthy nodes are automatically excluded from query results, which means DNS-based discovery in Consul inherently provides health-aware routing without requiring additional client-side logic.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-24-consul-dns-discovery.md

## Notes
- none
