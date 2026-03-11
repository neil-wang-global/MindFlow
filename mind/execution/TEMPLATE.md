`Plan` is the only formal output of `Execution`.  
The runtime recognizes only `plan.md`, not scattered `Step` notes.

## File Requirements

- file path: `tasks/{task-id}/plan.md`
- fixed heading order is required
- every `Step` must have an explicit number
- every `Step` must explicitly declare inputs and outputs

## Formal Template

```md
# Plan

## Task ID
- current task ID

## Goal
- the final outcome this task must reach

## Runtime State
- the fixed runtime state file is: `tasks/{task-id}/state.md`
- `Execution` must ensure that the `Plan` can be executed in a stateful way

## Global Constraints
- global execution constraints for this task
- default final result directory: `tasks/{task-id}/_output/`
- if publish-back to `sources/` is needed, it must be explicitly declared in the corresponding `Step`
- before task completion, at least one final-output `Step` must write results into `tasks/{task-id}/_output/`
- `Execution` must explicitly choose the execution mode of `Plan -> Steps` rather than leaving dispatch to implicit judgment

## Step 1
- Name:
- Goal:
- Capability:
- Dispatch Mode: `sequential / subagent / parallel-branch`
- Parallel Group:
- Synchronization Point:
- Merge Owner:
- Output Isolation:
- Constraints:
- Inputs:
- Outputs:
- Publish To Sources:
- Learning:
- Depends On:
- Subagent / Branch Scope:
- Merge / Sync Rule:
- Completion Criteria:
- Failure Policy: `retry / rework / stop / escalate-to-reflection`
- Instructions:

### Step 2
- Name:
- Goal:
- Capability:
- Dispatch Mode: `sequential / subagent / parallel-branch`
- Parallel Group:
- Synchronization Point:
- Merge Owner:
- Output Isolation:
- Constraints:
- Inputs:
- Outputs:
- Publish To Sources:
- Learning:
- Depends On:
- Subagent / Branch Scope:
- Merge / Sync Rule:
- Completion Criteria:
- Failure Policy: `retry / rework / stop / escalate-to-reflection`
- Instructions:

### Step N
- Name:
- Goal:
- Capability:
- Dispatch Mode: `sequential / subagent / parallel-branch`
- Parallel Group:
- Synchronization Point:
- Merge Owner:
- Output Isolation:
- Constraints:
- Inputs:
- Outputs:
- Publish To Sources:
- Learning:
- Depends On:
- Subagent / Branch Scope:
- Merge / Sync Rule:
- Completion Criteria:
- Failure Policy: `retry / rework / stop / escalate-to-reflection`
- Instructions:

## Handoffs
- how `Step`s hand off through files
- how parallel branches merge
- which synchronization points are mandatory

## Completion Check
- what must be true before the task is considered complete
```

## Execution Rules

- the `Capability` field must contain exactly one main capability
- the `Constraints` field must explicitly list the constraint files that must be read before that `Step` runs
- `Outputs` must prefer `tasks/{task-id}/_output/` or `tasks/{task-id}/cache/`
- only intermediate handoff files may be written exclusively into `tasks/{task-id}/cache/`
- at least one final-output `Step` must write into `tasks/{task-id}/_output/`
- `Publish To Sources` must not be omitted; use `none` when there is no publish-back
- if multiple capabilities are needed, split the work into multiple `Step`s
- the `Learning` field must explicitly be `required / optional / not-needed`
- `Depends On` must not be omitted; use `none` when there is no dependency
- `Completion Criteria` must not be omitted; it must be written as checkable conditions
- `Failure Policy` must not be omitted; the only allowed values are `retry / rework / stop / escalate-to-reflection`
- `Dispatch Mode` must not be omitted; the only allowed values are `sequential / subagent / parallel-branch`
- `Parallel Group` must not be omitted; use `none` when there is no parallelism
- `Synchronization Point` must not be omitted; use `none` when there is no synchronization
- `Merge Owner` must not be omitted; use `none` when there is no merge
- `Output Isolation` must not be omitted; it must clearly define the isolated output rule of that `Step`
- if `Dispatch Mode` is `subagent`, the decomposition boundary, per-subagent output locations, and merge method must be explicit
- if `Dispatch Mode` is `parallel-branch`, the parallel group, synchronization point, and merge-responsible `Step` must be explicit
- parallel `Step`s must not write to the same undeclared shared output path
- `Instructions` must be executable actions, not abstract slogans
