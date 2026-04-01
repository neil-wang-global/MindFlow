# Task Learning Record

## Task ID
- 20260401-concurrent-11

## Task Summary
- Created an API versioning strategy document evaluating four approaches: URI path versioning, header versioning, media type versioning (content negotiation), and query string versioning
- Acquired knowledge from two verified Microsoft technical documentation sources via ACQ-001
- Produced _output/api-versioning-strategy.md recommending URI path versioning based on operational simplicity and contract-first API design principles

## External Acquisition

### ACQ-001: API versioning approaches knowledge gap

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-11/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] REST API versioning: four approaches with trade-offs

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-11/acquire/raw-sources/src-001-ms-api-design-versioning.md
- **Verification Status**: passed
- **Original Excerpt**: > "This versioning mechanism is simple but depends on the server to route the request to the appropriate endpoint. However, it can become unwieldy as the web API matures through several iterations and the server has to support many different versions. From a purist's point of view, in all cases, the client applications fetch the same data (customer 3), so the URI shouldn't differ according to the version. This schema also complicates the implementation of HATEOAS because all links need to include the version number in their URIs."
- **Derived Conclusion**: URI path versioning is the simplest approach to implement but has two drawbacks: it can become unwieldy as the API matures through many versions, and it violates the REST principle that a URI should uniquely identify a resource. Despite these drawbacks, its simplicity and discoverability make it the most commonly adopted approach.

### [KDC-002] Media type versioning leverages HTTP content negotiation for HATEOAS

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-11/acquire/raw-sources/src-001-ms-api-design-versioning.md
- **Verification Status**: passed
- **Original Excerpt**: > "However, it's possible to define custom media types that include information that lets the client application indicate which version of a resource it expects."
- **Derived Conclusion**: Media type versioning (content negotiation) uses custom media types in the HTTP Accept header to carry version information. This is considered the most RESTful approach because it leverages the existing HTTP content negotiation mechanism and is well-suited for HATEOAS, but it adds implementation complexity on both client and server sides.

### [KDC-003] API versioning scheme flexibility in production API management

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-11/acquire/raw-sources/src-002-ms-api-mgmt-versions.md
- **Verification Status**: passed
- **Original Excerpt**: > "Different API developers have different requirements for versioning. Azure API Management doesn't prescribe a single approach to versioning, but instead provides several options."
- **Derived Conclusion**: Production API management platforms (such as Azure API Management) support multiple versioning schemes (path-based, header-based, query string-based) simultaneously, indicating that no single approach is universally superior. The choice of versioning scheme depends on specific requirements including discoverability, cacheability, and operational simplicity.

## Potential Capability Impact
- none — no existing capability definitions to update

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-11-api-versioning-approaches.md
- KDC-002: not promoted: subsumed by KDC-001 (media type versioning detail is part of the broader versioning approaches concept)
- KDC-003: not promoted: supplementary evidence already covered by KDC-001 (scheme flexibility is a natural consequence of the trade-off analysis)

## Notes
- none
