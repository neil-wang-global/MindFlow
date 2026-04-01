# Retry-with-Backoff Library Design

## Overview

A composable retry-with-backoff library that supports multiple evidence-based jitter strategies to prevent thundering herd effects in distributed systems. Designed following the principle of resilience over raw performance, with minimal configuration surface and sensible defaults.

## Design Principles

- **Evidence-based**: all jitter strategies are grounded in AWS Architecture Blog research (Marc Brooker, EC2 team) with simulation-validated performance characteristics
- **Explicit failure handling**: every retry attempt is observable; no silent degradation
- **Operational simplicity**: sensible defaults with full configurability when needed
- **Clear state machine**: retry state transitions are explicit and predictable

## Core Types

### RetryConfig

```
RetryConfig {
  max_retries: int          // Maximum number of retry attempts (default: 3)
  base_delay_ms: int        // Base delay in milliseconds (default: 1000)
  max_delay_ms: int         // Maximum delay cap in milliseconds (default: 30000)
  jitter_strategy: JitterStrategy  // Jitter algorithm to use (default: FullJitter)
  retry_predicate: (error) -> bool  // Function to determine if error is retryable (default: all errors)
}
```

### JitterStrategy (enum)

```
JitterStrategy {
  NoJitter         // Pure exponential backoff (not recommended for production)
  FullJitter       // Recommended default — best spread, lowest completion time
  EqualJitter      // Guaranteed minimum wait with jitter
  DecorrelatedJitter  // State-dependent delays using previous sleep value
}
```

### RetryResult<T>

```
RetryResult<T> {
  Success { value: T, attempts: int }
  Failure { error: Error, attempts: int, last_delay_ms: int }
}
```

## Backoff Algorithms

### Base Exponential Backoff

```
exponential_delay(attempt, base, cap) = min(cap, base * 2 ^ attempt)
```

### Full Jitter

```
delay = random_between(0, min(cap, base * 2 ^ attempt))
```

**Rationale**: Provides the lowest total completion time and fewest total calls in contention scenarios. Fully randomizes the wait from zero to the exponential ceiling, providing maximum spread across retry attempts. Recommended as the default by AWS production engineering.

**Trade-off**: Sleep can be very short (near zero), which may not be desirable if a minimum wait is required.

**Source**: AWS Architecture Blog — "Exponential Backoff And Jitter" (Marc Brooker, src-001)

### Equal Jitter

```
temp = min(cap, base * 2 ^ attempt)
delay = temp / 2 + random_between(0, temp / 2)
```

**Rationale**: Provides a guaranteed minimum wait of half the exponential backoff value while still adding randomness. Performs nearly as well as full jitter in simulations but ensures callers always wait at least some meaningful time.

**Trade-off**: Less spread than full jitter due to the guaranteed floor, but more predictable minimum wait.

**Source**: AWS Architecture Blog — "Exponential Backoff And Jitter" (Marc Brooker, src-001)

### Decorrelated Jitter

```
delay = min(cap, random_between(base, previous_sleep * 3))
```

**Rationale**: Uses the previous sleep value rather than the attempt number, creating a state-dependent (decorrelated) pattern. Each retry's delay depends on the last delay, making the sequence less predictable. Useful when the attempt count is not easily accessible.

**Trade-off**: Requires tracking the previous sleep value as state. Performance is comparable to full jitter in collision scenarios.

**Source**: AWS Architecture Blog — "Exponential Backoff And Jitter" (Marc Brooker, src-001)

## API Surface

### Primary Function: retry_with_backoff

```
retry_with_backoff<T>(
  config: RetryConfig,
  operation: () -> Result<T, Error>
) -> RetryResult<T>
```

Executes `operation`, retrying on failure according to `config`. Returns a `RetryResult` indicating success or final failure with attempt metadata.

### Builder API

