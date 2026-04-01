# Knowledge Base Entry

## Type
- concept

## Summary
- Token bucket and leaky bucket (as a meter) are mathematically equivalent — they are mirror images. With identical parameters, both classify the same traffic as conforming or nonconforming. The leaky bucket as a queue is a different, more restrictive special case that enforces strict rate output without allowing bursts.

## Source Lineage
- Task ID: 20260401-protocol-validation
- Task Learning Record: mind/learning/task-learning/tl-20260401-protocol-validation.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-token-leaky-equivalence.md
- Review File: mind/learning/reviews/review-20260401-token-leaky-equivalence.md
- Original Source Anchor: tasks/20260401-protocol-validation/acquire/raw-sources/src-001-token-bucket.md
- Original Source URL: https://en.wikipedia.org/wiki/Token_bucket

## Key Evidence
> "The token bucket is directly comparable to one of two versions of the leaky bucket algorithm in the literature. The comparable version—the leaky bucket as a meter—mirrors the token bucket: conforming packets add fluid (equivalent to tokens removed in the token bucket) to a finite-capacity bucket, from which fluid drains at a constant rate (equivalent to the fixed-rate token addition)."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-token-leaky-equivalence.md

## Applicability
- Applies to: choosing between token bucket and leaky bucket implementations, understanding rate limiting algorithm equivalences
- Does not apply to: leaky bucket as a queue (which is a different, non-equivalent variant)

## Notes
- none
