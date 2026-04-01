# Task Profile

## Task ID
- 20260401-concurrent-17

## Task Type
- delivery

## Goal
- Create a Prometheus alerting rules configuration document that defines alerting rules for monitoring distributed systems. The output should be a well-structured markdown file containing Prometheus alerting rule definitions with appropriate thresholds, labels, and annotations.

## Inputs
- Task statement: "Create a Prometheus alerting rules config"
- Soul constraints from `mind/soul/core.md`

## Success Criteria
- `_output/prometheus-alerts.md` exists and contains valid Prometheus alerting rules
- Rules cover key distributed systems failure modes consistent with Soul values (resilience, explicit failure handling)
- Rules include appropriate thresholds, labels, and annotations

## Complexity
- low

## Risk
- low

## Capability Needs
- monitoring/alerting configuration knowledge (Prometheus rule syntax)
- distributed systems operational patterns (failure modes, latency thresholds)

## Constraints
- Output must be placed in `tasks/20260401-concurrent-17/_output/prometheus-alerts.md`
- Must not modify shared files (concurrency rule)
- All created files must include task-id

## Task-level Learning Possibility
- not-expected

## Mode
- compact

## Inference Possibility
- not needed — task scope is well-defined and does not require uncertain reasoning

## Notes
- Low complexity delivery task; compact mode is appropriate given low complexity and low risk
