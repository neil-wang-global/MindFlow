# Step 2 Design: Circuit Breaker Pattern Implementation

## Task ID
- 20260401-midstep-acq-test

## Design Overview

This document specifies the circuit breaker pattern implementation for microservice communication, based on research acquired in Step 1 (ACQ-001) and half-open timeout best practices acquired in Step 2 (ACQ-002).

## State Machine Specification

### States

| State | Description | Behavior |
|-------|-------------|----------|
| CLOSED | Normal operation | Requests pass through; failures counted within sliding time window |
| OPEN | Failure protection | All requests fail immediately (fail-fast); timeout timer running |
| HALF-OPEN | Recovery testing | Limited trial requests allowed; success/failure determines next state |

### State Transitions

```
                    failure count >= threshold
                    within time window
    [CLOSED] ──────────────────────────────────► [OPEN]
       ▲                                           │
       │  success count >= success threshold       │ timeout expires
       │                                           ▼
       └─────────────────────────────────────── [HALF-OPEN]
                                                   │
                     any trial failure             │
       [OPEN] ◄────────────────────────────────────┘
```

### Transition Rules Table

| From | To | Trigger | Action |
|------|----|---------|--------|
| CLOSED | OPEN | Failure count >= `failureThreshold` within `failureWindow` | Start timeout timer; emit state-change event |
| OPEN | HALF-OPEN | Timeout timer expires | Reset success counter; allow `trialRequestCount` requests; emit state-change event |
| HALF-OPEN | CLOSED | Success count >= `successThreshold` (consecutive) | Reset failure counter; emit state-change event |
| HALF-OPEN | OPEN | Any trial request fails | Restart timeout timer (with optional exponential backoff); emit state-change event |

## Configuration Parameters

### Core Parameters

| Parameter | Type | Default | Range | Description |
|-----------|------|---------|-------|-------------|
| `failureThreshold` | int | 5 | 1-100 | Number of failures within window to trip circuit |
| `failureWindow` | duration | 60s | 1s-600s | Rolling time window for failure counting |
| `timeoutDuration` | duration | 30s | 5s-300s | Duration circuit stays OPEN before transitioning to HALF-OPEN |
| `trialRequestCount` | int | 3 | 1-10 | Number of requests permitted in HALF-OPEN state |
| `successThreshold` | int | 3 | 1-10 | Consecutive successes in HALF-OPEN to transition to CLOSED |
| `timeoutBackoffMultiplier` | float | 1.5 | 1.0-4.0 | Multiplier for increasing timeout on repeated failures |
| `maxTimeoutDuration` | duration | 300s | 30s-3600s | Maximum timeout after backoff |

### Timeout Strategy (from ACQ-002 research)

Based on the acquired research, three timeout strategies are supported:

1. **Fixed timeout**: Circuit stays OPEN for exactly `timeoutDuration` before transitioning to HALF-OPEN. Simplest approach. Best for services with predictable recovery times.

2. **Exponential backoff timeout**: Each time HALF-OPEN transitions back to OPEN (trial failure), the timeout increases by `timeoutBackoffMultiplier`. Example: 30s -> 45s -> 67s -> 101s (capped at `maxTimeoutDuration`). Best for services with variable recovery times. Source: Microsoft Azure Architecture Center — "you can apply an increasing time-out timer to a circuit breaker. You can place the circuit breaker in the Open state for a few seconds initially. If the failure isn't resolved, increase the time-out to a few minutes and adjust accordingly."

3. **Health-check based**: Instead of relying solely on timeouts, the circuit actively probes the downstream service via a health endpoint. Transitions to HALF-OPEN when health check succeeds. Source: Microsoft Azure Architecture Center — "rather than using a timer to determine when to switch to the Half-Open state, a circuit breaker can periodically ping the remote service or resource to determine whether it's available."

### Recommended Defaults by Service Context

| Context | timeoutDuration | trialRequestCount | failureThreshold |
|---------|----------------|-------------------|-----------------|
| Internal microservice | 15-30s | 3 | 5 |
| External API | 30-120s | 1-2 | 3 |
| Database connection | 30-60s | 2 | 5 |
| High-traffic service | 5-15s | 5 | 10 |

## Failure Counting

