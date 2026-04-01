# Raw Source

## Source ID
- src-008

## ACQ Event
- ACQ-003

## Source URL
- https://cloud.google.com/architecture/rate-limiting-strategies-techniques

## Fetch Timestamp
- 2026-04-01T10:23:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Google Cloud Architecture Center — well-maintained technical documentation from a major cloud provider

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output truncated to key algorithm descriptions

## Original Content

Rate-limiting strategies and techniques | Cloud Architecture Center

Overview

Rate limiting is a technique used to control the rate of requests that clients can make to an API. It protects your services from being overwhelmed by too many requests, whether from legitimate heavy usage, bugs in client applications, or malicious attacks (such as DDoS).

Why Rate Limiting Matters

Without rate limiting, a single client can monopolize server resources, degrading the experience for all other clients. Rate limiting ensures fair usage, protects backend services, and maintains service availability.

Rate Limiting Algorithms

1. Token Bucket Algorithm

The token bucket algorithm uses a bucket that holds tokens. Tokens are added at a constant rate. Each request consumes one token. If the bucket is empty, the request is rejected or queued.

Properties:
- Allows bursts up to the bucket capacity
- Smooth long-term rate limiting
- Easy to implement
- Memory efficient (stores only token count and last refill time)

2. Leaky Bucket Algorithm

The leaky bucket algorithm processes requests at a constant rate, regardless of the rate of incoming requests. Requests are added to a queue (the bucket), and processed (leaked) at a fixed rate.

Properties:
- Provides a smooth, constant output rate
- Does not allow bursts (unlike token bucket)
- Can cause queue buildup during traffic spikes

3. Fixed Window Counter

Divides time into fixed windows (e.g., 1-minute intervals) and counts requests per window. When the count exceeds the limit, subsequent requests are rejected until the next window.

Properties:
- Simple to implement
- Vulnerable to burst at window boundaries (a client can send limit requests at the end of one window and limit more at the start of the next)
- Memory efficient

4. Sliding Window Log

Maintains a log of timestamps for each request. The window slides with each request. Counts the number of requests within the window period.

Properties:
- Most accurate rate limiting
- No boundary burst problem
- Higher memory usage (stores every request timestamp)
- Higher computational cost per request

5. Sliding Window Counter

A hybrid approach that combines fixed window counters with a weighted average to approximate the sliding window. Uses counters from the current and previous windows, weighted by the position within the current window.

Properties:
- Good approximation of sliding window log
- Lower memory than sliding window log
- Minimal boundary burst effect
- Used by many production systems (e.g., Redis-based rate limiters)

Per-Client Rate Limiting

Rate limits can be applied at different granularities:
- Per API key: each API key has its own rate limit
- Per user: each authenticated user has their own limit
- Per IP address: each source IP has its own limit (caution: NAT may cause false positives)
- Per endpoint: different endpoints may have different limits (e.g., login endpoint has stricter limits)
- Global: a single limit applies to all requests to the service

Implementation Considerations

- Use HTTP 429 (Too Many Requests) status code when rate limiting
- Include Retry-After header to tell clients when to retry
- Include X-RateLimit-Limit, X-RateLimit-Remaining, and X-RateLimit-Reset headers for transparency
- Consider using a distributed rate limiter (e.g., Redis-based) for multi-instance deployments
- Implement graceful degradation: return cached responses instead of errors when possible
- Log rate-limited requests for monitoring and adjustment

Defense in Depth

Rate limiting should be layered:
- API Gateway level: coarse-grained limits for all incoming traffic
- Application level: fine-grained, endpoint-specific limits
- Database level: connection pool limits and query timeouts
