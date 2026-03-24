# Task Example Template

This file shows what a complete task directory looks like with example content for each file. It is not used by the runtime.

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

## Soul Files Read
- mind/soul/core.md — loaded identity, values, methodology preference

## Approved Knowledge Files Read
- mind/learning/knowledge-base/approved/kb-concept-distributed-caching.md — relevant to rate limiter state storage
- mind/learning/knowledge-base/approved/kb-method-api-design-patterns.md — relevant to API middleware design

## Relevance
- Soul methodology preference for event-driven architecture informs the rate limiter's async counting approach
- Distributed caching knowledge directly applicable to shared rate limit state
```

## Example: task-profile.md

```md
# Task Profile

## Task ID
- 20260324-api-rate-limiter

## Task Type
- Design + Implementation

## Goal
- Design and implement a rate limiting middleware for the public API

## Complexity
- Medium — well-understood problem domain, but requires distributed state coordination

## Risk
- Medium — incorrect implementation could block legitimate traffic or fail to limit abuse

## Capability Needs
- cap-api-design: for middleware interface design
- cap-code-generation: for implementation

## Step-Level Learning
- May need external acquisition on token bucket vs sliding window trade-offs

## Inference Needed
- No
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
