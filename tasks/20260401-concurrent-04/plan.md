# Plan

## Task ID
- 20260401-concurrent-04

## Goal
- Acquire foundational functional programming knowledge across three sub-topics (immutability/pure functions, monads/functors, higher-order functions/currying) and produce verified knowledge artifacts for each

## Runtime State
- the fixed runtime state file is: tasks/20260401-concurrent-04/state.md

## Global Constraints
- Knowledge Source Prohibition: search summaries, snippets, and AI-generated overviews are not valid sources
- Soul learning policy: prioritize primary sources (academic papers, official library documentation)
- Concurrency constraint: do not modify existing shared files; all created files must include task-id
- Default final result directory: tasks/20260401-concurrent-04/_output/

### Step 1
- Name: Acquire immutability and pure functions knowledge
- Goal: Acquire verified knowledge about immutability, pure functions, referential transparency, and side-effect isolation from primary sources
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-04/cache/acq-step1-immutability/
- Constraints: mind/soul/core.md (learning policy: primary sources required)
- Inputs: task-profile.md (task goal and success criteria), analysis.md (problem definition)
- Outputs: tasks/20260401-concurrent-04/cache/acq-step1-immutability/ (search-log, raw-sources, verification-report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: search-log.md exists with at least 1 search query executed; at least 1 raw source fetched and stored; verification-report.md exists with at least 1 source verified covering referential transparency and side-effect isolation
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) for immutability and pure functions. Search for primary sources covering (a) formal definition of referential transparency, (b) pure functions and their properties, (c) side-effect isolation mechanisms. Fetch candidate sources, verify content against Knowledge Source Prohibition, and produce verification report.

### Step 2
- Name: Acquire monads and functors knowledge
- Goal: Acquire verified knowledge about monads (Maybe/Option, Either, IO), functors, and monad laws from primary sources
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-04/cache/acq-step2-monads/
- Constraints: mind/soul/core.md (learning policy: primary sources required)
- Inputs: task-profile.md, analysis.md, cache/acq-step1-immutability/verification-report.md (foundational context)
- Outputs: tasks/20260401-concurrent-04/cache/acq-step2-monads/ (search-log, raw-sources, verification-report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: search-log.md exists with at least 1 search query executed; at least 1 raw source fetched and stored; verification-report.md exists with at least 1 source verified covering monad laws and at least one specific monad type (Maybe/Option, Either, or IO)
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) for monads and functors. Search for primary sources covering (a) functor laws (identity, composition), (b) monad laws (left identity, right identity, associativity), (c) specific monad types — Maybe/Option for optional values, Either for error handling, IO for side-effect encapsulation. Fetch candidate sources, verify content, and produce verification report.

### Step 3
- Name: Acquire higher-order functions and currying knowledge
- Goal: Acquire verified knowledge about higher-order functions, currying, partial application, function composition, and point-free style from primary sources
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-04/cache/acq-step3-hof/
- Constraints: mind/soul/core.md (learning policy: primary sources required)
- Inputs: task-profile.md, analysis.md, cache/acq-step1-immutability/verification-report.md (pure function foundation)
- Outputs: tasks/20260401-concurrent-04/cache/acq-step3-hof/ (search-log, raw-sources, verification-report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: search-log.md exists with at least 1 search query executed; at least 1 raw source fetched and stored; verification-report.md exists with at least 1 source verified covering currying/partial application and function composition
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) for higher-order functions and currying. Search for primary sources covering (a) higher-order functions definition and examples, (b) currying and partial application as transformation techniques, (c) function composition and the point-free style. Fetch candidate sources, verify content, and produce verification report.

## Handoffs
- Step 1 produces foundational concepts (immutability, pure functions) that Steps 2 and 3 reference as context
- Step 2 produces monad/functor knowledge independent of Step 3
- Step 3 produces HOF/currying knowledge independent of Step 2
- All three steps' verification reports feed into terminal Learning for synthesis and promotion

## Completion Check
- All three steps completed with verification-report.md present in each cache subdirectory
- At least 3 ACQ events triggered (one per step)
- All verification reports contain at least 1 verified source each
- _output/ contains a knowledge synthesis artifact summarizing all three FP sub-topics
