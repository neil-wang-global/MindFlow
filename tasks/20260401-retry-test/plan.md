# Plan

## Task ID
- 20260401-retry-test

## Goal
- Create a load testing script document that defines target endpoints, concurrency levels, ramp-up strategy, duration, and success/failure thresholds for validating system resilience under stress

## Runtime State
- tasks/20260401-retry-test/state.md

## Global Constraints
- Output must be written to tasks/20260401-retry-test/_output/
- Must follow Soul constraints from mind/soul/core.md (especially: never deploy resilience patterns without load testing)
- Retry failure policy must be exercised during Step 1 execution

### Step 1
- Name: Create Load Testing Script
- Goal: Produce a load testing script document covering target configuration, concurrency model, ramp-up strategy, and pass/fail thresholds
- Capability: none (no cap-* definition files exist)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-retry-test/_output/load-test-script.md
- Constraints: mind/soul/core.md
- Inputs: tasks/20260401-retry-test/task-profile.md, tasks/20260401-retry-test/analysis.md
- Outputs: tasks/20260401-retry-test/_output/load-test-script.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: tasks/20260401-retry-test/_output/load-test-script.md exists and contains endpoint definitions, concurrency configuration, ramp-up strategy, and pass/fail thresholds
- Failure Policy: retry
- Instructions: Generate a load testing script configuration document. Define at least 2 target endpoints, specify concurrency levels (e.g., 50-200 virtual users), define a ramp-up strategy (e.g., step or linear), set test duration, and establish success/failure thresholds (e.g., p99 latency < 500ms, error rate < 1%). Use k6 as the reference framework.

## Handoffs
- single-step task -- no inter-step handoff

## Completion Check
- tasks/20260401-retry-test/_output/load-test-script.md exists with complete load testing configuration including endpoints, concurrency, ramp-up, and thresholds
