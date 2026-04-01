# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001 — jitter strategies for retry-with-backoff library (step-triggered: Step 1)

## Source URL
- https://aws.amazon.com/builders-library/timeouts-retries-and-backoff-with-jitter/

## Fetch Timestamp
- 2026-04-01T10:06:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — AWS Builders Library, official Amazon production engineering guidance

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Timeouts, retries, and backoff with jitter

When a service calls another service, the call can fail for transient reasons — network blips, service overload, or temporary unavailability. To handle these failures gracefully, we use retries. But retries done incorrectly can make problems worse.

## Why simple retries fail

When a server is overloaded, having all clients retry at the same time creates a "thundering herd" that makes the overload worse. Each wave of retries adds more load, potentially preventing recovery entirely.

## Exponential backoff

The first improvement is exponential backoff: instead of retrying immediately, wait progressively longer between each attempt. A common formula is:

```
wait_time = base * 2 ^ attempt_number
```

Where `base` is the initial wait time (e.g., 1 second) and `attempt_number` starts at 0. This gives waits of 1s, 2s, 4s, 8s, etc.

We cap the maximum wait time to prevent excessively long delays:

```
wait_time = min(cap, base * 2 ^ attempt_number)
```

## Adding jitter

Even with exponential backoff, if many clients start retrying at the same time, their retry attempts will still be synchronized. They'll all wait 1 second, then 2 seconds, then 4 seconds — in lockstep.

In practice, we generally use a backoff algorithm called "exponential backoff with full jitter." "Exponential" backoff uses progressively longer waits between retries for consecutive errors. This keeps the client from flooding the server with retries in a short period. "Full jitter" randomizes the backoff. As detailed in our earlier blog post Exponential Backoff and Jitter, this spreads the retries out in time and reduces the chance of clients all retrying at the same time.

The combination of full jitter and backoff preserves the nice, spread-out properties of the backoff but also avoids the situation where all the calls are synchronized on periodic retries.

### Full jitter formula

```
sleep = random_between(0, min(cap, base * 2 ** attempt))
```

## Retry budgets

Beyond jitter, we also use retry budgets — limiting the fraction of calls that can be retries. For example, if our retry budget is 10%, then only 10% of all calls in a given time window can be retries. This prevents retry storms from consuming all available capacity.

## Circuit breakers

Retries and circuit breakers complement each other. While retries handle transient failures, circuit breakers detect persistent failures and stop calling the failing service entirely for a period. When the circuit breaker opens, it prevents wasted retries against a service that is unlikely to recover quickly.

## Best practices for retry with jitter

1. **Always add jitter** to exponential backoff
2. **Set a maximum retry count** to avoid infinite retry loops
3. **Use retry budgets** to limit aggregate retry load
4. **Consider circuit breakers** for persistent failure scenarios
5. **Make retries idempotent** — ensure the operation can safely be retried
6. **Log retries** for observability and debugging
7. **Use full jitter as the default** — it provides the best trade-off between spread and simplicity
