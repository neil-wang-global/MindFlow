# Knowledge Base Entry

## Type
- concept

## Summary
- Higher-order functions are the mechanism that makes functional composition possible -- by accepting and returning functions, they enable building complex behavior from simple building blocks. Combined with currying (all Haskell functions are automatically curried), partial application becomes natural, and point-free style emerges as a way to express data transformation pipelines without naming intermediate values. This composability is what makes functional programming practically useful beyond its theoretical elegance.

## Source Lineage
- Task ID: 20260401-concurrent-04
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-04.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-04-hof-currying.md
- Review File: mind/learning/reviews/review-20260401-concurrent-04-hof-currying.md
- Original Source Anchor: tasks/20260401-concurrent-04/acquire/raw-sources/src-005-higher-order-function.md
- Original Source URL: https://wiki.haskell.org/Higher_order_function

## Key Evidence
> "A higher-order function is a function that takes other functions as arguments or returns a function as result."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-04-hof-currying.md

## Applicability
- Applies to: designing composable APIs and transformation pipelines; understanding function-centric design patterns; informing architecture decisions about data processing pipelines in distributed systems
- Does not apply to: contexts where procedural step-by-step execution is required and cannot be decomposed into composable units

## Notes
- none
