# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001 — API versioning approaches knowledge gap

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Microsoft Azure Architecture Center — official Microsoft technical guidance maintained by Microsoft's architecture team

## Fetch Status
- success

## Fetch Completeness
- partial
- Only the versioning section (## Implement versioning) was extracted from the larger API design best practices document; the full document covers broader API design topics beyond versioning

## Original Content

## Implement versioning

A web API doesn't remain static. As business requirements change, new collections of resources are added. As new resources are added, the relationships between resources might change, and the structure of the data in resources might be amended. Updating a web API to handle new or different requirements is a straightforward process, but you must consider the effects that such changes have on client applications that consume the web API. The developer who designs and implements a web API has full control over that API, but they don't have the same degree of control over client applications built by partner organizations. It's important to continue to support existing client applications while allowing new client applications to use new features and resources.

A web API that implements versioning can indicate the features and resources that it exposes, and a client application can submit requests that are directed to a specific version of a feature or resource. The following sections describe several different approaches, each of which has its own benefits and trade-offs.

### No versioning

This approach is the simplest and can work for some internal APIs. Significant changes can be represented as new resources or new links. Adding content to existing resources might not present a breaking change because client applications that aren't expecting to see this content ignore it.

For example, a request to the URI `https://api.contoso.com/customers/3` should return the details of a single customer that contains the `id`, `name`, and `address` fields that the client application expects:

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"id":3,"name":"Fabrikam, Inc.","address":"1 Microsoft Way Redmond WA 98053"}
```

If the `DateCreated` field is added to the schema of the customer resource, then the response looks like:

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"id":3,"name":"Fabrikam, Inc.","dateCreated":"2025-03-22T12:11:38.0376089Z","address":"1 Microsoft Way Redmond WA 98053"}
```

Existing client applications might continue to function correctly if they can ignore unrecognized fields. Meanwhile, new client applications can be designed to handle this new field. However, more drastic modifications to the schema of resources, including field removals or renaming, could occur. Or the relationships between resources might change. These updates can constitute breaking changes that prevent existing client applications from functioning correctly. In these scenarios, consider one of the following approaches:

- URI versioning
- Query string versioning
- Header versioning
- Media type versioning

### URI versioning

Each time you modify the web API or change the schema of resources, you add a version number to the URI for each resource. The previously existing URIs should continue to operate normally by returning resources that conform to their original schema.

For example, the `address` field in the previous example is restructured into subfields that contain each constituent part of the address, such as `streetAddress`, `city`, `state`, and `zipCode`. This version of the resource can be exposed through a URI that contains a version number, such as `https://api.contoso.com/v2/customers/3`:

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"id":3,"name":"Fabrikam, Inc.","dateCreated":"2025-03-22T12:11:38.0376089Z","address":{"streetAddress":"1 Microsoft Way","city":"Redmond","state":"WA","zipCode":98053}}
```

This versioning mechanism is simple but depends on the server to route the request to the appropriate endpoint. However, it can become unwieldy as the web API matures through several iterations and the server has to support many different versions. From a purist's point of view, in all cases, the client applications fetch the same data (customer 3), so the URI shouldn't differ according to the version. This schema also complicates the implementation of HATEOAS because all links need to include the version number in their URIs.

### Query string versioning

Instead of providing multiple URIs, you can specify the version of the resource by using a parameter within the query string appended to the HTTP request, such as `https://api.contoso.com/customers/3?version=2`. The version parameter should default to a meaningful value, like 1, if older client applications omit it.

This approach has the semantic advantage that the same resource is always retrieved from the same URI. However, this method depends on the code that handles the request to parse the query string and send back the appropriate HTTP response. This approach also complicates the implementation of HATEOAS in the same way as the URI versioning mechanism.

Note: Some older web browsers and web proxies don't cache responses for requests that include a query string in the URI. Uncached responses can degrade performance for web applications that use a web API and run from within an older web browser.

### Header versioning

Instead of appending the version number as a query string parameter, you can implement a custom header that indicates the version of the resource. This approach requires that the client application adds the appropriate header to any requests. However, the code that handles the client request can use a default value, like version 1, if the version header is omitted.

The following examples use a custom header named *Custom-Header*. The value of this header indicates the version of web API.

Version 1:

```http
GET https://api.contoso.com/customers/3
Custom-Header: api-version=1
```

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"id":3,"name":"Fabrikam, Inc.","address":"1 Microsoft Way Redmond WA 98053"}
```

Version 2:

```http
GET https://api.contoso.com/customers/3
Custom-Header: api-version=2
```

```http
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"id":3,"name":"Fabrikam, Inc.","dateCreated":"2025-03-22T12:11:38.0376089Z","address":{"streetAddress":"1 Microsoft Way","city":"Redmond","state":"WA","zipCode":98053}}
```

Similar to URI versioning and query string versioning, you must include the appropriate custom header in any links to implement HATEOAS.

### Media type versioning

When a client application sends an HTTP GET request to a web server, it should use an Accept header to specify the format of the content that it can handle. Usually, the purpose of the Accept header is to allow the client application to specify whether the body of the response should be XML, JSON, or some other common format that the client can parse. However, it's possible to define custom media types that include information that lets the client application indicate which version of a resource it expects.

The following example shows a request that specifies an Accept header with the value `application/vnd.contoso.v1+json`. The `vnd.contoso.v1` element indicates to the web server that it should return version 1 of the resource. The `json` element specifies that the format of the response body should be JSON:

```http
GET https://api.contoso.com/customers/3
Accept: application/vnd.contoso.v1+json
```

The code that handles the request is responsible for processing the Accept header and honoring it as much as possible. The client application can specify multiple formats in the Accept header, which allows the web server to choose the most appropriate format for the response body. The web server confirms the format of the data in the response body by using the Content-Type header:

```http
HTTP/1.1 200 OK
Content-Type: application/vnd.contoso.v1+json; charset=utf-8

{"id":3,"name":"Fabrikam, Inc.","address":"1 Microsoft Way Redmond WA 98053"}
```

If the Accept header doesn't specify any known media types, the web server can generate an HTTP 406 (Not Acceptable) response message or return a message with a default media type.

This versioning mechanism is straightforward and well-suited for HATEOAS, which can include the MIME type of related data in resource links.

Note: When you select a versioning strategy, implications, especially in relation to web server caching. The URI versioning and query string versioning schemas are cache-friendly because the same URI or query string combination refers to the same data each time.

The header versioning and media type versioning mechanisms typically require more logic to examine the values in the custom header or the Accept header. In a large-scale environment, many clients using different versions of a web API can result in a significant amount of duplicated data in a server-side cache. This problem can become acute if a client application communicates with a web server through a proxy that implements caching and only forwards a request to the web server if it doesn't currently contain a copy of the requested data in its cache.
