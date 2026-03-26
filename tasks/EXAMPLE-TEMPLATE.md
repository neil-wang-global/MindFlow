# Task Example Template

This file shows what a complete task directory looks like with example content for each file. It is not used by the runtime. It is a reference for first-time users.

## Example Task Directory

```text
tasks/20260324-api-rate-limiter/
├── learning-read.md
├── state.md
├── task-profile.md
├── analysis.md
├── plan.md
├── reflection-report.md
├── _output/
│   └── rate-limiter-design.md
├── cache/
│   └── step-1-research-notes.md
└── acquire/                          (only if Learning(Acquire) was triggered)
    ├── search-log.md
    ├── raw-sources/
    │   ├── src-001-token-bucket.md
    │   └── src-002-sliding-window.md
    └── verification-report.md
```

## Example: learning-read.md

```md
# Learning(Read) Audit

## Task ID
- 20260324-api-rate-limiter

## Soul Reads
- mind/soul/core.md — loaded identity, values, methodology preference

## Approved Knowledge Reads
- mind/learning/knowledge-base/approved/kb-concept-distributed-caching.md — relevant to rate limiter state storage
- mind/learning/knowledge-base/approved/kb-method-api-design-patterns.md — relevant to API middleware design

## Read Scope Notes
- Soul methodology preference for event-driven architecture informs the rate limiter's async counting approach
- Distributed caching knowledge directly applicable to shared rate limit state

## Pending Cross-Task Items
- none

## Excluded Areas
- `mind/learning/knowledge-base/drafts/`
- `mind/learning/knowledge-base/archived/`
- `mind/learning/task-learning/`
```

## Example: task-profile.md

```md
# Task Profile

## Task ID
- 20260324-api-rate-limiter

## Task Type
- delivery

## Goal
- Design and implement a rate limiting middleware for the public API
- Must support both token bucket and sliding window algorithms
- Must integrate with existing API gateway

## Inputs
- sources/api-gateway-spec.md
- sources/traffic-analysis-report.md

## Success Criteria
- Rate limiter middleware passes integration tests
- Correctly limits requests per the configured thresholds
- Does not block legitimate traffic under normal load

## Complexity
- medium

## Risk
- medium

## Capability Needs
- cap-api-design: for middleware interface design
- cap-code-generation: for implementation

## Constraints
- Must be compatible with existing distributed cache infrastructure
- Latency budget: < 5ms per request for rate limit check

## Task-level Learning Possibility
- `acquire-likely` — rate limiting algorithms may require external research

## Inference Possibility
- not needed

## Notes
- none
```

## Example: state.md

```md
# Task State

## Task ID
- 20260324-api-rate-limiter

## Current Phase
- execution-control

## Current Step
- Step 2

## Overall Status
- running

## Step Status Map
- Step 1: completed
- Step 2: running
- Step 3: pending

## Parallel Branch Status
- none

## Last Failure
- none

## Retry Count
- 0

## Ready For Reflection
- no

## Learning(Acquire) Log
- Step 1: gap-encountered → ACQ-001 triggered
```

## Example: plan.md (sequential — simplified Step format)

```md
# Plan

## Task ID
- 20260324-api-rate-limiter

## Goal
- Deliver a rate limiting middleware with token bucket and sliding window support

## Runtime State
- the fixed runtime state file is: `tasks/20260324-api-rate-limiter/state.md`

## Global Constraints
- Latency < 5ms per request
- Must use existing distributed cache infrastructure
- Default final result directory: `tasks/20260324-api-rate-limiter/_output/`

### Step 1
- Name: Research rate limiting algorithms
- Goal: Identify trade-offs between token bucket and sliding window
- Capability: cap-research
- Dispatch Mode: sequential
- Output Isolation: writes only to `cache/step-1-research-notes.md`
- Constraints: `mind/soul/core.md`
- Inputs: `learning-read.md`, `sources/api-gateway-spec.md`
- Outputs: `cache/step-1-research-notes.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: Research notes contain at least two algorithm comparisons
- Failure Policy: escalate-to-reflection
- Instructions: Research token bucket and sliding window algorithms. If external sources are needed, trigger Learning(Acquire).

