# Plan

## Task ID
- 20260401-concurrent-25

## Goal
- Research the three observability pillars and produce grounded, verified knowledge entries for each: metrics, distributed tracing, and structured logging

## Runtime State
- the fixed runtime state file is: `tasks/20260401-concurrent-25/state.md`

## Global Constraints
- Knowledge Source Prohibition: search summaries are leads only
- Fixed Promotion Path: task-learning -> drafts -> reviews -> knowledge-base/approved
- Soul: evidence-based design, primary sources, quantitative benchmarks
- default final result directory: `tasks/20260401-concurrent-25/_output/`
- Concurrency: all files include task-id; shared files append-only

### Step 1
- Name: Metrics Pillar Research
- Goal: Acquire grounded knowledge about observability metrics — Prometheus data model, dimensional vs hierarchical naming
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-25/cache/step-1-metrics-20260401-concurrent-25.md`
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, learning-read.md
- Outputs: `tasks/20260401-concurrent-25/cache/step-1-metrics-20260401-concurrent-25.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: cache/step-1-metrics-20260401-concurrent-25.md exists with metrics research summary; ACQ event completed with at least 1 passed source
- Failure Policy: retry
- Instructions: Search for Prometheus documentation on metric types and data model. Fetch primary source pages. Execute ACQ protocol (search, fetch, verify). Write step output summarizing findings with source references.

### Step 2
- Name: Distributed Tracing Research
- Goal: Acquire grounded knowledge about distributed tracing — OpenTelemetry, W3C trace context, sampling strategies
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-25/cache/step-2-tracing-20260401-concurrent-25.md`
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, learning-read.md, cache/step-1-metrics-20260401-concurrent-25.md
- Outputs: `tasks/20260401-concurrent-25/cache/step-2-tracing-20260401-concurrent-25.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: cache/step-2-tracing-20260401-concurrent-25.md exists with tracing research summary; ACQ event completed with at least 1 passed source
- Failure Policy: retry
- Instructions: Search for W3C Trace Context specification and OpenTelemetry documentation. Fetch primary source pages. Execute ACQ protocol. Write step output summarizing findings with source references.

### Step 3
- Name: Structured Logging Research
- Goal: Acquire grounded knowledge about structured logging — ECS, correlation IDs, log levels taxonomy
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-25/cache/step-3-logging-20260401-concurrent-25.md`
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, learning-read.md, cache/step-2-tracing-20260401-concurrent-25.md
- Outputs: `tasks/20260401-concurrent-25/cache/step-3-logging-20260401-concurrent-25.md`, `tasks/20260401-concurrent-25/_output/observability-pillars-research-20260401-concurrent-25.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 2
- Completion Criteria: cache/step-3-logging-20260401-concurrent-25.md exists with logging research summary; _output/observability-pillars-research-20260401-concurrent-25.md exists with consolidated research; ACQ event completed with at least 1 passed source
- Failure Policy: retry
- Instructions: Search for Elastic Common Schema documentation and log level standards (RFC 5424). Fetch primary source pages. Execute ACQ protocol. Write step output and consolidated final output combining all three pillars.

## Handoffs
- Step 1 output -> Step 2 input (metrics context informs tracing research)
- Step 2 output -> Step 3 input (tracing context informs logging research)
- Step 3 produces final consolidated output in _output/

## Completion Check
- All three step cache files exist with research summaries
- _output/observability-pillars-research-20260401-concurrent-25.md exists with consolidated findings
- Three ACQ events completed (one per step), each with at least 1 passed source
