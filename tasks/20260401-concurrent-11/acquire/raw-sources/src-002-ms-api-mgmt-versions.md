# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001 — API versioning approaches knowledge gap

## Source URL
- https://learn.microsoft.com/en-us/azure/api-management/api-management-versions

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Microsoft Azure API Management official documentation — production-grade API management service documentation

## Fetch Status
- success

## Fetch Completeness
- complete
- Full page content was fetched

## Original Content

# Versions in Azure API Management

APPLIES TO: All API Management tiers

Versions enable you to present groups of related APIs to your developers. You can use versions to handle breaking changes in your API safely. Clients can choose to use your new API version when they're ready, while existing clients continue to use an older version. Versions are differentiated via a version identifier (which is any string value you choose), and a versioning scheme allows clients to identify which version of an API they want to use.

For most purposes, each API version can be considered its own independent API. Two different API versions might have different sets of operations and different policies.

With versions you can:

- Publish multiple versions of your API at the same time.
- Use a path, query string, or header to differentiate among versions.
- Use any string value you want to identify your version. It could be a number, a date, or a name.
- Show your API versions grouped together on the developer portal.
- Create a new version of an existing (non-versioned) API without affecting existing clients.

## Versioning schemes

Different API developers have different requirements for versioning. Azure API Management doesn't prescribe a single approach to versioning, but instead provides several options.

### Path-based versioning

When the path versioning scheme is used, the version identifier needs to be included in the URL path for any API requests.

For example, `https://apis.contoso.com/products/v1` and `https://apis.contoso.com/products/v2` could refer to the same `products` API but to versions `v1` and `v2`.

The format of an API request URL when you use path-based versioning is `https://{yourDomain}/{apiName}/{versionIdentifier}/{operationId}`.

### Header-based versioning

When the header versioning scheme is used, the version identifier needs to be included in an HTTP request header for any API requests. You can specify the name of the HTTP request header.

For example, you might create a custom header named `Api-Version`, and clients could specify `v1` or `v2` in the value of this header.

### Query string-based versioning

When the query string versioning scheme is used, the version identifier needs to be included in a query string parameter for any API requests. You can specify the name of the query string parameter.

The format of an API request URL when you use query string-based versioning is `https://{yourDomain}/{apiName}/{operationId}?{queryStringParameterName}={versionIdentifier}`.

For example, `https://apis.contoso.com/products?api-version=v1` and `https://apis.contoso.com/products?api-version=v2` could refer to the same `products` API but to versions `v1` and `v2`.

Note: Query parameters aren't allowed in the `servers` property of an OpenAPI specification. If you export an OpenAPI specification from an API version, a query string won't appear in the server URL.

## Original versions

If you add a version to a non-versioned API, an `Original` version will be automatically created and will respond on the default URL, without a version identifier specified. The `Original` version ensures that any existing callers aren't affected by the process of adding a version. If you create a new API with versions enabled at the start, an `Original` version isn't created.

## How versions are represented

API Management maintains a resource called a version set, which represents a set of versions for a single logical API. A version set contains the display name of the versioned API and the versioning scheme that's used to direct requests to specified versions.

Each version of an API is maintained as its own API resource and is associated with a version set. A version set might contain APIs with different operations or policies. You might make significant changes between versions in a set.

## Versions and revisions

Versions and revisions are distinct features. Each version can have multiple revisions, just like a non-versioned API. You can use revisions without using versions, or the other way around. Typically, versions are used to separate API versions that have breaking changes, and revisions can be used for minor and non-breaking changes to an API.

If you find that your revision has breaking changes, or if you want to formally turn your revision into a beta/test version, you can create a version from a revision.
