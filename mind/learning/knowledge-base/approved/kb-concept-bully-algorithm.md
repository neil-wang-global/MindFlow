# Knowledge Base Entry

## Type
- concept

## Summary
- Bully algorithm: leader election protocol for fully connected networks where highest-ID process becomes coordinator using ELECTION/ANSWER/COORDINATOR messages with O(n^2) worst-case complexity; self-stabilizing after failures but requires all processes to know each other's IDs

## Source Lineage
- Task ID: 20260401-concurrent-30
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-30.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-bully-algorithm.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-30-bully-algorithm.md`
- Original Source Anchor: `tasks/20260401-concurrent-30/acquire/raw-sources/src-001-bully-algorithm.md`
- Original Source URL: https://www.cs.colostate.edu/~cs551/CourseNotes/Synchronization/BullyExample.html

## Key Evidence
> "The Bully Algorithm was proposed by Hector Garcia-Molina in 1982. It is used in distributed systems to elect a coordinator (leader) among a group of processes."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-30-bully-algorithm.md

## Applicability
- Applies to: distributed systems requiring leader election in fully connected topologies where all process IDs are known
- Does not apply to: ring or partial topologies; systems where process capabilities should influence leader selection; networks with frequent partitions

## Notes
- Garcia-Molina 1982; worst case O(n^2) messages when lowest-ID process initiates
