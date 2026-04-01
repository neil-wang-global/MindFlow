# Plan

## Task ID
- 20260401-concurrent-27

## Goal
- Produce an architecture recommendation for event-driven vs request-response patterns, backed by externally acquired research and inference analysis

## Runtime State
- tasks/20260401-concurrent-27/state.md

## Global Constraints
- Concurrency rules: must not modify existing shared files; all created files must include task-id; APPEND only to INDEX.md
- Default final result directory: tasks/20260401-concurrent-27/_output/
- Soul constraints: resilience over raw performance; evidence-based design; explicit failure handling; data-driven decisions
- Inference output (cache/inference-event-vs-request.md) accepted into analysis and available as input

### Step 1
- Name: Research Event-Driven Architecture Benefits
- Goal: Acquire verified external knowledge on event-driven architecture patterns and their benefits for microservice communication
- Capability: none (research/acquisition task)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-27/cache/ (acquire/ subdirectory for ACQ artifacts)
- Constraints: mind/soul/core.md (evidence-based design, primary sources preferred)
- Inputs: tasks/20260401-concurrent-27/cache/inference-event-vs-request.md (accepted inference identifying key research areas), tasks/20260401-concurrent-27/analysis.md
- Outputs: tasks/20260401-concurrent-27/cache/ (search-log, raw sources, verification report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: search-log.md exists in cache/acquire/ with at least one query executed; at least one source fetched and recorded in raw-sources/; verification-report.md exists with verification outcome for each source
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) to research event-driven architecture benefits. Target queries should focus on: (1) event-driven architecture benefits for microservices, (2) event-driven vs request-response trade-offs in distributed systems. Follow the full ACQ pipeline: search, fetch, verify. Record all artifacts in cache/acquire/.

### Step 2
- Name: Design Architecture Recommendation
- Goal: Synthesize acquired knowledge and inference output into a concrete architecture recommendation deliverable
- Capability: none (synthesis/writing task)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-27/_output/architecture-recommendation.md
- Constraints: mind/soul/core.md (data-driven decisions, operational simplicity)
- Inputs: tasks/20260401-concurrent-27/cache/inference-event-vs-request.md, tasks/20260401-concurrent-27/cache/acquire/ (verified sources from Step 1)
- Outputs: tasks/20260401-concurrent-27/_output/architecture-recommendation.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/architecture-recommendation.md exists and contains: (1) a clear recommendation section, (2) trade-off comparison table, (3) decision criteria, (4) references to both inference output and acquired sources
- Failure Policy: rework
- Instructions: Combine the inference analysis (event-driven vs request-response trade-offs) with the acquired external knowledge to produce a structured architecture recommendation. Include a trade-off matrix, decision criteria for choosing between patterns, and specific guidance for different interaction scenarios. Reference both the inference artifact and verified sources.

## Handoffs
- Step 1 produces acquired knowledge artifacts in cache/acquire/ -> Step 2 reads these plus the inference artifact to produce the final recommendation

## Completion Check
- _output/architecture-recommendation.md exists with recommendation, trade-off comparison, and decision criteria
- cache/inference-event-vs-request.md exists with status accepted-into-analysis
- Learning(Acquire) was triggered during Step 1 with verification complete
