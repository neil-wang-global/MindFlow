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

## Mode
- standard

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

## Example: analysis.md

```md
# Analysis Output

## Task ID
- 20260324-api-rate-limiter

## Problem Definition
- Design a rate limiting middleware supporting token bucket and sliding window algorithms
- Must integrate with existing API gateway and distributed cache infrastructure

## Success Conditions
- Middleware passes integration tests
- Latency < 5ms per request
- Both algorithm variants are configurable

## Required Reads
- mind/soul/core.md
- tasks/20260324-api-rate-limiter/learning-read.md
- tasks/20260324-api-rate-limiter/task-profile.md

## Stage Breakdown
- Stage 1: Research — compare rate limiting algorithms
- Stage 2: Implementation — build the middleware
- Stage 3: Validation — test and produce final design document

## Step Drafts
- Step 1: goal: research algorithms / dependencies: none / capability: cap-research / Dispatch Mode: sequential / Output Isolation: cache/step-1-research-notes.md
- Step 2: goal: implement middleware / dependencies: Step 1 / capability: cap-code-generation / Dispatch Mode: sequential / Output Isolation: cache/step-2-implementation.md
- Step 3: goal: test and validate / dependencies: Step 2 / capability: cap-code-generation / Dispatch Mode: sequential / Output Isolation: _output/rate-limiter-design.md

## Dispatch Assessment
- Step 1: sequential — depends on no prior output, but Step 2 requires its result
- Step 2: sequential — depends on Step 1 research output
- Step 3: sequential — depends on Step 2 implementation

## Risks
- Token bucket vs sliding window choice may affect latency profile — mitigated by benchmarking in Step 3
- Distributed cache integration may introduce network latency — mitigated by latency budget in constraints

## Step-level Learning Need
- Step 1: acquire-required — external research on algorithms
- Step 2: terminal-only — implementation artifacts may yield reusable patterns
- Step 3: not-needed — validation step

## Possible Inference Trigger
- none

## Notes
- none
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
Each candidate must include its source location so terminal `Learning` can trace it:

- Token bucket vs sliding window trade-off analysis — source: `cache/step-1-research-notes.md §Algorithm Comparison`
- Distributed cache integration pattern — source: `_output/rate-limiter-design.md §Cache Integration`

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
- **Source Anchor**: `tasks/20260324-api-rate-limiter/acquire/raw-sources/src-001-token-bucket.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Token bucket allows bursts up to bucket capacity while maintaining a long-term average rate. Sliding window provides smoother rate enforcement but requires more memory for window tracking."
- **Derived Conclusion**: For APIs needing burst tolerance, token bucket is preferred. For strict per-second smoothness, sliding window is preferred. The choice depends on traffic pattern.

## Potential Capability Impact
- none

## Next Promotion Target
- `mind/learning/knowledge-base/drafts/draft-concept-20260324-rate-limiting-tradeoffs.md`
```

## Example: draft-*.md (written to mind/learning/knowledge-base/drafts/)

```md
# Draft Knowledge

## Type
- concept

## Task ID
- 20260324-api-rate-limiter

## Summary
- Token bucket allows bursts; sliding window enforces smoother rates. Choice depends on traffic pattern.

## From Task Learning
- mind/learning/task-learning/tl-20260324-api-rate-limiter.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260324-api-rate-limiter/acquire/raw-sources/src-001-token-bucket.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260324-api-rate-limiter/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Token bucket allows bursts up to bucket capacity while maintaining a long-term average rate. Sliding window provides smoother rate enforcement but requires more memory for window tracking."

## Candidate Conclusion
- For APIs needing burst tolerance, token bucket is preferred. For strict per-second smoothness, sliding window is preferred. The choice depends on traffic pattern.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260324-rate-limiting-tradeoffs.md

## Notes
- none
```

## Example: review-*.md (written to mind/learning/reviews/)

```md
# Learning Review

## Subject
- Token bucket vs sliding window trade-offs

## Source Task
- 20260324-api-rate-limiter

