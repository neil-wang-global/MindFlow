# Plan

## Task ID
- 20260401-concurrent-08

## Goal
- Acquire structured logging standards knowledge (ECS, JSON logging, correlation IDs, log levels) and design a log aggregation pipeline architecture document

## Runtime State
- the fixed runtime state file is: tasks/20260401-concurrent-08/state.md

## Global Constraints
- Soul constraints: resilience over performance, operational simplicity, explicit failure handling
- Concurrency rules: do not modify existing shared files; all created files must include task-id
- Default final result directory: tasks/20260401-concurrent-08/_output/
- Mixed task: both deliverable and learning output required

### Step 1
- Name: Research structured logging standards
- Goal: Acquire knowledge about ECS (Elastic Common Schema), JSON logging formats, correlation IDs, and log level conventions via Learning(Acquire)
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-08/cache/acquire/ directory for ACQ artifacts
- Constraints: mind/soul/core.md (Learning Policy: prioritize primary sources, validate external claims)
- Inputs: task goal statement (structured logging standards)
- Outputs: tasks/20260401-concurrent-08/cache/acquire/search-log.md, tasks/20260401-concurrent-08/cache/acquire/verification-report.md, raw source files in tasks/20260401-concurrent-08/cache/acquire/raw-sources/
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: search-log.md exists with at least 2 search queries executed; verification-report.md exists with source verification results; at least 1 source passes verification with usable structured logging standards content
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) per mind/learning/README.md. Search for structured logging standards covering: (1) ECS field naming conventions and structure, (2) JSON logging format best practices, (3) correlation ID propagation patterns, (4) log level definitions and usage guidelines. Use multiple search queries to maximize source coverage. Simulate ACQ about ECS, JSON logging, correlation IDs, log levels.

### Step 2
- Name: Design log aggregation pipeline
- Goal: Produce a log aggregation pipeline architecture document using acquired structured logging knowledge
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-08/_output/log-pipeline-design.md
- Constraints: mind/soul/core.md (operational simplicity, explicit failure handling, state machines over ad-hoc logic)
- Inputs: ACQ results from Step 1 (structured logging standards knowledge), tasks/20260401-concurrent-08/cache/acquire/verification-report.md
- Outputs: tasks/20260401-concurrent-08/_output/log-pipeline-design.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/log-pipeline-design.md exists; document covers ingestion layer, processing layer, storage layer, and references structured logging standards from Step 1
- Failure Policy: rework
- Instructions: Design a log aggregation pipeline with these layers: (1) Ingestion — structured log emission from services using JSON format with ECS field conventions, correlation IDs; (2) Collection — log shipping agents, buffering, reliability guarantees; (3) Processing — parsing, enrichment, filtering, normalization to common schema; (4) Storage — indexing, retention policies, query optimization; (5) Pipeline resilience — backpressure handling, dead letter queues, monitoring of the pipeline itself. Apply Soul values: prefer operational simplicity, explicit failure modes, clear state machines for pipeline state.

### Step 3
- Name: Review pending capability updates
- Goal: Review the 4 pending capability updates that have exceeded the 3+ threshold and document advancement decisions
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-08/cache/capability-update-review-20260401-concurrent-08.md
- Constraints: mind/soul/core.md; SYSTEM.md §Capability Update Advancement; concurrency rules (do not modify shared files)
- Inputs: cu-20260325-cap-load-testing.md (approved), cu-20260326-cap-schema-design.md (approved), cu-20260327-cap-api-gateway.md (approved), cu-20260401-failure-test-cap-benchmarking.md (proposed)
- Outputs: tasks/20260401-concurrent-08/cache/capability-update-review-20260401-concurrent-08.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: cache/capability-update-review-20260401-concurrent-08.md exists with review decisions for all 4 capability update files
- Failure Policy: rework
- Instructions: Review each pending capability update. For the 3 approved files (load-testing, schema-design, api-gateway), document whether they should advance to applied status. For the 1 proposed file (cap-benchmarking), document whether it should advance to approved. Per concurrency rules, do not modify the shared capability-updates files directly; record decisions in the cache file for future non-concurrent execution.

## Handoffs
- Step 1 produces ACQ artifacts in cache/acquire/ which Step 2 reads as input for pipeline design
- Step 2 produces the final deliverable in _output/
- Step 3 is independent; its output is a cache file for future reference

## Completion Check
- tasks/20260401-concurrent-08/_output/log-pipeline-design.md exists with complete pipeline design
- tasks/20260401-concurrent-08/cache/acquire/search-log.md and verification-report.md exist
- tasks/20260401-concurrent-08/cache/capability-update-review-20260401-concurrent-08.md exists
- All Steps in Step Status Map are completed
