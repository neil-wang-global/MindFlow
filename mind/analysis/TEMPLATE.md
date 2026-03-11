`Analysis Output` is the formal artifact of `Analysis`.  
It is not the final `Plan`, but it must be stable enough for `Execution` to generate `Plan` without ambiguity.

## File Requirements

- file path: `tasks/{task-id}/analysis.md`
- fixed heading order is required
- dependencies and risks must be stated explicitly

## Formal Template

```md
# Analysis Output

## Task ID
- must match `Task Profile`

## Problem Definition
- what problem this task is actually solving
- what the problem boundary is

## Success Conditions
- what must be true when the task is complete

## Required Reads
- which files must be read before running `Analysis`
- at minimum include:
  - `mind/soul/core.md`
  - `mind/learning/knowledge-base/approved/`
  - `tasks/{task-id}/learning-read.md`
  - `tasks/{task-id}/task-profile.md`

## Stage Breakdown
- what stages the task should be divided into
- what each stage must solve

## Step Drafts
- `Step 1`: goal / dependencies / candidate capability / Dispatch Mode / Parallel Group / Synchronization Point / Merge Owner / Output Isolation
- `Step 2`: goal / dependencies / candidate capability / Dispatch Mode / Parallel Group / Synchronization Point / Merge Owner / Output Isolation
- `Step N`: goal / dependencies / candidate capability / Dispatch Mode / Parallel Group / Synchronization Point / Merge Owner / Output Isolation

## Serial vs Parallel Assessment
- which `Step`s must be sequential
- which `Step`s may run in parallel

## Dispatch Strategy
- which work should remain sequential
- which `Step`s are suitable for `subagent` parallelism inside a single `Step`
- which work is better split into multiple parallel `Step`s or task branches
- what the prerequisites, boundaries, and merge points are for each parallelism mode

## Dispatch Fields
- `Dispatch Mode` values: `sequential / subagent / parallel-branch`
- `Parallel Group` identifies parallel branch membership; use `none` when there is no parallelism
- `Synchronization Point` identifies branch merge points; use `none` when there is no synchronization
- `Merge Owner` identifies the `Step` responsible for consolidating branch results; use `none` when there is no merge
- `Output Isolation` explains which isolated paths the `Step` or branch writes to and how write conflicts are avoided

## Risks
- key risks
- source of each risk
- impact on `Plan`

## Step-level Learning Need
- which `Step`s may require temporary `Learning`

## Possible Inference Trigger
- which points may require inference

## Notes
- only additional information required at the analysis stage
```

## Validation Rules

- `Required Reads` must not be omitted
- any `Analysis Output` without dependency information is incomplete
- any `Analysis Output` without risk information is incomplete
- `Step Drafts` must be mappable to concrete `Step`s in the subsequent `Plan`
- if multi-branch execution is possible, any `Analysis Output` without a parallelism judgment is incomplete
- if `Step Drafts` use dispatch-related fields, both field names and values must remain consistent with the later `Plan`