## Candidate File
- mind/learning/knowledge-base/drafts/draft-concept-20260324-rate-limiting-tradeoffs.md

## Verification Mode
- independent-subagent

## Summary Verified
- yes

## Source Anchor Verified
- yes

## Conflict Check
- no-conflict

## Decision
- accepted

## Reason
- Source anchor verified via Grep substring match. Summary is a direct condensation of the candidate conclusion. No conflicting entries in approved/.

## Promotion Target
- mind/learning/knowledge-base/approved/kb-concept-rate-limiting-tradeoffs.md

## Capability Impact
- none
```

## Example: kb-*.md (written to mind/learning/knowledge-base/approved/)

```md
# Knowledge Base Entry

## Type
- concept

## Summary
- Token bucket allows bursts; sliding window enforces smoother rates. Choice depends on traffic pattern.

## Source Lineage
- Task ID: 20260324-api-rate-limiter
- Task Learning Record: mind/learning/task-learning/tl-20260324-api-rate-limiter.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260324-rate-limiting-tradeoffs.md
- Review File: mind/learning/reviews/review-20260324-rate-limiting-tradeoffs.md
- Original Source Anchor: tasks/20260324-api-rate-limiter/acquire/raw-sources/src-001-token-bucket.md
- Original Source URL: https://example.com/rate-limiting-algorithms

## Key Evidence
> "Token bucket allows bursts up to bucket capacity while maintaining a long-term average rate. Sliding window provides smoother rate enforcement but requires more memory for window tracking."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260324-rate-limiting-tradeoffs.md

## Applicability
- Applies to: API rate limiting design, traffic shaping middleware
- Does not apply to: non-networked resource throttling

## Notes
- none
```

---

## Compact Mode Example

Below is a compact mode task example. In compact mode, `analysis.md` and `plan.md` are merged into a single `analysis-plan.md`.

### Example Task Directory (Compact)

```text
tasks/20260325-fix-typo-readme/
├── learning-read.md
├── state.md
├── task-profile.md
├── analysis-plan.md          (replaces both analysis.md and plan.md)
├── reflection-report.md
├── _output/
│   └── readme-fix.md
└── cache/
```

### Example: task-profile.md (Compact)

```md
# Task Profile

## Task ID
- 20260325-fix-typo-readme

## Task Type
- delivery

## Goal
- Fix a spelling error in the project README introduction section

## Inputs
- sources/README.md

## Success Criteria
- The typo is corrected
- No other content is changed

## Complexity
- low

## Risk
- low

## Capability Needs
- cap-text-editing

## Constraints
- Change only the identified typo; do not rewrite surrounding text

## Task-level Learning Possibility
- `not-expected`

## Mode
- compact

## Inference Possibility
- not needed

## Notes
- none
```

### Example: analysis-plan.md (Compact)

```md
# Analysis and Plan (Compact)

## Task ID
- 20260325-fix-typo-readme

## Problem Definition
- A spelling error in the project README needs correction

## Success Conditions
- The typo is fixed and no other content is altered

## Required Reads
- mind/soul/core.md
- tasks/20260325-fix-typo-readme/learning-read.md
- tasks/20260325-fix-typo-readme/task-profile.md

## Risks
- none

## Step-level Learning Need
- Step 1: not-needed

## Goal
- Correct the typo in the README

## Runtime State
- the fixed runtime state file is: `tasks/20260325-fix-typo-readme/state.md`

## Global Constraints
- default final result directory: `tasks/20260325-fix-typo-readme/_output/`

### Step 1
- Name: Fix typo
- Goal: Correct the spelling error
- Capability: cap-text-editing
- Dispatch Mode: sequential
- Output Isolation: writes only to `_output/readme-fix.md`
- Constraints: `mind/soul/core.md`
- Inputs: `sources/README.md`
- Outputs: `_output/readme-fix.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: Typo is corrected; diff shows only the single character change
- Failure Policy: retry
- Instructions: Read the README, locate the typo, produce the corrected version.

## Handoffs
- single-step task — no inter-step handoff

## Completion Check
- `_output/readme-fix.md` exists with the corrected text
```
