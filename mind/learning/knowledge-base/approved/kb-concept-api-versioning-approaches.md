# Knowledge Base Entry

## Type
- concept

## Summary
- URI path versioning is the simplest approach to implement but has two drawbacks: it can become unwieldy as the API matures through many versions, and it violates the REST principle that a URI should uniquely identify a resource. Despite these drawbacks, its simplicity and discoverability make it the most commonly adopted approach.

## Source Lineage
- Task ID: 20260401-concurrent-11
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-11.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-11-api-versioning-approaches.md
- Review File: mind/learning/reviews/review-20260401-concurrent-11-api-versioning-approaches.md
- Original Source Anchor: tasks/20260401-concurrent-11/acquire/raw-sources/src-001-ms-api-design-versioning.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design

## Key Evidence
> "This versioning mechanism is simple but depends on the server to route the request to the appropriate endpoint. However, it can become unwieldy as the web API matures through several iterations and the server has to support many different versions. From a purist's point of view, in all cases, the client applications fetch the same data (customer 3), so the URI shouldn't differ according to the version. This schema also complicates the implementation of HATEOAS because all links need to include the version number in their URIs."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-11-api-versioning-approaches.md

## Applicability
- Applies to: REST API design decisions for microservice architectures, public API versioning strategy selection, API gateway versioning scheme configuration
- Does not apply to: internal service-to-service communication protocols, database schema versioning, library/SDK semantic versioning

## Notes
- Four versioning approaches exist (URI path, query string, header, media type); this entry focuses on URI path versioning trade-offs as the most commonly adopted approach
- Source also covers caching implications: URI and query string versioning are cache-friendly; header and media type versioning require more cache logic
