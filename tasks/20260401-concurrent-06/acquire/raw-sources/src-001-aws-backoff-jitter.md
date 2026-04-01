# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001 — jitter strategies for retry-with-backoff library (step-triggered: Step 1)

## Source URL
- https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/

## Fetch Timestamp
- 2026-04-01T10:05:00Z

## Source Type
- Blog Post

## Credibility Assessment
- High — authored by Marc Brooker, Senior Engineer on AWS EC2 team; published on official AWS Architecture Blog

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Exponential Backoff And Jitter

This is a guest post by Marc Brooker, a Senior Engineer on the EC2 team.

Retries are a critical part of building reliable distributed systems. When a call to a remote service fails, the caller must decide how long to wait before retrying. The simplest approach is an immediate retry, but this can overwhelm the callee, especially if many callers fail simultaneously. This problem is known as the "thundering herd."

## The Problem with Simple Backoff

The standard solution is exponential backoff:

```
sleep = min(cap, base * 2 ** attempt)
```

This is good, but not great. The problem is that when multiple callers start at the same time, they will all retry at exactly the same times: 1 second, 2 seconds, 4 seconds, etc. They are correlated.

## Adding Jitter

The solution is to add randomness — "jitter" — to the backoff time. We tested three jitter approaches:

### Full Jitter

```
sleep = random_between(0, min(cap, base * 2 ** attempt))
```

Full Jitter randomizes the entire backoff value from zero to the exponential ceiling. This gives the best spread across retry attempts.

### Equal Jitter

```
temp = min(cap, base * 2 ** attempt)
sleep = temp / 2 + random_between(0, temp / 2)
```

Equal Jitter takes half of the exponential backoff as a guaranteed minimum, then adds a random component for the other half. This provides a floor that ensures callers always wait at least some time.

### Decorrelated Jitter

```
sleep = min(cap, random_between(base, sleep * 3))
```

Decorrelated Jitter is different from the other two: instead of using the attempt number to determine the exponential ceiling, it uses the previous sleep value. Each retry's delay depends on the last delay, creating a more decorrelated pattern.

## Simulation Results

We simulated the behavior with all approaches and looked at the average completion time. In each case, we assumed that requests that don't collide with each other always succeed on every retry.

The results show that adding any jitter is a significant improvement over pure exponential backoff. Among the jitter approaches:

- **Full Jitter** provides the lowest total completion time and the fewest total calls. It has the best spread across time.
- **Equal Jitter** performs nearly as well but provides a guaranteed minimum wait, which may be desirable in some scenarios.
- **Decorrelated Jitter** also performs well and has the advantage of not requiring the attempt number — only the previous sleep time.

## Contention vs. Collision

The results vary depending on whether the workload is contention-based (many callers competing for the same resource) or collision-based (callers that must not overlap).

For contention: Full Jitter provides the best results, reducing both total calls and completion time.

For collision: Decorrelated Jitter performs comparably to Full Jitter.

## Recommendation

We recommend adding jitter to all retry and backoff logic. Full Jitter is a good default. The key insight is that without jitter, even exponential backoff can cause thundering herd problems when many callers start at the same time.

The choice between Full, Equal, and Decorrelated Jitter depends on your specific requirements:
- Use **Full Jitter** when you want the best spread and don't need a guaranteed minimum wait
- Use **Equal Jitter** when you need a minimum wait guarantee while still spreading retries
- Use **Decorrelated Jitter** when you want state-dependent delays or don't have easy access to the attempt count
