# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-protocol-validation

## Summary
- Token bucket and leaky bucket (as a meter) are mathematically equivalent mirror images; with identical parameters, both classify the same traffic as conforming or nonconforming.

## From Task Learning
- mind/learning/task-learning/tl-20260401-protocol-validation.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-protocol-validation/acquire/raw-sources/src-001-token-bucket.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-protocol-validation/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "The token bucket is directly comparable to one of two versions of the leaky bucket algorithm in the literature. The comparable version—the leaky bucket as a meter—mirrors the token bucket: conforming packets add fluid (equivalent to tokens removed in the token bucket) to a finite-capacity bucket, from which fluid drains at a constant rate (equivalent to the fixed-rate token addition)."

## Candidate Conclusion
- The token bucket and leaky bucket (as a meter) are mathematically equivalent — they are mirror images. With identical parameters, both classify the same traffic as conforming or nonconforming. The leaky bucket as a queue is a different, more restrictive special case that enforces strict rate output without allowing bursts.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-token-leaky-equivalence.md

## Notes
- none
