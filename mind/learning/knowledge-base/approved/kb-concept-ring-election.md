# Knowledge Base Entry

## Type
- concept

## Summary
- Chang-Roberts ring election algorithm achieves O(n log n) average-case message complexity on unidirectional ring topology, with each process only needing to know its ring neighbor

## Source Lineage
- Task ID: 20260401-concurrent-30
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-30.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-ring-election.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-30-ring-election.md`
- Original Source Anchor: `tasks/20260401-concurrent-30/acquire/raw-sources/src-002-ring-election.md`
- Original Source URL: https://www.cs.uic.edu/~ajayk/Chapter9.pdf

## Key Evidence
> "The Chang-Roberts algorithm operates on a unidirectional ring topology."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-30-ring-election.md

## Applicability
- Applies to: distributed systems with ring topology requiring leader election; systems where processes only know their immediate neighbor
- Does not apply to: fully connected topologies (use Bully); systems requiring sub-O(n) election; asynchronous systems without failure detectors (FLP impossibility applies)

## Notes
- Chang and Roberts 1979; Hirschberg-Sinclair 1980 improved worst case to O(n log n) using bidirectional communication
