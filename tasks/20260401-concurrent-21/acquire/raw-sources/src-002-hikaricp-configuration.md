# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://github.com/brettwooldridge/HikariCP#configuration-knobs-baby

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official HikariCP project README on GitHub, maintained by the project author

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output limit — full README is very large; configuration section was captured

## Original Content

# HikariCP Configuration (knobs, baby!)

## Essentials

### `dataSourceClassName`
This is the name of the `DataSource` class provided by the JDBC driver.

### `jdbcUrl`
This property directs HikariCP to use "DriverManager-based" configuration.

### `username` / `password`
Authentication credentials for the underlying driver.

## Frequently Used

### `connectionTimeout`
This property controls the maximum number of milliseconds that a client will wait for a connection from the pool. If this time is exceeded without a connection becoming available, a `SQLException` will be thrown. Lowest acceptable connection timeout is 250 ms. Default: 30000 (30 seconds).

### `idleTimeout`
This property controls the maximum amount of time that a connection is allowed to sit idle in the pool. This setting only applies when `minimumIdle` is defined to be less than `maximumPoolSize`. Idle connections will not be retired once the pool reaches `minimumIdle` connections. Whether a connection is retired as idle or not is subject to a maximum variation of +30 seconds, and average variation of +15 seconds. A connection will never be retired as idle before this timeout. A value of 0 means that idle connections are never removed from the pool. The minimum allowed value is 10000ms (10 seconds). Default: 600000 (10 minutes).

### `maxLifetime`
This property controls the maximum lifetime of a connection in the pool. An in-use connection will never be retired, only when it is closed will it then be removed. On a connection-by-connection basis, minor negative attenuation is applied to avoid mass-extinction in the pool. We strongly recommend setting this value, and it should be several seconds shorter than any database or infrastructure imposed connection time limit. A value of 0 indicates no maximum lifetime (infinite lifetime), subject of course to the `idleTimeout` setting. The minimum allowed value is 30000ms (30 seconds). Default: 1800000 (30 minutes).

### `maximumPoolSize`
This property controls the maximum size that the pool is allowed to reach, including both idle and in-use connections. Basically this value will determine the maximum number of actual connections to the database backend. A reasonable value for this is best determined by your execution environment. When the pool reaches this size, and no idle connections are available, calls to getConnection() will block for up to `connectionTimeout` milliseconds before timing out. Please read about pool sizing. Default: 10.

### `minimumIdle`
This property controls the minimum number of idle connections that HikariCP tries to maintain in the pool. If the idle connections dip below this value and total connections in the pool are less than `maximumPoolSize`, HikariCP will make a best effort to add additional connections quickly and efficiently. However, for maximum performance and responsiveness to spike demands, we recommend not setting this value and instead allowing HikariCP to act as a fixed size connection pool. Default: same as `maximumPoolSize`.

## Infrequently Used

### `connectionTestQuery`
If your driver supports JDBC4 we strongly recommend not setting this property. This is for "legacy" drivers that do not support the JDBC4 `Connection.isValid()` API.

### `leakDetectionThreshold`
This property controls the amount of time that a connection can be out of the pool before a message is logged indicating a possible connection leak. A value of 0 means leak detection is disabled. Lowest acceptable value for enabling leak detection is 2000 (2 seconds). Default: 0.

### `poolName`
This property represents a user-defined name for the connection pool and appears mainly in logging and JMX management consoles to identify pools and pool configurations.

### `registerMbeans`
This property controls whether the pool registers HikariCP MXBeans (`HikariPoolMXBean` and `HikariConfigMXBean`) in JMX. Default: false.

### Metrics

HikariCP supports metrics collection through Micrometer or Dropwizard Metrics. The following metrics are collected:

- `hikaricp.connections` — total connections (active + idle)
- `hikaricp.connections.active` — currently active connections
- `hikaricp.connections.idle` — currently idle connections
- `hikaricp.connections.pending` — threads waiting for connections
- `hikaricp.connections.creation` — connection creation time histogram
- `hikaricp.connections.acquire` — connection acquire time histogram
- `hikaricp.connections.usage` — connection usage duration histogram
- `hikaricp.connections.timeout` — connection timeout counter
- `hikaricp.connections.max` — maximum pool size
- `hikaricp.connections.min` — minimum idle connections

These metrics can be used to detect pool exhaustion, connection leaks, and sizing issues.
