# Knowledge Base Entry

## Type
- concept

## Summary
- The token bucket algorithm controls traffic by maintaining a fixed-capacity bucket of tokens that are added at a constant rate. Each transmission consumes tokens; if tokens are available, the transmission proceeds; otherwise it is non-conformant. This mechanism allows burst traffic up to bucket capacity while enforcing a long-term average rate.

## Source Lineage
- Task ID: 20260401-protocol-validation
- Task Learning Record: mind/learning/task-learning/tl-20260401-protocol-validation.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-token-bucket-mechanism.md
- Review File: mind/learning/reviews/review-20260401-token-bucket-mechanism.md
- Original Source Anchor: tasks/20260401-protocol-validation/acquire/raw-sources/src-001-token-bucket.md
- Original Source URL: https://en.wikipedia.org/wiki/Token_bucket

## Key Evidence
> "The algorithm uses an analogy of a fixed-capacity bucket into which tokens—typically representing a unit of bytes or a single packet of predetermined size—are added at a fixed rate. When checking a packet for conformance, the bucket is inspected for sufficient tokens. If enough tokens exist, the appropriate number are removed ("cashed in") and the packet passes through for transmission. If tokens are insufficient, the packet is non-conformant and the bucket contents remain unchanged."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-token-bucket-mechanism.md

## Applicability
- Applies to: API rate limiting design, network traffic shaping, bandwidth management, database IO flow control
- Does not apply to: non-rate-based resource allocation, scenarios where strict jitter-free output is required (use leaky bucket as queue instead)

## Notes
- none
