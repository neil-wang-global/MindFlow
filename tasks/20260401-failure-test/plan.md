# Plan

## Task ID
- 20260401-failure-test

## Goal
- Generate a performance benchmark report for the API gateway containing latency, throughput, and error rate metrics

## Runtime State
- the fixed runtime state file is: `tasks/20260401-failure-test/state.md`

## Global Constraints
- Default final result directory: `tasks/20260401-failure-test/_output/`
- Benchmark tool must be available in the execution environment
- API gateway must be accessible for testing

### Step 1
- Name: Run API gateway benchmarks
- Goal: Execute performance benchmark tests against the API gateway and collect raw latency, throughput, and error rate data
- Capability: cap-benchmarking
- Dispatch Mode: sequential
- Output Isolation: raw benchmark results written to `tasks/20260401-failure-test/cache/benchmark-results.json`
- Constraints: `mind/soul/core.md`
- Inputs: API gateway endpoint configuration
- Outputs: `tasks/20260401-failure-test/cache/benchmark-results.json`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: file `tasks/20260401-failure-test/cache/benchmark-results.json` exists and contains valid benchmark data with latency, throughput, and error rate measurements
- Failure Policy: escalate-to-reflection
- Instructions: Use the benchmark tool to run performance tests against the API gateway. Execute tests for latency measurement, throughput capacity, and error rate under load. Write raw results to cache/benchmark-results.json.

### Step 2
- Name: Compile benchmark report
- Goal: Transform raw benchmark data into a structured performance report
- Capability: cap-reporting
- Dispatch Mode: sequential
- Output Isolation: final report written to `tasks/20260401-failure-test/_output/benchmark-report.md`
- Constraints: `mind/soul/core.md`
- Inputs: `tasks/20260401-failure-test/cache/benchmark-results.json`
- Outputs: `tasks/20260401-failure-test/_output/benchmark-report.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: file `tasks/20260401-failure-test/_output/benchmark-report.md` exists and contains sections for latency, throughput, and error rate analysis
- Failure Policy: retry
- Instructions: Read the raw benchmark data from cache/benchmark-results.json. Compile a structured report with sections for latency analysis, throughput analysis, error rate analysis, and summary findings. Write the report to _output/benchmark-report.md.

## Handoffs
- Step 1 produces `cache/benchmark-results.json` which Step 2 consumes as its primary input
- Step 2 produces the final deliverable in `_output/benchmark-report.md`

## Completion Check
- `tasks/20260401-failure-test/_output/benchmark-report.md` exists and contains performance benchmark data with latency, throughput, and error rate sections
