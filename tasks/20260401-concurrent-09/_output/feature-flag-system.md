# Feature Flag System Design

## Overview

This document describes the architecture of a feature flag system for managing feature toggles in a distributed service architecture. The design applies the four-category toggle taxonomy (release, experiment, ops, permission) to inform lifecycle management, storage, and evaluation strategies.

## Toggle Categorization

Feature toggles are categorized into four types based on their purpose, longevity, and dynamism. Each category has distinct lifecycle management requirements.

### Release Toggles

- **Purpose**: Decouple deployment from release. Allow incomplete or untested code paths to ship as latent code.
- **Longevity**: Short-lived (days to weeks). Must be retired once the feature is fully released.
- **Dynamism**: Static per deployment. Typically a global on/off switch.
- **Evaluation Context**: No user context needed. Binary global state.
- **Retirement Policy**: Mandatory expiration date. Flagged for removal after 2 sprint cycles post-release.
- **Example**: `flag.new-checkout-flow.enabled = false` until feature is ready for all users.

### Experiment Toggles

- **Purpose**: A/B testing and multivariate experiments. Route users to different code paths based on cohort assignment.
- **Longevity**: Short to medium-lived (until statistically significant results are gathered).
- **Dynamism**: Highly dynamic. Per-user or per-session evaluation.
- **Evaluation Context**: Requires user ID, session ID, and cohort assignment. Must be deterministic for the same user.
- **Retirement Policy**: Removed after experiment concludes and winning variant is selected.
- **Example**: `flag.search-ranking-v2.cohort(user_id) -> variant_A | variant_B`

### Ops Toggles

- **Purpose**: Control operational aspects of system behavior. Act as kill switches for features with uncertain performance implications.
- **Longevity**: Can be long-lived (permanent circuit breakers).
- **Dynamism**: Dynamic. Must support real-time toggling for incident response.
- **Evaluation Context**: May consider system load, error rates, or manual operator input.
- **Retirement Policy**: Long-lived ops toggles are reviewed quarterly. Kill switches may be permanent.
- **Example**: `flag.recommendation-engine.kill-switch = false` (can be flipped to true during peak load).

### Permission Toggles

- **Purpose**: Gate features for specific user segments. Control premium features, beta access, or internal dogfooding.
- **Longevity**: Long-lived (potentially permanent for tier-based features).
- **Dynamism**: Per-user or per-group. Changes when user permissions change.
- **Evaluation Context**: Requires user ID, subscription tier, group membership, or role.
- **Retirement Policy**: Retained as long as the gating logic is needed. Reviewed when pricing/access model changes.
- **Example**: `flag.advanced-analytics.allowed(user) -> user.tier == "premium"`

## System Architecture

### Components

```
+-------------------+     +-------------------+     +-------------------+
|   Flag Admin UI   |---->|   Flag Service    |---->|   Flag Store      |
|                   |     |   (API Gateway)   |     |   (Source of      |
|   - Create/edit   |     |   - CRUD API      |     |    Truth)         |
|   - Audit trail   |     |   - Validation    |     |   - PostgreSQL    |
|   - Targeting     |     |   - Webhooks      |     |   - Redis cache   |
+-------------------+     +-------------------+     +-------------------+
                                  |
                    +-------------+-------------+
                    |                           |
           +----------------+          +----------------+
           | SDK (Server)   |          | SDK (Client)   |
           | - Local cache  |          | - Polling       |
           | - Stream sync  |          | - SSE/WS sync   |
           | - Fallback     |          | - Fallback      |
           +----------------+          +----------------+
```

### Flag Store

- **Primary**: PostgreSQL for durable flag configuration, targeting rules, and audit history.
- **Cache Layer**: Redis for low-latency flag evaluation. Updated via change-data-capture from PostgreSQL.
- **Consistency Model**: Eventual consistency between PostgreSQL and Redis. Flags converge within 1 second. For ops toggles requiring immediate propagation, a direct invalidation path is provided.

