# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-24

## Summary
- In client-side service discovery, the calling service queries the registry and selects an instance; this gives more control but couples clients to the registry and requires per-language discovery logic

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-24.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-24/acquire/raw-sources/src-001-service-discovery-patterns.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-24/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "When making a request to a service, the client obtains the location of a service instance by querying a Service Registry, which knows the locations of all service instances."

## Candidate Conclusion
- In client-side service discovery, the calling service bears responsibility for querying the service registry and selecting an instance via load balancing. This gives clients more control and eliminates a network hop, but couples every client to the registry and requires discovery logic in each language/framework.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-24-client-server-discovery.md

## Notes
- none
