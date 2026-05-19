# HTTP Status Codes Reference Card for Microservice Architectures

## Quick-Reference: Retry Decision Table

| Code | Retry? | Notes |
|------|--------|-------|
| 400  | No     | Client error — fix the request |
| 401  | No*    | Refresh auth token, then retry once |
| 403  | No     | Authorization failure — will not resolve with retry |
| 404  | No     | Resource does not exist |
| 408  | Yes    | Request timed out — safe to retry |
| 409  | No*    | Conflict — resolve state, then retry |
| 413  | No     | Payload too large — reduce request size |
| 415  | No     | Unsupported media type — fix Content-Type |
| 422  | No     | Validation error — fix the request body |
| 429  | Yes    | Rate limited — retry after `Retry-After` delay |
| 500  | Yes*   | With exponential backoff + jitter |
| 502  | Yes    | Upstream unavailable — retry with backoff |
| 503  | Yes    | Service unavailable — retry after `Retry-After` or backoff |
| 504  | Yes    | Gateway timeout — retry with backoff |

*Conditional — see detailed notes below.

---

## 1xx Informational

| Code | Name | Microservice Context |
|------|------|---------------------|
| 100  | Continue | Used in large payload uploads; server confirms headers are acceptable before client sends body. Relevant for file-upload services or chunked transfer APIs. |
| 101  | Switching Protocols | WebSocket upgrade handshake. Seen in real-time event streaming between services. |
| 102  | Processing | Indicates long-running request accepted but not yet complete. Used by async task services to signal work-in-progress. |

## 2xx Success

| Code | Name | Microservice Context |
|------|------|---------------------|
| 200  | OK | Standard success. Synchronous request-response completed. |
| 201  | Created | Resource created. Response should include `Location` header pointing to the new resource. Common in POST-based service endpoints. |
| 202  | Accepted | Request accepted for async processing. The work has not completed yet. Return a task/job ID for polling or callback. Critical for async microservice patterns (saga orchestrators, task queues). |
| 204  | No Content | Success with no response body. Used for DELETE operations, PUT updates where no body is needed, and health check acknowledgments. |
| 206  | Partial Content | Range-based responses. Used by file/media services supporting resumable downloads. |

## 3xx Redirection

| Code | Name | Microservice Context |
|------|------|---------------------|
| 301  | Moved Permanently | Service endpoint permanently relocated. API gateways should update routing rules. Clients should cache the new location. |
| 302  | Found (Temporary Redirect) | Temporary redirect. Do not cache. Seen in OAuth flows and load balancer failover. |
| 304  | Not Modified | Cache validation response (ETag/If-None-Match). Reduces inter-service bandwidth. Use aggressively for read-heavy reference data services. |
| 307  | Temporary Redirect | Like 302 but preserves HTTP method. Preferred over 302 for POST/PUT redirects in API contexts. |
| 308  | Permanent Redirect | Like 301 but preserves HTTP method. Use for API versioning transitions. |

## 4xx Client Error

| Code | Name | Microservice Context | Retry? |
|------|------|---------------------|--------|
| 400  | Bad Request | Malformed request syntax, invalid parameters, or schema violation. Log the request for debugging. Do not retry — the calling service must fix its request. | No |
| 401  | Unauthorized | Missing or expired authentication token. In service mesh: JWT expired or mTLS cert invalid. Refresh the token and retry once. If it fails again, escalate. | Once after token refresh |
| 403  | Forbidden | Authenticated but not authorized. RBAC or scope violation. Do not retry — the service lacks the required permission. Alert on unexpected 403s between services (may indicate misconfigured roles). | No |
| 404  | Not Found | Resource does not exist. In microservices: could indicate a race condition (resource not yet created by upstream), stale cache, or incorrect routing. Distinguish between "never existed" and "not yet available" for retry decisions. | No (unless eventual consistency expected) |
| 405  | Method Not Allowed | HTTP method not supported on the endpoint. Indicates API contract mismatch between services. | No |
| 408  | Request Timeout | Server timed out waiting for the request. Safe to retry. Common under high load. Use backoff. | Yes |
| 409  | Conflict | State conflict (e.g., optimistic locking failure, duplicate creation). In sagas: may indicate a concurrent compensating transaction. Resolve the conflict, then retry if idempotent. | After conflict resolution |
| 413  | Payload Too Large | Request body exceeds server limit. Reduce payload size or use chunked upload. Check API gateway limits vs service limits. | No |
| 415  | Unsupported Media Type | Wrong `Content-Type` header. Contract mismatch between caller and callee. | No |
| 422  | Unprocessable Entity | Syntactically valid but semantically invalid request. Common in domain validation (business rule violations). Do not retry — the calling service must fix the data. | No |
| 429  | Too Many Requests | Rate limit exceeded. Respect the `Retry-After` header. Implement client-side rate limiting. In service mesh: check circuit breaker state. Consider adaptive concurrency. | Yes, after Retry-After delay |

## 5xx Server Error

| Code | Name | Microservice Context | Retry? |
|------|------|---------------------|--------|
| 500  | Internal Server Error | Unhandled exception in the target service. Retry with exponential backoff + jitter. If persistent, open circuit breaker. Alert immediately. | Yes, with backoff |
| 501  | Not Implemented | Feature not yet available. Indicates version mismatch or premature call to an unreleased endpoint. | No |
| 502  | Bad Gateway | API gateway or reverse proxy received an invalid response from the upstream service. Typically indicates upstream crash or misconfigured routing. Retry with backoff. | Yes, with backoff |
| 503  | Service Unavailable | Target service is overloaded or in maintenance. Respect `Retry-After` header. Circuit breaker should open after repeated 503s. Key signal for load shedding. | Yes, after Retry-After or backoff |
| 504  | Gateway Timeout | Upstream service did not respond within the gateway's timeout window. Review timeout chain: client timeout > gateway timeout > service timeout. Retry with backoff. | Yes, with backoff |

---

## Failure Handling Patterns by Status Code Class

| Class | Circuit Breaker Action | Alert Priority | Retry Strategy |
|-------|----------------------|----------------|----------------|
| 4xx (except 408, 429) | Do not count toward circuit breaker failure threshold | Low (log for debugging) | Do not retry |
| 408   | Count toward failure threshold | Medium | Retry with backoff |
| 429   | Consider bulkhead / rate limiter adjustment | Medium | Retry after Retry-After |
| 5xx   | Count toward circuit breaker failure threshold | High | Retry with exponential backoff + jitter |

## Timeout Chain Guidance

When diagnosing 504 Gateway Timeout, check the full timeout chain:

```
Client timeout > Load Balancer timeout > API Gateway timeout > Service timeout > DB/Cache timeout
```

Each layer's timeout must be shorter than the layer above it to prevent cascading timeouts.

## Key Headers for Resilience

| Header | Purpose | Used With |
|--------|---------|-----------|
| `Retry-After` | Seconds or date to wait before retrying | 429, 503 |
| `Idempotency-Key` | Ensures safe retries for non-idempotent operations | POST with retry |
| `X-Request-ID` / `X-Correlation-ID` | Distributed tracing across services | All requests |
| `ETag` / `If-None-Match` | Cache validation to reduce redundant transfers | 304 |
| `X-RateLimit-Remaining` | Proactive rate limit awareness | 429 prevention |
