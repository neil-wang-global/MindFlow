# Task Profile

## Task ID
- 20260401-concurrent-22

## Task Type
- learning

## Goal
- Research bulkhead pattern variants including thread pool bulkhead, semaphore bulkhead, and process-level isolation. Compare their trade-offs, applicability contexts, and implementation characteristics. This research is related to an existing deferred review (review-20260401-bulkhead-isolation.md) which was deferred due to insufficient cross-validation sources.

## Inputs
- mind/learning/knowledge-base/approved/kb-concept-circuit-breaker-states.md (sibling resilience pattern)
- mind/learning/reviews/review-20260401-bulkhead-isolation.md (deferred review on bulkhead isolation)
- mind/soul/core.md (soul constraints)

## Success Criteria
- External knowledge acquisition about bulkhead variants completed with verified sources
- Research summary produced in _output/bulkhead-variants-research.md covering thread pool, semaphore, and process-level isolation variants
- Knowledge promoted through terminal Learning pipeline

## Complexity
- medium

## Risk
- medium

## Capability Needs
- web-search: for acquiring external knowledge about bulkhead pattern variants
- knowledge-synthesis: for producing a coherent research summary from multiple sources

## Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Knowledge Source Prohibition: search summaries and AI-generated overviews are not valid sources
- Must acquire from primary sources (library documentation, architecture documentation, production-grade references)

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — this is a research task grounded in external sources, not requiring abstraction beyond what sources state

## Notes
- The deferred review review-20260401-bulkhead-isolation.md was deferred because the Resilience4j source failed to fetch, leaving insufficient cross-validation. This task's ACQ may provide the additional evidence needed.
