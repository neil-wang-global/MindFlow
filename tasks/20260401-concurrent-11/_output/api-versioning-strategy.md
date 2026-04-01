# API Versioning Strategy

## Task ID
- 20260401-concurrent-11

## Purpose
This document recommends an API versioning strategy for microservice architectures, evaluated against three approaches: URL/URI versioning, header versioning, and content negotiation (media type versioning). The recommendation is grounded in knowledge acquired from verified primary sources and aligned with core design constraints: contract-first API design, operational simplicity, and explicit failure handling.

## Versioning Approaches Evaluated

### 1. URI Path Versioning

**Mechanism**: Embed the version number directly in the URL path.

**Example**:
```
GET https://api.example.com/v2/customers/3
```

**Strengths**:
- Simple to implement and understand
- Version is explicitly visible in every request
- Cache-friendly (same URI/version combination always refers to same data)
- Easy to route at the API gateway or load balancer level
- Easy to test (URLs can be used directly in browsers and curl)

**Weaknesses**:
- Violates the REST principle that a URI should uniquely identify a resource (the same resource gets different URIs per version)
- Complicates HATEOAS because all links must include version numbers
- Can become unwieldy as the API matures through many iterations
- Requires clients to update all URIs when migrating to a new version

**Source**: Microsoft Azure Architecture Center (src-001), Microsoft Azure API Management (src-002)

### 2. Header Versioning

**Mechanism**: Specify the version in a custom HTTP request header.

**Example**:
```
GET https://api.example.com/customers/3
Api-Version: v2
```

**Strengths**:
- Keeps URLs clean and resource-focused
- Separates versioning concern from resource identification
- Can default to a version (e.g., version 1) when the header is omitted

**Weaknesses**:
- Less discoverable -- version is hidden in headers, not visible in the URL
- Harder to test casually (cannot paste a URL in a browser)
- Requires more server-side logic to parse and route based on headers
- Proxies and intermediaries may strip or ignore custom headers
- In large-scale environments, header-based routing can cause significant cache duplication

**Source**: Microsoft Azure Architecture Center (src-001), Microsoft Azure API Management (src-002)

### 3. Media Type Versioning (Content Negotiation)

**Mechanism**: Use the HTTP Accept header with a custom media type that includes version information.

**Example**:
```
GET https://api.example.com/customers/3
Accept: application/vnd.example.v1+json
```

Response:
```
HTTP/1.1 200 OK
Content-Type: application/vnd.example.v1+json; charset=utf-8
```

**Strengths**:
- Most RESTful approach -- leverages existing HTTP content negotiation mechanism
- Well-suited for HATEOAS (MIME type of related data can be included in resource links)
- Allows fine-grained, per-resource versioning
- Keeps URIs clean

**Weaknesses**:
- Most complex to implement
- Hardest to test and debug
- Requires clients to understand custom media types
- Caching is more difficult (content varies by Accept header)
- If the Accept header specifies unknown media types, the server must return 406 (Not Acceptable) or fall back to a default

**Source**: Microsoft Azure Architecture Center (src-001)

## Comparison Matrix

| Criterion | URI Path | Header | Media Type |
|-----------|----------|--------|------------|
| Simplicity | High | Medium | Low |
| RESTfulness | Low | Medium | High |
| Discoverability | High | Low | Low |
| Cacheability | High | Low | Low |
| Testability | High | Low | Low |
| HATEOAS compatibility | Low (version in all links) | Low (header in all links) | High (MIME type in links) |
| Gateway routing | Simple | Moderate | Complex |

## Recommendation

**Primary strategy: URI path versioning** with the following design rules:

1. **Version format**: Use major version only in the path (e.g., `/v1/`, `/v2/`). Minor and patch changes that do not break backward compatibility should not increment the path version.

2. **Version placement**: Place the version identifier immediately after the API base URL and before the resource path: `https://api.example.com/v{N}/resource`.

3. **Backward compatibility**: Maintain at least one previous major version during transition periods. Additive changes (new fields, new endpoints) do not require a new version.

4. **Deprecation policy**: Announce deprecation at least 6 months before removing a version. Use a `Sunset` header or a deprecation notice in API responses for deprecated versions.

5. **Default version**: When no version is specified, redirect to the latest stable version or return 404 -- do not silently default to an old version.

## Rationale

URI path versioning is recommended because it aligns with the core design constraints:

- **Contract-first API design**: The version is part of the explicit API contract, visible in every URL. Consumers know exactly which version they are calling.
- **Operational simplicity**: No special header parsing, no custom media type handling. Standard HTTP routing and caching work without modification. API gateways can route by path prefix.
- **Explicit failure handling**: Version mismatches are immediately visible in the URL. A client calling `/v1/` when only `/v2/` exists gets a clear 404, not a silent degradation.

Media type versioning, while the most architecturally pure REST approach, adds implementation complexity that is not justified for most microservice architectures where operational simplicity is valued. Header versioning occupies a middle ground but sacrifices discoverability without sufficient compensating benefit.

This aligns with industry practice: Google, Twitter, Facebook, Stripe, and Azure API Management all support or recommend path-based versioning as a primary approach.

## Sources
- src-001: Microsoft Azure Architecture Center, "Web API Design Best Practices" -- https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design
- src-002: Microsoft Azure API Management, "Versions in Azure API Management" -- https://learn.microsoft.com/en-us/azure/api-management/api-management-versions