### Sliding Window Approach
- Use a time-based sliding window (`failureWindow`) rather than a simple counter
- Counter automatically resets at window boundary, preventing false trips from occasional failures
- Only failures within the current window contribute to the threshold check
- Source: Microsoft Azure Architecture Center — "The failure counter for the Closed state is time based. It automatically resets at periodic intervals."

### Exception Classification
- **Transient failures** (timeouts, connection refused): counted toward threshold
- **Non-transient failures** (HTTP 4xx client errors): may be excluded from counting
- **Circuit-open exceptions**: not counted (these are the circuit breaker's own rejections)
- Different failure types may have different weight in the threshold calculation

## Half-Open State Design

### Trial Request Management
- In HALF-OPEN, exactly `trialRequestCount` requests are permitted
- Success counter tracks consecutive successful trial requests
- If success count >= `successThreshold`, transition to CLOSED
- If any single trial request fails, immediately transition back to OPEN
- Source: Microsoft Azure Architecture Center — "The success counter for the Half-Open state records the number of successful attempts to invoke the operation."

### Flood Prevention
- HALF-OPEN limits request volume to protect recovering services
- Only `trialRequestCount` requests pass through; excess requests are rejected as if OPEN
- Source: Microsoft Azure Architecture Center — "The Half-Open state helps prevent a recovering service from suddenly being flooded with requests."

### Timeout Tracking (from ACQ-002)
- AWS approach: store circuit status with ExpiryTimeStamp; expired records indicate service may be available
- Use TTL-based cleanup for automatic expiry management
- Source: AWS Prescriptive Guidance — "The Get Circuit Status step checks service availability based on the ExpiryTimeStamp value."

## Monitoring and Observability

### Required Metrics
- Circuit state (current state of each circuit breaker instance)
- State transition count (per transition type)
- Failure count within window
- Trial request success/failure rate in HALF-OPEN
- Timeout duration (current, including backoff)
- Request rejection rate in OPEN state

### Required Events
- State change events (with timestamp, from-state, to-state, trigger reason)
- Threshold breach events
- Health check results (if health-check based strategy)

### Alerting Recommendations
- Alert when circuit transitions to OPEN (service degradation signal)
- Alert when circuit remains OPEN beyond 2x `maxTimeoutDuration` (recovery failure)
- Alert when circuit "flaps" (rapid CLOSED->OPEN->HALF-OPEN->OPEN cycles)

## Advanced Features

### Manual Override
- Administrative API to force-close or force-open any circuit
- Useful for maintenance windows or known recovery scenarios
- Source: AWS Prescriptive Guidance — "System administrators should have the ability to open or close a circuit."

### Resource Differentiation
- Separate circuit breaker instance per downstream service endpoint
- For sharded resources, separate circuit breaker per shard
- Source: Microsoft Azure Architecture Center — "Be careful when you use a single circuit breaker for one type of resource if there might be multiple underlying independent providers."

### Callee-Initiated Closure
- Extension: downstream service can signal recovery by updating circuit status
- Useful when recovery time objective (RTO) is critical
- Source: AWS Prescriptive Guidance — "When the callee recovers from the performance issue or failure, they can update the circuit status to CLOSED."

## Design Decisions Traceability

| Decision | Source | Rationale |
|----------|--------|-----------|
| Three-state machine (CLOSED/OPEN/HALF-OPEN) | src-001, src-002 (ACQ-001) | Industry standard pattern; both Microsoft and AWS document identical states |
| Time-based sliding window for failure counting | src-001 (ACQ-001) | Prevents false trips from occasional failures |
| Exponential backoff timeout strategy | src-003 (ACQ-002) | Microsoft recommends increasing timeout for persistent failures |
| Health-check based transition alternative | src-003 (ACQ-002) | More responsive than timer-based; Microsoft recommends health endpoint monitoring |
| ExpiryTimeStamp-based circuit status | src-004 (ACQ-002) | AWS demonstrates TTL-based approach for distributed circuit state management |
| Separate breakers per resource/shard | src-001 (ACQ-001) | Microsoft warns against shared breakers for independent providers |
| Manual override capability | src-004 (ACQ-002) | AWS recommends admin ability to force open/close circuits |
