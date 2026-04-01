# Canary Deployment Checker Design

## Task ID
- 20260401-concurrent-13

## Overview

This document defines the design of a canary deployment checker — a system component that evaluates the health of a canary deployment by comparing canary metrics against baseline metrics and making promote/rollback/extend decisions based on configurable thresholds.

The design draws on the four golden signals framework (latency, traffic, errors, saturation) and adapts circuit breaker state transition patterns (from approved knowledge) to model canary analysis decision logic.

## Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────────┐
│   Metrics    │────>│   Canary     │────>│   Decision      │
│   Collector  │     │   Analyzer   │     │   Engine        │
└─────────────┘     └──────────────┘     └─────────────────┘
       │                    │                      │
       │                    │                      ▼
       │                    │              ┌───────────────┐
       │                    │              │   Action       │
       │                    │              │   Executor     │
       │                    │              └───────────────┘
       ▼                    ▼                      │
┌─────────────┐     ┌──────────────┐              ▼
│  Prometheus  │     │  Analysis    │     ┌───────────────┐
│  / Datadog   │     │  Store       │     │  promote /    │
└─────────────┘     └──────────────┘     │  rollback /   │
                                         │  extend       │
                                         └───────────────┘
```

## 1. Metrics Definition

### 1.1 Primary Metrics (Required)

| Metric | Type | Query Pattern | Description |
|--------|------|---------------|-------------|
| Error Rate | ratio | `sum(rate(http_5xx{canary}[interval])) / sum(rate(http_total{canary}[interval]))` | Fraction of 5xx responses in canary traffic |
| Latency p50 | histogram | `histogram_quantile(0.50, sum(rate(http_duration_bucket{canary}[interval])) by (le))` | Median response time |
| Latency p95 | histogram | `histogram_quantile(0.95, sum(rate(http_duration_bucket{canary}[interval])) by (le))` | 95th percentile response time |
| Latency p99 | histogram | `histogram_quantile(0.99, sum(rate(http_duration_bucket{canary}[interval])) by (le))` | 99th percentile response time |

### 1.2 Secondary Metrics (Recommended)

| Metric | Type | Description |
|--------|------|-------------|
| Saturation (CPU) | gauge | CPU utilization of canary pods |
| Saturation (Memory) | gauge | Memory utilization of canary pods |
| Request Volume | counter | Total request throughput to canary |
| Custom Business Metric | varies | Application-specific success metric (e.g., conversion rate, checkout success) |

### 1.3 Metric Collection Requirements
- Sampling interval: 30s (default), configurable per deployment
- Minimum sample count before analysis: 100 requests (prevents noisy small-sample decisions)
- Metric alignment: canary and baseline metrics must use identical query windows

## 2. Threshold Configuration

### 2.1 Error Rate Thresholds

```yaml
error_rate:
  mode: relative          # relative | absolute
  max_delta: 0.01         # canary error rate must not exceed baseline by more than 1%
  absolute_max: 0.05      # hard ceiling: 5% error rate regardless of baseline
  warmup_requests: 100    # minimum requests before evaluation
```

**Mode: relative** — compares canary error rate against baseline error rate. Triggers if `canary_rate - baseline_rate > max_delta`.

**Mode: absolute** — triggers if canary error rate exceeds `absolute_max` regardless of baseline.

Both modes apply simultaneously: the stricter threshold wins.

### 2.2 Latency Thresholds

```yaml
latency:
  p50:
    max_regression_pct: 10    # p50 must not regress more than 10% vs baseline
    absolute_max_ms: 200      # hard ceiling for p50
  p95:
    max_regression_pct: 15    # p95 must not regress more than 15% vs baseline
    absolute_max_ms: 800      # hard ceiling for p95
  p99:
    max_regression_pct: 20    # p99 must not regress more than 20% vs baseline
    absolute_max_ms: 2000     # hard ceiling for p99
```

Regression percentage is calculated as: `(canary_pNN - baseline_pNN) / baseline_pNN * 100`

### 2.3 Saturation Thresholds

```yaml
saturation:
  cpu_max_pct: 80             # CPU must not exceed 80%
  memory_max_pct: 85          # Memory must not exceed 85%
```

## 3. Decision Logic

### 3.1 State Machine

The canary checker operates as a three-state machine, analogous to the circuit breaker pattern (Closed/Open/Half-Open maps to Analyzing/Failed/Extending):

```
                    ┌──────────────┐
         start ───> │  ANALYZING   │
                    └──────┬───────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
       ┌──────────┐  ┌──────────┐  ┌──────────┐
       │  PASSED   │  │  FAILED  │  │ EXTENDING│
       └──────────┘  └──────────┘  └────┬─────┘
              │            │            │
              ▼            ▼            ▼
          PROMOTE      ROLLBACK    re-enter
                                  ANALYZING
                                  (with extended
                                   bake time)