### Step 2
- Name: Implement rate limiter middleware
- Goal: Implement the middleware based on Step 1 recommendations
- Capability: cap-code-generation
- Dispatch Mode: sequential
- Output Isolation: writes only to `cache/step-2-implementation.md`
- Constraints: `mind/soul/core.md`
- Inputs: `cache/step-1-research-notes.md`, `sources/api-gateway-spec.md`
- Outputs: `cache/step-2-implementation.md`
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1
- Completion Criteria: Implementation compiles and includes both algorithm variants
- Failure Policy: retry
- Instructions: Implement the middleware. Support both algorithms via configuration flag.

### Step 3
- Name: Test and validate
- Goal: Write integration tests and produce the final design document
- Capability: cap-code-generation
- Dispatch Mode: sequential
- Output Isolation: writes only to `_output/rate-limiter-design.md`
- Constraints: `mind/soul/core.md`
- Inputs: `cache/step-2-implementation.md`
- Outputs: `_output/rate-limiter-design.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 2
- Completion Criteria: All integration tests pass; latency benchmark confirms < 5ms
- Failure Policy: rework
- Instructions: Write integration tests. Run performance benchmarks. Produce the final design document.

## Handoffs
- Step 1 → Step 2: via `cache/step-1-research-notes.md`
- Step 2 → Step 3: via `cache/step-2-implementation.md`

## Completion Check
- `_output/rate-limiter-design.md` exists and contains the final design
- All 3 Steps are marked completed in `state.md`
```

## Example: reflection-report.md

```md
# Reflection Report

## Task ID
- 20260324-api-rate-limiter

## Result Evaluation
- Rate limiter middleware successfully implemented with both algorithm support
- Integration tests passed; latency 2.3ms average — within budget

## Process Review
- Three-step sequential approach was appropriate
- Dispatch assessment: all Steps used `sequential` as declared — consistent with plan
- Step 1 required external acquisition (ACQ-001), completed successfully

## Issue Detection
- No capability gaps, knowledge gaps, or runtime failures

### Issue Detection: Requires External Acquisition
- no

## Learning Candidates
- Token bucket vs sliding window trade-off analysis — reusable for future API design
- Distributed cache integration pattern — worth documenting

### Learning Candidates: Requires External Acquisition
- no

## Capability Impact
- cap-research: no change needed
- cap-code-generation: no change needed

## Inference Triggers
- none

## Notes
- none
```

## Example: tl-{task-id}.md (written to mind/learning/task-learning/)

```md
# Task Learning Record

## Task ID
- 20260324-api-rate-limiter

## Task Summary
- Designed and implemented a rate limiting middleware supporting token bucket and sliding window
- Produced a validated design document with integration tests passing and latency within budget

## External Acquisition

### ACQ-001: token bucket vs sliding window research
- **Trigger**: Step 1
- **Status**: completed
- **Verification Report**: `tasks/20260324-api-rate-limiter/acquire/verification-report.md` §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] Token Bucket vs Sliding Window Trade-offs

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Grounded Source**: `tasks/20260324-api-rate-limiter/acquire/raw-sources/src-001-token-bucket.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Token bucket allows bursts up to bucket capacity while maintaining a long-term average rate. Sliding window provides smoother rate enforcement but requires more memory for window tracking."
- **Derived Conclusion**: For APIs needing burst tolerance, token bucket is preferred. For strict per-second smoothness, sliding window is preferred. The choice depends on traffic pattern.

## Potential Capability Impact
- none

## Next Promotion Target
- `mind/learning/knowledge-base/drafts/draft-concept-20260324-rate-limiting-tradeoffs.md`
```
