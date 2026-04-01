# Plan

## Task ID
- 20260401-concurrent-07

## Goal
- Build a health check endpoint design document and acquire knowledge about health check patterns (liveness vs readiness probes, deep vs shallow checks) via ACQ

## Runtime State
- the fixed runtime state file is: tasks/20260401-concurrent-07/state.md

## Global Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; APPEND only to INDEX.md
- Soul constraints: explicit failure handling over silent degradation; operational simplicity over architectural elegance
- Default final result directory: tasks/20260401-concurrent-07/_output/
- No publish-back to sources/ required

### Step 1
- Name: Research health check patterns
- Goal: Acquire external knowledge about health check patterns including liveness vs readiness probes, and deep vs shallow health checks
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-07/acquire/ (all ACQ artifacts)
- Constraints: mind/soul/core.md (evidence-based design, primary sources preference)
- Inputs: tasks/20260401-concurrent-07/learning-read.md, mind/learning/knowledge-base/approved/kb-concept-circuit-breaker-states.md
- Outputs: tasks/20260401-concurrent-07/acquire/search-log.md, tasks/20260401-concurrent-07/acquire/raw-sources/, tasks/20260401-concurrent-07/acquire/verification-report.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: search-log.md exists with at least 1 successful source fetch; raw-sources/ contains at least 1 source file; verification-report.md exists with verification decision
- Failure Policy: escalate-to-reflection
- Instructions: Trigger Learning(Acquire) to research health check patterns. Target query: "health check endpoint patterns liveness readiness probes deep shallow checks". Simulate ACQ-001 focusing on: (1) liveness vs readiness probe distinction, (2) deep vs shallow health check patterns, (3) dependency health aggregation. Follow the full ACQ pipeline: search -> fetch -> verify.

### Step 2
- Name: Design health check endpoint
- Goal: Produce health check endpoint design document incorporating acquired patterns
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-07/_output/health-check-endpoint.md
- Constraints: mind/soul/core.md (operational simplicity, explicit failure handling)
- Inputs: tasks/20260401-concurrent-07/acquire/ (ACQ output from Step 1), mind/learning/knowledge-base/approved/kb-concept-circuit-breaker-states.md
- Outputs: tasks/20260401-concurrent-07/_output/health-check-endpoint.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/health-check-endpoint.md exists; document covers liveness endpoint, readiness endpoint, deep and shallow check strategies, dependency health aggregation
- Failure Policy: rework
- Instructions: Using the health check patterns acquired in Step 1 and existing circuit breaker state knowledge, design a health check endpoint specification. Include: (1) /health/live endpoint for liveness (shallow), (2) /health/ready endpoint for readiness (deep), (3) dependency health check strategy, (4) response format and status codes, (5) integration with circuit breaker state monitoring.

## Handoffs
- Step 1 produces ACQ artifacts in tasks/20260401-concurrent-07/acquire/; Step 2 reads these as input for endpoint design
- Step 1 must complete before Step 2 begins (sequential dependency)

## Completion Check
- tasks/20260401-concurrent-07/acquire/verification-report.md exists (ACQ completed)
- tasks/20260401-concurrent-07/_output/health-check-endpoint.md exists (deliverable produced)
- Both Steps marked completed in state.md Step Status Map
