# Draft Knowledge

## Type
- method

## Task ID
- 20260401-concurrent-13

## Summary
- Canary health is assessed via weighted multi-metric scoring: each metric produces a normalized score (0.0/0.5/1.0), weighted average determines pass (>=0.80), extend (0.50-0.80), or fail (<0.50)

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-13.md
- candidate knowledge item reference: KDC-003

## Source Type
- task-output

## Source Anchor
- tasks/20260401-concurrent-13/_output/canary-checker-design.md §3.2 Analysis Scoring

## Original Excerpt
> "Each metric produces a score:\n- **Pass (1.0)**: metric is within threshold\n- **Marginal (0.5)**: metric is within 2x the threshold (e.g., delta is 0.8% when threshold is 1%)\n- **Fail (0.0)**: metric exceeds threshold"

## Candidate Conclusion
- Canary health can be assessed using a weighted multi-metric scoring system where each metric (error rate, latency percentiles, saturation) produces a normalized score (0.0/0.5/1.0), and the weighted average determines the overall decision: pass (>=0.80), extend (0.50-0.80), or fail (<0.50). Error rate should carry the highest weight (0.40) as it most directly indicates user-facing impact.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-13-canary-scoring.md

## Notes
- Source is task-output; scoring method is a design pattern produced by the task, not externally grounded
