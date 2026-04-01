# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-05

## Summary
- Five rate limiting algorithms serve different needs: token bucket allows bursts; sliding window counter provides practical hybrid accuracy used in production

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- candidate knowledge item reference: KDC-004

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-05/acquire/raw-sources/src-008-rate-limiting-strategies.md`
  - ACQ Event: ACQ-003
  - Verification Report: `tasks/20260401-concurrent-05/acquire/verification-report.md §ACQ-003`
  - Verification Status: passed

## Original Excerpt
> "The token bucket algorithm uses a bucket that holds tokens. Tokens are added at a constant rate. Each request consumes one token. If the bucket is empty, the request is rejected or queued."

## Candidate Conclusion
- Five rate limiting algorithms serve different needs: token bucket allows controlled bursts with smooth long-term rate; leaky bucket enforces constant output rate; fixed window is simple but vulnerable to boundary bursts; sliding window log provides highest accuracy at higher memory cost; sliding window counter provides a practical hybrid used in production systems

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-05-rate-limiting-algorithms.md`

## Notes
- Source: Google Cloud Architecture Center
