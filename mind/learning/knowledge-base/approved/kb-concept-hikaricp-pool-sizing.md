# Knowledge Base Entry

## Type
- concept

## Summary
- Connection pool sizing should follow the formula `connections = ((core_count * 2) + effective_spindle_count)`, producing significantly smaller pools than intuition suggests. For a 4-core server with SSD, the optimal pool size is approximately 9-10 connections, even under high concurrent user load, because larger pools cause CPU context switching and I/O contention at the database level.

## Source Lineage
- Task ID: 20260401-concurrent-21
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-21.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-21-hikaricp-pool-sizing.md
- Review File: mind/learning/reviews/review-20260401-concurrent-21-hikaricp-pool-sizing.md
- Original Source Anchor: tasks/20260401-concurrent-21/acquire/raw-sources/src-001-hikaricp-pool-sizing.md
- Original Source URL: https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing

## Key Evidence
> "The PostgreSQL project published a formula that has been widely adopted:\n\n```\nconnections = ((core_count * 2) + effective_spindle_count)\n```\n\nWhere:\n- `core_count` is the number of CPU cores available on the database server\n- `effective_spindle_count` is the number of hard disk spindles (for modern SSDs, this is effectively 1)\n\nA server with a 4-core CPU and a single SSD-backed volume should have a pool size of roughly `((4 * 2) + 1) = 9`. Call it 10 as a nice round number."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-21-hikaricp-pool-sizing.md

## Applicability
- Applies to: JDBC connection pool sizing for applications using HikariCP or similar connection pools backed by relational databases; the formula is most accurate when the database server has dedicated CPU and disk resources
- Does not apply to: connection pools fronting non-relational databases with different concurrency models; scenarios requiring autonomous adaptive sizing (the formula is static and requires manual recalculation when hardware changes); distributed database clusters where connections are sharded across nodes

## Notes
- The formula originates from the PostgreSQL project and has been widely adopted across the Java ecosystem through HikariCP's documentation
