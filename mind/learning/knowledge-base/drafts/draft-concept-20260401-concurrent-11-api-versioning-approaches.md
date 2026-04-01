# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-11

## Summary
- URI path versioning is simplest but can become unwieldy with many versions and violates the REST principle that a URI should uniquely identify a resource; despite these drawbacks, its simplicity and discoverability make it the most commonly adopted approach

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-11.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-11/acquire/raw-sources/src-001-ms-api-design-versioning.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-11/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "This versioning mechanism is simple but depends on the server to route the request to the appropriate endpoint. However, it can become unwieldy as the web API matures through several iterations and the server has to support many different versions. From a purist's point of view, in all cases, the client applications fetch the same data (customer 3), so the URI shouldn't differ according to the version. This schema also complicates the implementation of HATEOAS because all links need to include the version number in their URIs."

## Candidate Conclusion
- URI path versioning is the simplest approach to implement but has two drawbacks: it can become unwieldy as the API matures through many versions, and it violates the REST principle that a URI should uniquely identify a resource. Despite these drawbacks, its simplicity and discoverability make it the most commonly adopted approach.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-11-api-versioning-approaches.md

## Notes
- none
