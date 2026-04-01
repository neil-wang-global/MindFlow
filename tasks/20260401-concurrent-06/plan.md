# Plan

## Task ID
- 20260401-concurrent-06

## Goal
- Design a retry-with-backoff library API with evidence-based jitter strategies, producing both a design document and promoted knowledge about jitter techniques

## Runtime State
- tasks/20260401-concurrent-06/state.md

## Global Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Soul constraints: resilience over raw performance; evidence-based design; explicit failure handling; operational simplicity over architectural elegance
- Knowledge source prohibition: search summaries and AI-generated overviews are not valid knowledge sources
- Default final result directory: tasks/20260401-concurrent-06/_output/

### Step 1
- Name: Research jitter strategies via Learning(Acquire)
- Goal: Trigger ACQ-001 to acquire knowledge about decorrelated jitter, full jitter, and equal jitter strategies from primary sources
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-06/acquire/ (search-log.md, raw-sources/, verification-report.md)
- Constraints: mind/soul/core.md (learning policy: prioritize primary sources, validate external claims)
- Inputs: task goal (jitter strategy knowledge gap), kb-concept-circuit-breaker-timeout.md (existing backoff knowledge as context)
- Outputs: tasks/20260401-concurrent-06/acquire/verification-report.md, tasks/20260401-concurrent-06/acquire/raw-sources/
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: acquire/verification-report.md exists with at least one verified source containing jitter strategy knowledge; state.md Learning(Acquire) Log shows ACQ-001 stage-3-verification-complete
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) per mind/learning/learning-acquire/README.md. Search for primary sources on retry jitter strategies — specifically decorrelated jitter (AWS architecture blog), full jitter, and equal jitter. Target sources: AWS Architecture Blog "Exponential Backoff And Jitter", Google Cloud documentation on retry strategies, or academic papers on collision avoidance in distributed systems. Fetch raw sources, extract relevant content, and verify against knowledge source prohibition rules.

### Step 2
- Name: Design retry-backoff library API
- Goal: Produce a complete library design document using acquired jitter knowledge and existing backoff knowledge
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-06/_output/retry-backoff-library.md
- Constraints: mind/soul/core.md (values: resilience over raw performance, operational simplicity over architectural elegance; methodology: pattern-based design; aesthetic: clear state machines, minimal configuration surface)
- Inputs: tasks/20260401-concurrent-06/acquire/verification-report.md, tasks/20260401-concurrent-06/acquire/raw-sources/, mind/learning/knowledge-base/approved/kb-concept-circuit-breaker-timeout.md
- Outputs: tasks/20260401-concurrent-06/_output/retry-backoff-library.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/retry-backoff-library.md exists and contains: API surface definition, backoff algorithm specification, at least 3 jitter strategy implementations (decorrelated, full, equal), configuration options, and usage examples
- Failure Policy: retry
- Instructions: Read the verified sources from Step 1's acquire output. Combine with existing exponential backoff knowledge from kb-concept-circuit-breaker-timeout.md. Design the retry library with: (1) core retry function with configurable max retries, base delay, max delay; (2) exponential backoff algorithm; (3) three jitter strategies — full jitter, equal jitter, decorrelated jitter — each with mathematical formula and rationale; (4) composable builder/configuration API; (5) usage examples showing each jitter strategy. Follow Soul aesthetic preference for clear state machines and minimal configuration surface.

## Handoffs
- Step 1 produces acquire/verification-report.md and acquire/raw-sources/ which Step 2 reads as input
- Step 2 produces the final deliverable in _output/

## Completion Check
- tasks/20260401-concurrent-06/acquire/verification-report.md exists with verified jitter strategy sources
- tasks/20260401-concurrent-06/_output/retry-backoff-library.md exists with complete library design
- state.md Learning(Acquire) Log shows ACQ-001 completed
- All Steps in Step Status Map are completed
