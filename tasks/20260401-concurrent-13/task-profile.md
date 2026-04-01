# Task Profile

## Task ID
- 20260401-concurrent-13

## Task Type
- mixed

## Goal
- Build a canary deployment checker design that defines the metrics, thresholds, and decision logic for progressive delivery canary analysis. This requires first acquiring knowledge about progressive delivery metrics (error rate thresholds, latency percentiles, canary analysis techniques), then producing a formal design document for the canary checker.

## Inputs
- Approved knowledge: kb-concept-circuit-breaker-states.md (state-based failure detection parallels canary pass/fail logic), kb-concept-circuit-breaker-timeout.md (exponential backoff informs bake time escalation)
- Soul constraints: distributed systems engineer, resilience-focused, data-driven decisions with latency percentiles and failure rate data

## Success Criteria
- External knowledge about progressive delivery metrics (error rate thresholds, latency percentiles, canary analysis) is acquired and verified
- A canary checker design document is produced in _output/canary-checker-design.md
- Design covers: metrics to monitor, threshold definitions, decision logic, rollback triggers
- Knowledge from ACQ is promoted through the standard knowledge path

## Complexity
- medium

## Risk
- medium

## Capability Needs
- distributed systems design
- metrics and observability patterns
- progressive delivery / deployment strategies

## Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Task must follow all 7 phases of MindFlow protocol
- Knowledge acquisition must follow the fixed promotion path: task-learning -> drafts -> reviews -> knowledge-base/approved

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- possible — may need inference to synthesize canary analysis decision logic from acquired metrics knowledge

## Notes
- This is a mixed task combining learning (progressive delivery metrics) and delivery (canary checker design)
- Step 1 has Learning: acquire-required per the test plan
