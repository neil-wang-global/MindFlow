# Knowledge Base Entry

## Type
- concept

## Summary
- The CAP theorem establishes a proven impossibility result: no distributed data store can simultaneously provide consistency (linearizability), availability (guaranteed response from non-failing nodes), and partition tolerance (operation despite message loss). Since network partitions are unavoidable in distributed systems, the practical design choice reduces to CP vs AP during partition events.

## Source Lineage
- Task ID: 20260401-pure-learning-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-pure-learning-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-pure-learning-test-cap-impossibility.md
- Review File: mind/learning/reviews/review-20260401-pure-learning-test-cap-impossibility.md
- Original Source Anchor: tasks/20260401-pure-learning-test/acquire/raw-sources/src-001-cap-theorem.md
- Original Source URL: https://en.wikipedia.org/wiki/CAP_theorem

## Key Evidence
> "The CAP theorem (also called **Brewer's theorem**) is a fundamental principle in database theory stating that any distributed data store can guarantee at most two of three properties simultaneously"

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-pure-learning-test-cap-impossibility.md

## Applicability
- Applies to: all distributed data stores and distributed database design decisions; understanding CAP trade-offs is prerequisite for choosing between CP and AP architectures
- Does not apply to: single-node databases where partition tolerance is not a concern; the CAP theorem does not address latency or performance trade-offs (see PACELC extension)

## Notes
- Formally proved by Gilbert and Lynch (2002) based on Brewer's 2000 conjecture
- Brewer (2012) clarified that the "two out of three" framing is somewhat misleading — all three can be satisfied when no partition exists
