# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://github.com/brettwooldridge/HikariCP/wiki/About-Pool-Sizing

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official project wiki maintained by the HikariCP author (Brett Wooldridge)

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# About Pool Sizing

## Not-So-Common Knowledge

A connection pool is a cache of database connections maintained so that the connections can be reused when future requests to the database are required. Connection pools are used to enhance the performance of executing commands on a database.

### The Pool Sizing Sweet Spot

One of the most common misconceptions about connection pool sizing is that "bigger is better." In fact, with connection pooling, having a pool that is too large is often worse than having a pool that is smaller.

Consider this scenario: You have a website that is so successful that at peak volumes it serves 10,000 simultaneous front-end users. If each front-end request takes roughly the same amount of time, and the work involves a small database query (e.g. a single SQL statement or a few), consider the question: What should the connection pool size be? The answer might surprise you...

#### The Formula

The PostgreSQL project published a formula that has been widely adopted:

```
connections = ((core_count * 2) + effective_spindle_count)
```

Where:
- `core_count` is the number of CPU cores available on the database server
- `effective_spindle_count` is the number of hard disk spindles (for modern SSDs, this is effectively 1)

A server with a 4-core CPU and a single SSD-backed volume should have a pool size of roughly `((4 * 2) + 1) = 9`. Call it 10 as a nice round number.

This seems counterintuitive — with 10,000 users, you really only need a pool of 10? Yes, and if you run a load test, you will find that 10 vs. even 50 connections makes virtually no difference in throughput but with a significant difference in average query execution time.

#### Why Smaller Is Better

Think about it from the database server's perspective: If you have only 10 CPU cores, having 10 simultaneous queries means that each core is working on one query. Even with hyperthreading, having more queries in-flight than there are CPU cores means threads compete for CPU time. Context switching between threads is expensive, and the more connections you have active, the worse it gets.

Beyond CPU-bound work, consider I/O. If you have a single disk drive, all 10 queries are reading and writing to the same disk. Adding more concurrent queries does not make the disk faster — it makes it slower as the disk head has to seek between more locations.

#### Pool Locking

HikariCP implements a concurrent bag for pooling connections with minimal locking overhead. When the pool is too large:

1. More connections mean more memory usage (each connection holds buffers, prepared statement caches, etc.)
2. More connections mean more context switching at the database level
3. More connections create more lock contention within the pool itself

#### Fixed-Size Pool Recommendation

For most applications, HikariCP recommends a fixed-size pool where `minimumIdle` equals `maximumPoolSize`. This is actually the default behavior. A fixed-size pool avoids the overhead of connection creation and destruction during normal operation.

### Connection Pool Exhaustion

Pool exhaustion occurs when all connections in the pool are checked out and a new request arrives. Symptoms include:

- Application threads blocking on `getConnection()`
- `ConnectionTimeoutException` after `connectionTimeout` expires
- Cascading slowdowns as blocked threads hold other resources

#### Detection Mechanisms

1. **Leak Detection**: Set `leakDetectionThreshold` to detect connections not returned within the threshold. HikariCP logs a stack trace showing where the connection was checked out.

2. **Metrics**: HikariCP exposes pool metrics through Micrometer:
   - `hikaricp.connections.active` — currently in-use connections
   - `hikaricp.connections.idle` — available idle connections
   - `hikaricp.connections.pending` — threads waiting for a connection
   - `hikaricp.connections.timeout` — total timeout count

3. **Health Checks**: Implement a health check that verifies a connection can be obtained within a fraction of the normal timeout.

#### Prevention Strategies

- Properly size the pool using the formula above
- Set `connectionTimeout` to a reasonable value (default: 30 seconds)
- Always close connections in a `finally` block or use try-with-resources
- Monitor `pending` threads metric — any sustained count above 0 indicates the pool is undersized or there is a leak

### Dynamic Pool Adjustment

While HikariCP recommends fixed-size pools, some scenarios require dynamic adjustment:

1. **Warm-up**: Setting `minimumIdle` lower than `maximumPoolSize` allows the pool to start small and grow to the maximum under load, then shrink back during idle periods.

2. **Runtime Resizing**: HikariCP supports `HikariConfigMXBean` JMX interface for runtime modification of pool parameters. Key methods:
   - `setMaximumPoolSize(int)` — adjust maximum pool size at runtime
   - `setMinimumIdle(int)` — adjust minimum idle connections at runtime

3. **Considerations for Dynamic Sizing**:
   - Creating new connections has latency cost (TCP handshake, authentication, SSL negotiation)
   - Destroying idle connections too aggressively causes connection churn
   - The database server's `max_connections` is a hard limit shared across all application instances
   - Monitor both application-side pool metrics and database-side connection counts

### References

- PostgreSQL Wiki: Number of Database Connections
- Oracle's JDBC Connection Pool Documentation
- HikariCP Configuration Documentation
