# Plan

## Task ID
- 20260401-concurrent-22

## Goal
- Research bulkhead pattern variants (thread pool bulkhead, semaphore bulkhead, process-level isolation) and produce a verified research summary.

## Runtime State
- the fixed runtime state file is: tasks/20260401-concurrent-22/state.md

## Global Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Knowledge Source Prohibition: search summaries and AI-generated overviews are not valid sources
- Default final result directory: tasks/20260401-concurrent-22/_output/
- Soul constraints: evidence-based design, primary sources preferred, resilience over raw performance

### Step 1
- Name: Acquire bulkhead variant knowledge
- Goal: Search for, fetch, and verify primary sources on bulkhead pattern variants (thread pool bulkhead, semaphore bulkhead, process-level isolation)
- Capability: web-search
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-22/acquire/
- Constraints: mind/soul/core.md (Learning Policy: prioritize primary sources); SYSTEM.md Knowledge Source Prohibition
- Inputs: task-profile.md (goal and success criteria), learning-read.md (approved knowledge context)
- Outputs: tasks/20260401-concurrent-22/acquire/search-log.md, tasks/20260401-concurrent-22/acquire/raw-sources/, tasks/20260401-concurrent-22/acquire/verification-report.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: search-log.md exists with at least one query executed; at least one raw source file exists in acquire/raw-sources/; verification-report.md exists with at least one source marked as PASS
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) protocol per mind/learning/acquire/README.md. Search for authoritative documentation on bulkhead pattern variants. Target sources: Resilience4j documentation (bulkhead module), Microsoft Azure Architecture Center (bulkhead pattern), Netflix Hystrix documentation. Simulate ACQ about thread pool bulkhead, semaphore bulkhead, and process-level isolation. Verify sources pass quality checks.

### Step 2
- Name: Write bulkhead variants research summary
- Goal: Synthesize verified knowledge from Step 1 into a structured research summary document
- Capability: knowledge-synthesis
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-22/_output/
- Constraints: mind/soul/core.md; output must cover all three bulkhead variants
- Inputs: tasks/20260401-concurrent-22/acquire/verification-report.md, tasks/20260401-concurrent-22/acquire/raw-sources/
- Outputs: tasks/20260401-concurrent-22/_output/bulkhead-variants-research.md
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1
- Completion Criteria: _output/bulkhead-variants-research.md exists; document covers thread pool bulkhead, semaphore bulkhead, and process-level isolation variants; each variant section references verified source material
- Failure Policy: rework
- Instructions: Read all verified sources from Step 1. Organize findings by variant type. For each variant, document: mechanism, trade-offs, use cases, and implementation considerations. Include source references for all claims.

## Handoffs
- Step 1 produces acquire/ directory with verified sources; Step 2 reads those sources to produce the final output

## Completion Check
- tasks/20260401-concurrent-22/_output/bulkhead-variants-research.md exists and covers all three bulkhead variants
- At least one ACQ event completed with verified sources
- All Steps in Step Status Map are completed
