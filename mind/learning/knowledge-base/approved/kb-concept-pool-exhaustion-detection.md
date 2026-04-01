# Knowledge Base Entry

## Type
- concept

## Summary
- Connection pool exhaustion is detected through three complementary mechanisms: (1) leak detection via `leakDetectionThreshold` which logs stack traces of unreturned connections, (2) Micrometer metrics monitoring where a sustained `pending` count above 0 indicates undersizing or leaks, and (3) health checks that verify connection availability within a fraction of normal timeout. The `hikaricp.connections.pending` metric is the primary early-warning indicator.

## Source Lineage
- Task ID: 20260401-concurrent-21
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-21.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-21-pool-exhaustion-detection.md
- Review File: mind/learning/reviews/review-20260401-concurrent-21-pool-exhaustion-detection.md
- Original Source Anchor: tasks/20260401-concurrent-21/acquire/raw-sources/src-001-hikaricp-pool-sizing.md
- Original Source URL: https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing

## Key Evidence
> "Pool exhaustion occurs when all connections in the pool are checked out and a new request arrives. Symptoms include:\n\n- Application threads blocking on `getConnection()`\n- `ConnectionTimeoutException` after `connectionTimeout` expires\n- Cascading slowdowns as blocked threads hold other resources\n\n#### Detection Mechanisms\n\n1. **Leak Detection**: Set `leakDetectionThreshold` to detect connections not returned within the threshold. HikariCP logs a stack trace showing where the connection was checked out.\n\n2. **Metrics**: HikariCP exposes pool metrics through Micrometer:\n   - `hikaricp.connections.active` — currently in-use connections\n   - `hikaricp.connections.idle` — available idle connections\n   - `hikaricp.connections.pending` — threads waiting for a connection\n   - `hikaricp.connections.timeout` — total timeout count"

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-21-pool-exhaustion-detection.md

## Applicability
- Applies to: applications using HikariCP (or similar connection pools exposing Micrometer metrics) that need to detect and prevent pool exhaustion; particularly valuable in microservice architectures where each service instance manages its own connection pool
- Does not apply to: connection-pool-less architectures (e.g., serverless functions creating individual connections); database proxies like PgBouncer that manage pooling externally; systems where connection pool metrics are not exposed through Micrometer

## Notes
- The leak detection and metrics approach is specific to HikariCP but the pattern (monitor pending requests, detect unreturned resources, implement proactive health checks) applies broadly to resource pool monitoring
