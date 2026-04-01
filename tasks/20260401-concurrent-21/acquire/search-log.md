# Acquire Search Log

## Task ID
- 20260401-concurrent-21

## ACQ-001: Connection pooling sizing strategies

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Need knowledge about HikariCP connection pool sizing strategies, pool exhaustion detection mechanisms, and dynamic pool adjustment techniques. Related to open gap gap-20260401-exhausted-acq-test-thread-pool-sizing (adaptive thread pool sizing).

### Search Queries

#### Query 1
- **Query String**: HikariCP connection pool sizing configuration best practices
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing | Official HikariCP wiki — primary authoritative source on pool sizing from the library author |
| 2 | https://github.com/brettwooldridge/HikariCP#configuration-knobs-baby | Official HikariCP README configuration section — primary documentation for all pool configuration parameters |

#### Query 2
- **Query String**: connection pool exhaustion detection dynamic pool adjustment database
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:01:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing | Same primary source — also covers exhaustion prevention through proper sizing |

### Fetch Plan
- https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing → src-001-hikaricp-pool-sizing.md
- https://github.com/brettwooldridge/HikariCP#configuration-knobs-baby → src-002-hikaricp-configuration.md

### Notes
- Both candidate URLs are from the official HikariCP GitHub repository — the canonical primary source
- Different search strategies than those used in gap-20260401-exhausted-acq-test-thread-pool-sizing (which searched for generic "adaptive thread pool sizing" rather than product-specific documentation)
