# Task Learning Record

## Task ID
- 20260401-concurrent-21

## Task Summary
- Researched connection pooling strategies with focus on HikariCP sizing, pool exhaustion detection, and dynamic pool adjustment
- Produced a synthesized research document at `tasks/20260401-concurrent-21/_output/connection-pooling-research.md`
- Identified that the research partially addresses the open knowledge gap `gap-20260401-exhausted-acq-test-thread-pool-sizing` (adaptive thread pool sizing) but does not fully resolve it because HikariCP uses manual/JMX-based adjustment rather than autonomous adaptive algorithms

## External Acquisition

### ACQ-001: Connection pooling sizing strategies

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-21/acquire/verification-report.md` §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] HikariCP connection pool sizing formula and fixed-size pool recommendation

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-21/acquire/raw-sources/src-001-hikaricp-pool-sizing.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The PostgreSQL project published a formula that has been widely adopted:\n\n```\nconnections = ((core_count * 2) + effective_spindle_count)\n```\n\nWhere:\n- `core_count` is the number of CPU cores available on the database server\n- `effective_spindle_count` is the number of hard disk spindles (for modern SSDs, this is effectively 1)\n\nA server with a 4-core CPU and a single SSD-backed volume should have a pool size of roughly `((4 * 2) + 1) = 9`. Call it 10 as a nice round number."
- **Derived Conclusion**: Connection pool sizing should follow the formula `connections = ((core_count * 2) + effective_spindle_count)`, producing significantly smaller pools than intuition suggests. For a 4-core server with SSD, the optimal pool size is approximately 9-10 connections, even under high concurrent user load, because larger pools cause CPU context switching and I/O contention at the database level.

### [KDC-002] HikariCP pool exhaustion detection via leak detection and metrics monitoring

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-21/acquire/raw-sources/src-001-hikaricp-pool-sizing.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Pool exhaustion occurs when all connections in the pool are checked out and a new request arrives. Symptoms include:\n\n- Application threads blocking on `getConnection()`\n- `ConnectionTimeoutException` after `connectionTimeout` expires\n- Cascading slowdowns as blocked threads hold other resources\n\n#### Detection Mechanisms\n\n1. **Leak Detection**: Set `leakDetectionThreshold` to detect connections not returned within the threshold. HikariCP logs a stack trace showing where the connection was checked out.\n\n2. **Metrics**: HikariCP exposes pool metrics through Micrometer:\n   - `hikaricp.connections.active` — currently in-use connections\n   - `hikaricp.connections.idle` — available idle connections\n   - `hikaricp.connections.pending` — threads waiting for a connection\n   - `hikaricp.connections.timeout` — total timeout count"
- **Derived Conclusion**: Connection pool exhaustion is detected through three complementary mechanisms: (1) leak detection via `leakDetectionThreshold` which logs stack traces of unreturned connections, (2) Micrometer metrics monitoring where a sustained `pending` count above 0 indicates undersizing or leaks, and (3) health checks that verify connection availability within a fraction of normal timeout. The `hikaricp.connections.pending` metric is the primary early-warning indicator.

## Potential Capability Impact
- none

## Next Promotion Target
- KDC-001: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-21-hikaricp-pool-sizing.md`
- KDC-002: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-21-pool-exhaustion-detection.md`

## Notes
- The open knowledge gap `gap-20260401-exhausted-acq-test-thread-pool-sizing` is partially addressed by this research: the pool sizing formula and JMX-based runtime resizing provide practical pool sizing strategies, but the gap's core requirement for autonomous adaptive algorithms (Hill Climbing, Little's Law approaches) remains unresolved
- Per concurrency rules, the gap file itself was not modified; this partial address is recorded here only
