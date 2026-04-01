# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-21

## Summary
- Connection pool exhaustion is detected through leak detection, Micrometer metrics monitoring (primarily the `pending` metric), and health checks that verify connection availability

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-21.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-21/acquire/raw-sources/src-001-hikaricp-pool-sizing.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-concurrent-21/acquire/verification-report.md` §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Pool exhaustion occurs when all connections in the pool are checked out and a new request arrives. Symptoms include:\n\n- Application threads blocking on `getConnection()`\n- `ConnectionTimeoutException` after `connectionTimeout` expires\n- Cascading slowdowns as blocked threads hold other resources\n\n#### Detection Mechanisms\n\n1. **Leak Detection**: Set `leakDetectionThreshold` to detect connections not returned within the threshold. HikariCP logs a stack trace showing where the connection was checked out.\n\n2. **Metrics**: HikariCP exposes pool metrics through Micrometer:\n   - `hikaricp.connections.active` — currently in-use connections\n   - `hikaricp.connections.idle` — available idle connections\n   - `hikaricp.connections.pending` — threads waiting for a connection\n   - `hikaricp.connections.timeout` — total timeout count"

## Candidate Conclusion
- Connection pool exhaustion is detected through three complementary mechanisms: (1) leak detection via `leakDetectionThreshold` which logs stack traces of unreturned connections, (2) Micrometer metrics monitoring where a sustained `pending` count above 0 indicates undersizing or leaks, and (3) health checks that verify connection availability within a fraction of normal timeout. The `hikaricp.connections.pending` metric is the primary early-warning indicator.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-21-pool-exhaustion-detection.md

## Notes
- none
