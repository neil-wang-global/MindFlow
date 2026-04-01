# Knowledge Base Entry

## Type
- concept

## Summary
- ZooKeeper implements distributed locks as recipes using ephemeral sequential znodes with automatic crash cleanup, FIFO ordering, and targeted watches to avoid herd effect

## Source Lineage
- Task ID: 20260401-concurrent-30
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-30.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-zookeeper-locks.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-30-zookeeper-locks.md`
- Original Source Anchor: `tasks/20260401-concurrent-30/acquire/raw-sources/src-005-zookeeper-locks.md`
- Original Source URL: https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks

## Key Evidence
> "Fully distributed locks that are globally synchronous, meaning at any snapshot in time no two clients think they hold the same lock. These can be implemented using ZooKeeper."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-30-zookeeper-locks.md

## Applicability
- Applies to: distributed systems requiring fair, deadlock-free mutual exclusion with both shared and exclusive lock support
- Does not apply to: systems requiring mandatory (not advisory) locks; scenarios where ZooKeeper cluster overhead is unacceptable; high-frequency fine-grained locking with sub-millisecond requirements

## Notes
- Supports read-write locks; watch mechanism avoids herd effect by watching only immediate predecessor