```
RetryConfig.builder()
  .max_retries(5)
  .base_delay_ms(500)
  .max_delay_ms(60000)
  .jitter_strategy(JitterStrategy.FullJitter)
  .retry_on(|err| err.is_transient())
  .build()
```

### Convenience Constructors

```
RetryConfig.default()
  // max_retries: 3, base_delay_ms: 1000, max_delay_ms: 30000, jitter: FullJitter

RetryConfig.aggressive()
  // max_retries: 5, base_delay_ms: 500, max_delay_ms: 10000, jitter: FullJitter

RetryConfig.conservative()
  // max_retries: 3, base_delay_ms: 2000, max_delay_ms: 60000, jitter: EqualJitter
```

## State Machine

```
         +-------+
         | Start |
         +---+---+
             |
             v
     +-------+-------+
     | Execute Op    |
     +-------+-------+
             |
        +----+----+
        |         |
     Success   Failure
        |         |
        v         v
   +--------+  +--+--+--+
   | Return |  | Retryable? |
   | Success|  +--+--+--+
   +--------+    |    |
              Yes    No
               |      |
               v      v
          +----+---+ +--------+
          | Check  | | Return |
          | Budget | | Failure|
          +----+---+ +--------+
               |
          +----+----+
          |         |
       Under    Over
       Budget   Budget
          |         |
          v         v
    +-----+---+ +--------+
    | Compute | | Return |
    | Delay   | | Failure|
    +-----+---+ +--------+
          |
          v
    +-----+---+
    | Sleep   |
    +-----+---+
          |
          v
    (back to Execute Op)
```

## Usage Examples

### Example 1: Full Jitter (Default)

```python
config = RetryConfig.default()  # Uses FullJitter

result = retry_with_backoff(config, lambda: http_client.get("/api/resource"))

match result:
    case Success(value, attempts):
        print(f"Succeeded after {attempts} attempt(s)")
    case Failure(error, attempts, last_delay):
        print(f"Failed after {attempts} attempt(s), last delay: {last_delay}ms")
```

### Example 2: Equal Jitter for Database Operations

```python
config = RetryConfig.builder()
    .max_retries(3)
    .base_delay_ms(200)
    .max_delay_ms(5000)
    .jitter_strategy(JitterStrategy.EqualJitter)
    .retry_on(lambda err: isinstance(err, TransientDBError))
    .build()

result = retry_with_backoff(config, lambda: db.execute(query))
```

### Example 3: Decorrelated Jitter for Message Queue Processing

```python
config = RetryConfig.builder()
    .max_retries(5)
    .base_delay_ms(1000)
    .max_delay_ms(30000)
    .jitter_strategy(JitterStrategy.DecorrelatedJitter)
    .build()

result = retry_with_backoff(config, lambda: queue.publish(message))
```

## Jitter Strategy Selection Guide

| Strategy | Best For | Min Delay | Spread | State Required |
|----------|---------|-----------|--------|---------------|
| Full Jitter | General retry (default) | 0 | Maximum | attempt count |
| Equal Jitter | Operations needing minimum wait guarantee | 50% of exp backoff | Good | attempt count |
| Decorrelated Jitter | Stateful retry chains, queue consumers | base | Good | previous sleep value |
| No Jitter | Testing/debugging only | 100% of exp backoff | None | attempt count |

## Integration Considerations

- **Observability**: Every retry attempt should emit a metric (attempt count, delay chosen, jitter strategy used)
- **Circuit Breaker Compatibility**: The retry library should be composable with circuit breakers — when the circuit is open, retries should be suppressed
- **Retry Budgets**: In production, combine with retry budgets (e.g., max 10% of calls can be retries) to prevent aggregate retry storms
- **Idempotency**: Callers must ensure operations are idempotent before enabling retries

## Source Attribution

- Primary source: AWS Architecture Blog — "Exponential Backoff And Jitter" by Marc Brooker (https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/)
- Complementary source: AWS Builders Library — "Timeouts, retries, and backoff with jitter" (https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/)