### Flag Evaluation Engine

The evaluation engine resolves a flag value for a given context (user, environment, system state).

**Evaluation Order** (per flag):
1. Check if flag exists and is active
2. Determine flag category (release/experiment/ops/permission)
3. Apply category-specific evaluation:
   - **Release**: return global boolean value
   - **Experiment**: hash user_id + flag_key to deterministic cohort, return variant
   - **Ops**: check system state / manual override, return boolean
   - **Permission**: evaluate targeting rules against user attributes, return boolean
4. If evaluation fails at any step, return the flag's configured default value (fail-closed for ops toggles, fail-open for release toggles)

**Fallback Strategy** (aligned with Soul value: explicit failure handling):
- Every flag must define a default value
- SDK maintains a local cache of last-known flag values
- If Flag Service is unreachable, SDK evaluates from local cache
- If local cache is empty (cold start), SDK uses hardcoded defaults from application configuration

### Flag Propagation

- **Server SDKs**: Maintain a persistent streaming connection (SSE or gRPC stream) to Flag Service. Receive flag change events in real-time. Local cache is updated incrementally.
- **Client SDKs**: Poll Flag Service at configurable intervals (default: 30 seconds). Support SSE upgrade for near-real-time propagation when available.
- **Change Notification**: Flag Service emits webhook events on flag changes. Downstream services can subscribe for cache invalidation.

## Lifecycle Management

### Category-Driven Policies

| Category | Max Lifetime | Review Cadence | Auto-Expire | Retirement Alert |
|----------|-------------|----------------|-------------|-----------------|
| Release | 4 weeks | Every sprint | Yes | 2 weeks before expiry |
| Experiment | 8 weeks | At experiment review | Yes | When significance reached |
| Ops | Indefinite | Quarterly | No | Annual review |
| Permission | Indefinite | When access model changes | No | On pricing change |

### Flag Hygiene

- **Toggle Debt Tracking**: Dashboard showing flag count by category, age, and last-evaluated timestamp.
- **Stale Flag Detection**: Flags not evaluated in 30 days are flagged for review.
- **Mandatory Retirement**: Release and experiment toggles exceeding their max lifetime generate alerts and are auto-disabled (not deleted) after a grace period.

## Operational Considerations

### Monitoring and Observability

- **Flag evaluation metrics**: Count, latency, and error rate per flag per service.
- **Targeting metrics**: Cohort distribution for experiment toggles.
- **Cache health**: Hit rate, sync lag, and stale entry count.
- **Alerting**: Alert on flag evaluation errors exceeding threshold, cache sync lag exceeding 5 seconds, and ops toggle state changes.

### Audit Trail

- All flag changes (create, update, delete, toggle) are recorded with: who, when, what changed, and why (mandatory change reason field).
- Audit log is append-only and immutable.
- Supports compliance requirements for permission toggles (who granted/revoked access).

### Security

- Flag Admin UI requires authentication and role-based access control.
- Ops toggle changes require elevated permissions (SRE/on-call role).
- SDKs authenticate with API keys scoped to environment (dev/staging/prod).
- Flag values for permission toggles are not exposed to client SDKs to prevent enumeration attacks.

## Design Rationale

This design reflects the Soul values:
- **Resilience over raw performance**: Multi-layer fallback (service -> cache -> local cache -> defaults) ensures flag evaluation never fails completely.
- **Evidence-based design**: Toggle categorization based on the established Fowler/Hodgson taxonomy.
- **Explicit failure handling**: Every evaluation path has a defined fallback. Ops toggles fail-closed by default.
- **Operational simplicity**: Category-driven lifecycle policies reduce manual flag management overhead.

## Limitations

- ACQ-001 was exhausted (sources could not be fetched). The toggle categorization used in this design is based on the task statement and general knowledge of the Fowler/Hodgson taxonomy rather than verified primary sources. The categorization should be validated against the primary source in a future task.
