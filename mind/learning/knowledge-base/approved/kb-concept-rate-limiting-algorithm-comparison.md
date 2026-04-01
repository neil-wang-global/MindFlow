# Knowledge Base Entry

## Type
- concept

## Summary
- Five rate limiting algorithms serve different needs: token bucket allows controlled bursts with smooth long-term rate; leaky bucket enforces constant output rate; fixed window is simple but vulnerable to boundary bursts; sliding window log provides highest accuracy at higher memory cost; sliding window counter provides a practical hybrid used in production systems

## Source Lineage
- Task ID: 20260401-concurrent-05
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-rate-limiting-algorithms.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-05-rate-limiting-algorithms.md`
- Original Source Anchor: `tasks/20260401-concurrent-05/acquire/raw-sources/src-008-rate-limiting-strategies.md`
- Original Source URL: https://cloud.google.com/architecture/rate-limiting-strategies-techniques

## Key Evidence
> "The token bucket algorithm uses a bucket that holds tokens. Tokens are added at a constant rate. Each request consumes one token. If the bucket is empty, the request is rejected or queued."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-05-rate-limiting-algorithms.md`

## Applicability
- Applies to: API gateway rate limiting, per-client throttling, DDoS protection, resource fairness enforcement in distributed systems
- Does not apply to: application-internal flow control where backpressure mechanisms are more appropriate

## Notes
- Complements existing kb-concept-token-bucket-mechanism.md which covers the token bucket algorithm in isolation
- Sliding window counter is the most common production choice (used in Redis-based rate limiters)
- HTTP 429 (RFC 6585) is the standard response code; include Retry-After and X-RateLimit-* headers
