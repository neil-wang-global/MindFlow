# Knowledge Base Entry

## Type
- concept

## Summary
- Redlock achieves distributed mutual exclusion across N independent Redis masters using majority quorum without replication, providing safety, deadlock freedom via TTL, and fault tolerance

## Source Lineage
- Task ID: 20260401-concurrent-30
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-30.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-redlock-algorithm.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-30-redlock-algorithm.md`
- Original Source Anchor: `tasks/20260401-concurrent-30/acquire/raw-sources/src-003-redlock-algorithm.md`
- Original Source URL: https://redis.io/docs/latest/develop/use/patterns/distributed-locks/

## Key Evidence
> "In the distributed version of the algorithm we assume we have N Redis masters. These nodes are totally independent, so we don't use replication or any other implicit coordination system."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-30-redlock-algorithm.md

## Applicability
- Applies to: Redis-based distributed systems requiring mutual exclusion across independent masters; scenarios where majority quorum is acceptable
- Does not apply to: systems requiring strong consensus guarantees (use Paxos/Raft-based solutions); single-master Redis setups (unsafe due to replication lag); systems where bounded clock drift assumption is unacceptable

## Notes
- Recommended N=5; correctness critiqued by Kleppmann regarding timing assumptions