```

**State: ANALYZING**
- Active metric collection and comparison running
- Duration: `bake_time` (configurable, default 60s per traffic step)
- Transitions:
  - All metrics pass all thresholds → PASSED
  - Any metric fails hard threshold → FAILED
  - Inconclusive (marginal results, insufficient samples) → EXTENDING

**State: PASSED**
- All metrics within acceptable ranges for the full bake time
- Action: advance to next traffic step or PROMOTE if at final step

**State: FAILED**
- One or more metrics exceeded thresholds
- Action: ROLLBACK immediately

**State: EXTENDING**
- Metrics are marginal or sample count insufficient
- Bake time is extended using exponential backoff (informed by circuit breaker timeout pattern)
- Extension schedule: `bake_time * 2^(extension_count)`, capped at `max_bake_time`
- Max extensions: 3 (configurable)
- After max extensions: decision defaults to FAILED → ROLLBACK

### 3.2 Analysis Scoring

Each metric produces a score:
- **Pass (1.0)**: metric is within threshold
- **Marginal (0.5)**: metric is within 2x the threshold (e.g., delta is 0.8% when threshold is 1%)
- **Fail (0.0)**: metric exceeds threshold

Overall score = weighted average of all metric scores:

```yaml
weights:
  error_rate: 0.40
  latency_p99: 0.25
  latency_p95: 0.15
  latency_p50: 0.10
  saturation: 0.10
```

Decision mapping:
- Score >= 0.80 → PASSED
- Score >= 0.50 and < 0.80 → EXTENDING (inconclusive)
- Score < 0.50 → FAILED

### 3.3 Progressive Traffic Steps

```yaml
traffic_steps:
  - weight: 1      # 1% canary traffic
    bake_time: 60s
  - weight: 5      # 5% canary traffic
    bake_time: 120s
  - weight: 25     # 25% canary traffic
    bake_time: 300s
  - weight: 50     # 50% canary traffic
    bake_time: 600s
  - weight: 100    # full promotion
    bake_time: 0s   # no bake at 100%; already promoted
```

## 4. Rollback Triggers

### 4.1 Automatic Rollback
Triggered immediately (no bake time wait) when:
- Error rate exceeds `absolute_max` (hard ceiling breach)
- Any latency percentile exceeds its `absolute_max_ms`
- Analysis score drops below 0.50 at any point during bake
- Max extensions exhausted with inconclusive results

### 4.2 Graduated Rollback
When rollback is triggered at traffic_step > 25%:
1. Reduce traffic to previous step (not directly to 0%)
2. Re-analyze at reduced traffic for one bake period
3. If metrics recover: hold at reduced traffic, alert operator
4. If metrics do not recover: full rollback to 0% canary traffic

### 4.3 Manual Override
- Operator can force promote or force rollback at any time
- Manual actions are logged with operator identity and reason
- Manual rollback bypasses graduated rollback (immediate full rollback)

## 5. Configuration Example

```yaml
apiVersion: canary.checker/v1
kind: CanaryAnalysis
metadata:
  name: my-service-canary
spec:
  target:
    service: my-service
    namespace: production
  metrics:
    provider: prometheus
    address: http://prometheus:9090
    interval: 30s
  thresholds:
    error_rate:
      mode: relative
      max_delta: 0.01
      absolute_max: 0.05
      warmup_requests: 100
    latency:
      p50: { max_regression_pct: 10, absolute_max_ms: 200 }
      p95: { max_regression_pct: 15, absolute_max_ms: 800 }
      p99: { max_regression_pct: 20, absolute_max_ms: 2000 }
    saturation:
      cpu_max_pct: 80
      memory_max_pct: 85
  scoring:
    weights:
      error_rate: 0.40
      latency_p99: 0.25
      latency_p95: 0.15
      latency_p50: 0.10
      saturation: 0.10
    pass_threshold: 0.80
    marginal_threshold: 0.50
  traffic:
    steps: [1, 5, 25, 50, 100]
    bake_times: [60s, 120s, 300s, 600s, 0s]
  rollback:
    graduated: true
    max_extensions: 3
  notifications:
    slack_channel: "#deployments"
    on_events: [rollback, promote, extend]
```

## 6. Design Rationale

### Circuit Breaker Analogy
The three-state decision machine (Analyzing/Passed/Failed) mirrors the circuit breaker pattern's Closed/Half-Open/Open states. This is deliberate:
- Both patterns monitor failure rates against thresholds
- Both use time-based transitions (bake time ~ circuit breaker timeout)
- The EXTENDING state with exponential backoff directly applies the circuit breaker timeout escalation strategy (per approved knowledge kb-concept-circuit-breaker-timeout.md)

### Data-Driven Defaults
Per Soul values (data-driven, evidence-based design):
- Default thresholds are conservative (1% error delta, 10-20% latency regression)
- All thresholds are configurable per deployment
- Scoring weights prioritize error rate (0.40) over latency (0.50 combined) over saturation (0.10)

### Explicit Failure Handling
Per Soul taboos (never ignore failure modes):
- Hard ceilings exist for every metric (absolute_max values)
- Extension has a maximum count (prevents infinite indecision)
- Graduated rollback prevents abrupt traffic shifts that could cause cascading failures
