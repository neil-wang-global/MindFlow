# Plan

## Task ID
- 20260401-concurrent-21

## Goal
- Research connection pooling strategies (HikariCP sizing, pool exhaustion detection, dynamic pool adjustment) and produce a synthesized research document, promoting acquired knowledge through the full learning pipeline

## Runtime State
- the fixed runtime state file is: `tasks/20260401-concurrent-21/state.md`

## Global Constraints
- Concurrency rules: must not modify existing shared files (cu-*.md, gap-*.md, existing reviews)
- All created files must include task-id
- Append only to INDEX.md
- Default final result directory: `tasks/20260401-concurrent-21/_output/`
- Soul constraints: evidence-based design, primary source preference, quantitative benchmarks over qualitative recommendations

### Step 1
- Name: Acquire connection pooling knowledge
- Goal: Search for and verify primary sources about HikariCP connection pool sizing, pool exhaustion detection, and dynamic pool adjustment strategies
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-21/acquire/`
- Constraints: `mind/soul/core.md` (primary source requirement, quantitative benchmarks); sources must pass verification per `mind/learning/README.md`
- Inputs: task goal from task-profile.md; prior gap knowledge from `mind/learning/knowledge-gaps/gap-20260401-exhausted-acq-test-thread-pool-sizing.md` (use different search strategies than those already attempted)
- Outputs: `tasks/20260401-concurrent-21/acquire/search-log.md`, `tasks/20260401-concurrent-21/acquire/raw-sources/`, `tasks/20260401-concurrent-21/acquire/verification-report.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: search-log.md exists with at least one query executed; at least one source in raw-sources/ passes verification in verification-report.md with verdict `pass`
- Failure Policy: retry
- Instructions: 1. Simulate ACQ-001 about HikariCP connection pool sizing. 2. Execute search queries targeting HikariCP official documentation, pool exhaustion detection patterns, and dynamic pool adjustment. Use different strategies than those listed in gap-20260401-exhausted-acq-test-thread-pool-sizing.md §Attempted Strategies. 3. Fetch and verify candidate sources. 4. Sources must pass accessibility and content-match verification.

### Step 2
- Name: Synthesize connection pooling research document
- Goal: Consolidate verified source material into a structured research document
- Capability: document-synthesis
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-21/_output/connection-pooling-research.md`
- Constraints: `mind/soul/core.md` (clear state machines, minimal configuration surface, diagrams over prose)
- Inputs: `tasks/20260401-concurrent-21/acquire/raw-sources/`, `tasks/20260401-concurrent-21/acquire/verification-report.md`
- Outputs: `tasks/20260401-concurrent-21/_output/connection-pooling-research.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: `_output/connection-pooling-research.md` exists and covers HikariCP sizing, pool exhaustion detection, and dynamic pool adjustment based on verified sources
- Failure Policy: rework
- Instructions: 1. Read all verified sources from Step 1. 2. Synthesize findings into a structured research document covering: pool sizing formulas/strategies, exhaustion detection mechanisms, dynamic adjustment approaches. 3. Write to `_output/connection-pooling-research.md`.

## Handoffs
- Step 1 produces `acquire/` directory contents; Step 2 reads those as input
- Step 1 must complete before Step 2 begins (sequential dependency)

## Completion Check
- `_output/connection-pooling-research.md` exists with content covering all three research areas
- ACQ-001 completed with at least one verified source
- Terminal learning pipeline completed (tl, draft, review, kb, INDEX.md appended)
