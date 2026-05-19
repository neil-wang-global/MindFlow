# Capability Update Record

## Capability
- cap-benchmarking

## Update Type
- add

## Reason
- Step 1 failed because the benchmark tool was unavailable; cap-benchmarking needs to be formally defined with its external tool dependency documented so future tasks can verify tool availability before execution

## Source
- mind/learning/task-learning/tl-20260401-failure-test.md

## Review Reference
- reflection-triggered: tasks/20260401-failure-test/reflection-report.md §Capability Impact

## Target Capability File
- capabilities/cap-benchmarking.md

## Planned Changes
- Create cap-benchmarking.md capability definition with required external tools (e.g., wrk, k6, Apache Bench) listed as prerequisites

## Applied Changes
- none

## Validation
- none

## Status
- proposed

## Scan History
- 20260401-failure-test: created
- 20260401-inference-test: scanned (status: proposed, not relevant to current task)
- 20260401-midstep-acq-test: scanned (status: proposed, threshold not met 1 < 3, no action required)
- 20260401-pure-learning-test: scanned (status: proposed, threshold not met 1 < 3, no action required)
- 20260401-retry-test: scanned (status: proposed, threshold not met 1 < 3, no action required)
- 20260401-stop-test: scanned (status: proposed, scan count > 2 staleness flag threshold met, but mandatory plan step threshold 1 < 3 not met)
- 20260401-rework-test: scanned (status: proposed, scan count > 2 staleness flag threshold met, but mandatory plan step threshold 1 < 3 not met)
- 20260401-subagent-test: scanned (status: proposed, scan count > 2 staleness flag threshold met, but mandatory plan step threshold 1 < 3 not met)
- 20260401-threshold-maintenance-test: scanned (status: proposed, threshold 4 >= 3 met, mandatory plan step required, scan count > 2 staleness flag)
- 20260401-threshold-maintenance-test: reviewed in maintenance Step 1 — kept as proposed (reason: external tool dependency (wrk, k6, Apache Bench) cannot be validated without verifying tool availability; staleness flag noted for Reflection)
- 20260401-knowledge-gap-retry-test: scanned (status: proposed, threshold not met 1 < 3, no action required)
- 20260401-deferred-review-test: scanned (status: proposed, scan count > 2 staleness flag threshold met, but mandatory plan step threshold 1 < 3 not met)
- 20260401-fix-val-02: scanned (status: proposed, not relevant to current task)
- 20260401-fix-val-06: scanned (status: proposed, threshold 4 >= 3 met but not relevant to current learning task; scan count > 2 staleness flag)
- 20260401-fix-val-01: scanned (status: proposed, threshold 4 >= 3 met, mandatory plan step required, scan count > 2 staleness flag)
- 20260401-fix-val-05: scanned (status: proposed, threshold 4 >= 3 met but already reviewed by threshold-maintenance-test; not relevant to current gRPC load balancing task; scan count > 2 staleness flag)
- 20260401-fix-val-03: scanned (status: proposed, threshold 4 >= 3 met, scan count > 2 staleness flag, flagged in learning-read)
- 20260401-fix-val-08: scanned (status: proposed, threshold 4 >= 3 met, scan count > 2 staleness flag; kept as proposed — same reason as threshold-maintenance-test review: external tool dependency cannot be validated without verifying tool availability)
- 20260401-fix-val-04: scanned (status: proposed, threshold 4 >= 3 met, scan count > 2 staleness flag; kept as proposed — external tool dependency cannot be validated without verifying tool availability; not relevant to current Envoy telemetry task)
- 20260401-fix-val-01: maintenance Step 3 reviewed — kept as proposed (reason: external tool dependency (wrk, k6, Apache Bench) cannot be validated in current environment; same assessment as threshold-maintenance-test and prior tasks)
