# Connection Pooling Research

## Task ID
- 20260401-concurrent-21

## Research Summary
This document synthesizes findings on connection pool sizing strategies, pool exhaustion detection mechanisms, and dynamic pool adjustment techniques, based on verified primary sources from the HikariCP project documentation.

## 1. Pool Sizing Strategies

### The Sizing Formula
The widely-adopted pool sizing formula, originating from the PostgreSQL community:

```
connections = ((core_count * 2) + effective_spindle_count)
```

- `core_count`: CPU cores on the database server
- `effective_spindle_count`: number of disk spindles (typically 1 for SSD)

**Example**: A 4-core server with SSD needs approximately `(4 * 2) + 1 = 9` connections.

### Why Smaller Pools Outperform Larger Ones

1. **CPU contention**: With N CPU cores, having more than N concurrent queries forces context switching between threads, which is expensive
2. **I/O contention**: All queries compete for the same disk I/O; more concurrent queries increase seek time, not throughput
3. **Memory overhead**: Each connection holds buffers, prepared statement caches, and other per-connection state
4. **Lock contention**: Larger pools create more contention within the pool's internal data structures

### Fixed-Size Pool Recommendation
HikariCP recommends `minimumIdle = maximumPoolSize` (the default behavior) for a fixed-size pool. Benefits:
- Eliminates connection creation/destruction overhead during normal operation
- Provides predictable resource usage
- Reduces latency variance from connection warm-up

### Key Configuration Parameters

| Parameter | Default | Purpose |
|-----------|---------|---------|
| `maximumPoolSize` | 10 | Maximum connections (idle + active) |
| `minimumIdle` | = maximumPoolSize | Minimum idle connections maintained |
| `connectionTimeout` | 30000ms | Max wait time for a connection |
| `idleTimeout` | 600000ms (10 min) | Max idle time before eviction |
| `maxLifetime` | 1800000ms (30 min) | Max connection lifetime |
| `leakDetectionThreshold` | 0 (disabled) | Leak detection threshold |

## 2. Pool Exhaustion Detection

### Symptoms
- Application threads block on `getConnection()`
- `ConnectionTimeoutException` after `connectionTimeout` expires
- Cascading slowdowns as blocked threads hold other resources

### Detection Mechanisms

#### Leak Detection
Set `leakDetectionThreshold` (minimum 2000ms) to detect connections not returned within the threshold. HikariCP logs stack traces showing where leaked connections were checked out.

#### Metrics-Based Monitoring
HikariCP exposes pool metrics through Micrometer:

| Metric | Meaning |
|--------|---------|
| `hikaricp.connections.active` | Currently in-use connections |
| `hikaricp.connections.idle` | Available idle connections |
| `hikaricp.connections.pending` | Threads waiting for a connection |
| `hikaricp.connections.timeout` | Total timeout count |
| `hikaricp.connections.creation` | Connection creation time histogram |
| `hikaricp.connections.acquire` | Connection acquire time histogram |
| `hikaricp.connections.usage` | Connection usage duration histogram |

**Key indicator**: A sustained `pending` count above 0 indicates pool undersizing or a connection leak.

#### Health Checks
Verify a connection can be obtained within a fraction of the normal timeout to detect approaching exhaustion before it impacts users.

### Prevention Strategies
- Size the pool using the formula above
- Set `connectionTimeout` to a reasonable value
- Always close connections in `finally` blocks or use try-with-resources
- Monitor the `pending` threads metric

## 3. Dynamic Pool Adjustment

### Warm-Up Strategy
Set `minimumIdle` lower than `maximumPoolSize` to allow the pool to:
- Start with fewer connections during low-load periods
- Grow to `maximumPoolSize` under load
- Shrink back during idle periods (connections evicted after `idleTimeout`)

### Runtime Resizing via JMX
HikariCP supports `HikariConfigMXBean` for runtime modification:
- `setMaximumPoolSize(int)` — adjust maximum pool size at runtime
- `setMinimumIdle(int)` — adjust minimum idle connections at runtime

### Considerations for Dynamic Sizing

| Factor | Impact |
|--------|--------|
| Connection creation latency | TCP handshake + auth + SSL adds per-connection overhead |
| Connection churn | Aggressive idle eviction causes repeated create/destroy cycles |
| Database max_connections | Hard limit shared across all application instances |
| Monitoring scope | Must monitor both application-side pool metrics and database-side connection counts |

## Relationship to Open Knowledge Gap

The open gap `gap-20260401-exhausted-acq-test-thread-pool-sizing` concerns **adaptive thread pool sizing algorithms** that dynamically adjust thread pool sizes based on workload characteristics. This connection pooling research partially addresses the gap:

- **Overlapping area**: The pool sizing formula and dynamic adjustment via JMX provide concrete strategies for sizing connection pools (a specific type of thread/resource pool)
- **Gap remainder**: The gap specifically seeks adaptive algorithms that autonomously adjust based on throughput metrics and resource utilization feedback loops (e.g., Hill Climbing, Little's Law approaches). HikariCP's approach is manual/JMX-based rather than autonomous, so the core gap around fully adaptive algorithms remains open.

## Sources
- src-001: HikariCP Wiki — About Pool Sizing (https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing)
- src-002: HikariCP Configuration Documentation (https://github.com/brettwooldridge/HikariCP#configuration-knobs-baby)
