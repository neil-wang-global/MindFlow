# Progressive Delivery Metrics Research Notes

## Task ID
- 20260401-concurrent-13

## ACQ Status
- ACQ-001: exhausted — required fetch tools unavailable
- No externally grounded sources available for citation
- Research notes below are synthesized from existing approved knowledge (circuit breaker patterns) and general domain understanding; not from verified external sources

## Progressive Delivery Metrics Framework

### The Four Golden Signals (SRE Foundation)
Canary analysis is typically built on the four golden signals from Google SRE:
1. **Latency** — time to service a request (distinguish successful vs failed)
2. **Traffic** — demand volume (requests per second)
3. **Errors** — rate of failed requests
4. **Saturation** — resource fullness (CPU, memory, I/O)

### Canary-Specific Metrics

#### Error Rate
- Measure: ratio of 5xx responses to total responses for canary vs baseline
- Common threshold: canary error rate must not exceed baseline by more than 1-5% delta
- Calculation: `sum(rate(http_5xx[interval])) / sum(rate(http_total[interval]))`

#### Latency Percentiles
- p50 (median): typical user experience
- p95: catches most outliers
- p99: extreme tail latency
- Comparison method: canary percentile vs baseline percentile; regression detected if canary exceeds baseline by configurable margin (e.g., 10-20%)

#### Canary Analysis Decision Methods
- Statistical comparison: Mann-Whitney U test, t-tests comparing canary and baseline metric distributions
- Scoring: tools like Kayenta (Netflix/Google) produce a score 0-100; thresholds define pass/marginal/fail
- Error budget consumption: rollback if deployment burns error budget faster than expected

### Progressive Traffic Shifting
- Typical progression: 1% -> 5% -> 25% -> 50% -> 100%
- Each step gated by metric analysis passing all thresholds
- Bake time at each step allows signal accumulation for statistical significance

### Rollback Triggers
- Automatic: error rate exceeds threshold, latency regression detected, SLO breach
- Manual: operator-initiated based on business metrics or external signals

## Relationship to Circuit Breaker Knowledge
- Circuit breaker state transitions (Closed -> Open -> Half-Open) parallel canary promote/rollback/extend decisions
- Circuit breaker timeout backoff strategy (from kb-concept-circuit-breaker-timeout.md) informs bake time escalation: start with short analysis windows, increase if results are inconclusive
- Both patterns use threshold-based state transitions driven by failure rate monitoring

## Limitations
- All metrics and thresholds above are from domain understanding, not verified external sources
- Specific tool configurations (Flagger, Argo Rollouts, Kayenta) could not be grounded due to fetch tool unavailability
- Knowledge gap will be recorded for future retry
