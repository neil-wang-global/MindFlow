# API Rate Limiter Design

## Overview

This document defines the design for an API rate limiter that controls request throughput for distributed services. The design uses the token bucket algorithm as the primary mechanism, grounded in approved knowledge base entries on token bucket mechanics and token-leaky bucket equivalence.

## Design Principles

Per Soul constraints:
- **Resilience over raw performance**: the limiter must degrade gracefully when state is lost or coordination fails, defaulting to a permissive fallback rather than dropping all traffic.
- **Explicit failure handling**: every failure mode (state loss, clock skew, partition) has a defined behavior.
- **Evidence-based design**: algorithm selection is grounded in approved KB entries (kb-concept-token-bucket-mechanism, kb-concept-token-leaky-equivalence).

## Algorithm: Token Bucket

The token bucket algorithm maintains a fixed-capacity bucket of tokens added at a constant rate. Each request consumes one token. If tokens are available, the request proceeds; otherwise it is rate-limited.

**Why token bucket over leaky bucket**: Token bucket and leaky bucket (as meter) are mathematically equivalent, but token bucket is preferred here because:
- It naturally allows burst traffic up to bucket capacity, which matches typical API usage patterns (bursty client behavior)
- Implementation maps cleanly to atomic counter operations in distributed stores
- The "burst then steady" model aligns with Soul's resilience-first approach: short bursts are acceptable if the long-term average rate is maintained

## Configuration Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `rate` | int | 100 | Tokens added per second (sustained request rate) |
| `burst_size` | int | 150 | Maximum bucket capacity (peak burst allowance) |
| `key_strategy` | enum | `per-client-ip` | How to partition rate limits: `per-client-ip`, `per-api-key`, `per-endpoint`, `global` |
| `response_on_limit` | enum | `429-with-retry` | Response when rate limited: `429-with-retry` (includes Retry-After header), `429-immediate`, `queue` |
| `fallback_mode` | enum | `allow` | Behavior when limiter state is unavailable: `allow` (fail-open), `deny` (fail-closed) |

## Architecture

```
Client Request
    |
    v
[Rate Limiter Middleware]
    |
    +-- Check token availability (atomic decrement)
    |       |
    |       +-- Tokens available → forward request
    |       +-- No tokens → return 429 with Retry-After header
    |
    +-- On state store failure → apply fallback_mode
```

### Distributed State

Rate limit counters are stored in a shared state store (e.g., Redis) using atomic operations:
- **Key format**: `ratelimit:{key_strategy_value}:{window_id}`
- **Token replenishment**: calculated lazily on each request using elapsed time since last check (avoids need for background token-add process)
- **Expiry**: keys expire after `burst_size / rate` seconds of inactivity to prevent unbounded storage growth

### Lazy Token Calculation

Rather than a background process adding tokens, the limiter calculates available tokens on each request:

```
elapsed = now - last_check_time
new_tokens = elapsed * rate
available = min(stored_tokens + new_tokens, burst_size)
```

This approach eliminates the need for a timer process and reduces coordination overhead.

## Failure Modes

| Failure | Detection | Response | Soul Alignment |
|---------|-----------|----------|----------------|
| State store unavailable | Connection timeout (100ms) | Apply `fallback_mode` (default: allow) | Resilience: graceful degradation, no silent drops |
| Clock skew between nodes | Tokens calculated as negative | Clamp to 0, log warning | Explicit failure handling: visible anomaly |
| Network partition | Store unreachable from some nodes | Each node falls back independently | Resilience: independent degradation per node |
| Counter overflow | Token count exceeds burst_size | Clamp to burst_size | Explicit handling: bounded state |
| Key collision | Hash collision in key_strategy | Shared limit between colliding keys (acceptable degradation) | Operational simplicity: no complex disambiguation |

## Operational Monitoring

### Metrics
- `ratelimit.requests.total` — total requests checked
- `ratelimit.requests.limited` — requests that received 429
- `ratelimit.requests.allowed` — requests that passed
- `ratelimit.fallback.activated` — fallback mode activations (state store failure)
- `ratelimit.tokens.available` — current token level (gauge, sampled)

### Alerts
- `ratelimit.fallback.activated > 0` for > 30s: state store health issue
- `ratelimit.requests.limited / ratelimit.requests.total > 0.5`: sustained high rate limiting (potential misconfiguration or attack)

## Integration Points

The rate limiter operates as middleware, inserted before business logic handlers:
1. API gateway layer (edge rate limiting for DDoS protection)
2. Service-level middleware (per-service rate limiting for resource protection)
3. Both layers can operate independently with different configurations

## Knowledge Sources

- kb-concept-token-bucket-mechanism: algorithm fundamentals and burst behavior
- kb-concept-token-leaky-equivalence: algorithm selection rationale (token bucket chosen over equivalent leaky bucket for implementation simplicity)
