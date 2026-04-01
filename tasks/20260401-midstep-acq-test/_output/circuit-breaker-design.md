# Circuit Breaker Pattern Design for Microservice Communication

## Executive Summary

This document presents a circuit breaker pattern design for microservice communication that prevents cascading failures by detecting downstream service degradation and temporarily halting requests until recovery is detected. The design is grounded in externally acquired and independently verified research from Microsoft Azure Architecture Center and AWS Prescriptive Guidance.

## Problem Statement

In a microservice architecture, services communicate via remote procedure calls. When a downstream service becomes unavailable or exhibits high latency, the calling service may exhaust its own resources (threads, connections, memory) waiting for responses. Without protection, this leads to cascading failures across the system. The circuit breaker pattern addresses this by acting as a proxy that monitors failures and provides fail-fast behavior when a downstream service is degraded.

## Circuit Breaker State Machine

The circuit breaker operates as a three-state finite state machine:

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

### State Descriptions

| State | Description | Behavior |
|-------|-------------|----------|
| CLOSED | Normal operation | Requests pass through to downstream service. Failures are counted within a sliding time window. When failures exceed the configured threshold, the circuit transitions to OPEN. |
| OPEN | Failure protection | All requests fail immediately (fail-fast) without contacting the downstream service. A timeout timer runs. When the timer expires, the circuit transitions to HALF-OPEN. Optionally returns cached/default values instead of errors. |
| HALF-OPEN | Recovery testing | A limited number of trial requests are permitted. A success counter tracks consecutive successes. If the success threshold is met, the circuit transitions to CLOSED. If any trial fails, the circuit immediately reverts to OPEN. |

### Transition Rules

| From | To | Trigger | Action |
|------|----|---------|--------|
| CLOSED | OPEN | Failure count >= `failureThreshold` within `failureWindow` | Start timeout timer; emit state-change event; begin rejecting requests |
| OPEN | HALF-OPEN | Timeout timer expires | Reset success counter; allow `trialRequestCount` requests through; emit event |
| HALF-OPEN | CLOSED | Success count >= `successThreshold` (consecutive) | Reset failure counter; resume normal operation; emit event |
| HALF-OPEN | OPEN | Any trial request fails | Restart timeout timer (with optional backoff); emit event |

## Configuration Parameters

### Core Parameters

| Parameter | Default | Range | Description |
|-----------|---------|-------|-------------|
| `failureThreshold` | 5 | 1-100 | Failures within window to trip circuit |
| `failureWindow` | 60s | 1s-600s | Rolling time window for failure counting |
| `timeoutDuration` | 30s | 5s-300s | Duration in OPEN before transitioning to HALF-OPEN |
| `trialRequestCount` | 3 | 1-10 | Requests permitted in HALF-OPEN |
| `successThreshold` | 3 | 1-10 | Consecutive successes to transition HALF-OPEN to CLOSED |
| `timeoutBackoffMultiplier` | 1.5 | 1.0-4.0 | Multiplier for exponential backoff on repeated failures |
| `maxTimeoutDuration` | 300s | 30s-3600s | Maximum timeout after backoff |

### Context-Specific Recommendations

| Service Context | timeoutDuration | trialRequestCount | failureThreshold |
|-----------------|----------------|-------------------|-----------------|
| Internal microservice | 15-30s | 3 | 5 |
| External API | 30-120s | 1-2 | 3 |
| Database connection | 30-60s | 2 | 5 |
| High-traffic service | 5-15s | 5 | 10 |

## Timeout Strategies

Three timeout strategies are supported for the OPEN-to-HALF-OPEN transition:

### 1. Fixed Timeout
The circuit stays OPEN for exactly `timeoutDuration` before transitioning to HALF-OPEN. Best for services with predictable recovery times.

### 2. Exponential Backoff Timeout
Each time HALF-OPEN transitions back to OPEN (trial failure), the timeout increases by `timeoutBackoffMultiplier`, capped at `maxTimeoutDuration`. Example progression: 30s, 45s, 67s, 101s, 151s, 227s, 300s (cap). Best for services with variable recovery times. Based on Microsoft guidance: "you can apply an increasing time-out timer to a circuit breaker."

### 3. Health-Check Based
Instead of relying solely on timers, the circuit actively probes the downstream service via a dedicated health endpoint. Transitions to HALF-OPEN when the health check succeeds. Most responsive approach. Based on Microsoft guidance: "rather than using a timer to determine when to switch to the Half-Open state, a circuit breaker can periodically ping the remote service or resource."

## Failure Counting

### Sliding Window
- Time-based sliding window (`failureWindow`) prevents false trips from occasional failures
- Counter resets at window boundary automatically
- Only failures within the current window count toward the threshold
- Based on: "The failure counter for the Closed state is time based. It automatically resets at periodic intervals." (src-001)

### Exception Classification
- **Transient** (timeouts, connection refused): counted toward threshold
- **Non-transient** (HTTP 4xx): optionally excluded
- **Circuit-open rejections**: never counted

## Monitoring and Alerting

### Required Metrics
- Circuit state per instance (CLOSED/OPEN/HALF-OPEN)
- State transition count by transition type
- Failure count within current window
- Trial request success/failure rate in HALF-OPEN
- Current timeout duration (including backoff)
- Request rejection rate in OPEN

### Alerting Rules
- Alert when circuit transitions to OPEN (service degradation)
- Alert when circuit remains OPEN beyond 2x `maxTimeoutDuration` (recovery failure)
- Alert on circuit "flapping" (rapid state oscillation)

## Advanced Features

### Manual Override
Administrative API to force-close or force-open any circuit breaker instance. Essential for maintenance windows and known recovery scenarios.

### Resource Differentiation
Separate circuit breaker instance per downstream service endpoint. For sharded resources, separate circuit breaker per shard to prevent false positives affecting healthy shards.

### Callee-Initiated Closure
Extension allowing downstream services to signal recovery by updating circuit status directly. Useful when RTO requirements are strict.

### Fallback Strategies
When circuit is OPEN, instead of returning errors:
- Return cached responses from the last successful call
- Return default values meaningful to the application
- Invoke an alternative service or degraded functionality path

## References

All design decisions are traceable to independently verified external sources:

| Source | URL | Coverage |
|--------|-----|----------|
| Microsoft Azure Architecture Center | https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker | Core pattern definition, states, transitions, implementation considerations, timeout strategies, monitoring |
| AWS Prescriptive Guidance | https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/circuit-breaker.html | Pattern motivation, implementation with AWS services, ExpiryTimeStamp approach, manual override, callee-initiated closure |

The circuit breaker pattern was originally popularized by Michael Nygard in "Release It!" (2018).
