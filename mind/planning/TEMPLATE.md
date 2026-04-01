`Plan` is the only formal output of `Planning`.
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

## Global Constraints
- global constraints for this task
- default final result directory: `tasks/{task-id}/_output/`
- if publish-back to `sources/` is needed, it must be explicitly declared in the corresponding `Step`

### Step 1
- Name:
- Goal:
- Capability:
- Dispatch Mode: `sequential / subagent / parallel-branch`
- Parallel Group: (omit if Dispatch Mode is sequential)
- Synchronization Point: (omit if Dispatch Mode is sequential)
- Merge Owner: (omit if Dispatch Mode is sequential)
- Output Isolation:
- Constraints:
- Inputs:
- Outputs:
- Publish To Sources:
- Learning: `acquire-required / terminal-only / optional / not-needed`
- Depends On:
- Subagent / Branch Scope: (omit if Dispatch Mode is sequential)
- Merge / Sync Rule: (omit if Dispatch Mode is sequential)
- Completion Criteria:
- Failure Policy: `retry / rework / stop / escalate-to-reflection`
- Instructions:

### Step N
(same structure as Step 1)

## Step Independence Matrix
(required only when the Plan has 3 or more Steps AND at least 3 Steps have `Learning: acquire-required`; omit this section otherwise)

| Step Pair | Distinction | Overlap Assessment |
|-----------|------------|-------------------|
| Step 1 vs Step 2 | how their learning goals differ | no-overlap / low-overlap / merge-required |
| Step 1 vs Step 3 | ... | ... |
| Step 2 vs Step 3 | ... | ... |

## Handoffs
- how `Step`s hand off through files
- how parallel branches merge (if applicable)

## Completion Check
- what must be true before the task is considered complete
```

## Planning Rules

- `Task ID` must not be omitted; must match the current task
- `Goal` must not be omitted
- `Runtime State` must not be omitted; must reference `tasks/{task-id}/state.md`
- `Global Constraints` must not be omitted
- `state.md` already exists (created by `Learning(Read)`); after `plan.md` is written, `Planning` must update `state.md` to populate `Step Status Map` and transition phase (see `mind/planning/README.md §Phase Entry`)
- the `Capability` field must contain exactly one main capability
- the `Constraints` field must explicitly list the constraint files that must be read before that `Step` runs
- `Outputs` must prefer `tasks/{task-id}/_output/` or `tasks/{task-id}/cache/`
- at least one final-output `Step` must write into `tasks/{task-id}/_output/`
- `Publish To Sources` must not be omitted; use `none` when there is no publish-back
- if multiple capabilities are needed, split the work into multiple `Step`s
- `Learning` must be one of `acquire-required / terminal-only / optional / not-needed`
  - `acquire-required`: this Step may encounter a knowledge gap; if it does, `Learning(Acquire)` must be triggered; when the Step completes, record in `state.md` whether acquisition was triggered or skipped with explicit reason
  - `terminal-only`: learning captured at terminal Learning from task-internal artifacts only
  - `optional`: learning may occur but is not mandatory; if a knowledge gap is encountered during execution, `Learning(Acquire)` may be triggered using the same mid-step mechanism as `acquire-required` (see `mind/execution-control/README.md §Pre-Step Verification`)
  - `not-needed`: no learnable knowledge expected
- `Depends On` must not be omitted; use `none` when there is no dependency
- `Completion Criteria` must be written as objectively checkable conditions — each condition must reference a specific observable artifact, state, or measurable outcome (e.g., "file X exists", "test passes", "output contains Y"); tautological conditions like "step is complete" are not valid
- `Failure Policy` must be one of `retry / rework / stop / escalate-to-reflection`
- `Dispatch Mode` must be one of `sequential / subagent / parallel-branch`
- when `Dispatch Mode` is `sequential`: `Parallel Group`, `Synchronization Point`, `Merge Owner`, `Subagent / Branch Scope`, and `Merge / Sync Rule` may be omitted (they default to `none`)
- when `Dispatch Mode` is `subagent`: decomposition boundary, per-subagent output locations, and merge method must be explicit
- when `Dispatch Mode` is `parallel-branch`: parallel group, synchronization point, and merge-responsible `Step` must be explicit
- parallel `Step`s must not write to the same undeclared shared output path
- `Instructions` must be executable actions, not abstract slogans
- if a Step's `Learning` value differs from `analysis.md §Step-level Learning Need`, the reason must be stated in `Instructions`
- each Step must have a `Name` field
- `Output Isolation` must not be omitted
- `Handoffs` must not be omitted; for single-step tasks, write `single-step task — no inter-step handoff`
- `Completion Check` (plan-level) must not be omitted

### Step Independence Check

When the Plan has 3 or more Steps and at least 3 of those Steps have `Learning: acquire-required`, the `## Step Independence Matrix` section is mandatory:

- for each pair of `acquire-required` Steps (i, j), declare how their learning goals differ
- `Overlap Assessment` must be one of: `no-overlap`, `low-overlap`, `merge-required`
- if any pair is assessed as `merge-required`, the Steps must be merged before the Plan is finalized — a Plan with unresolved `merge-required` pairs is invalid
- `low-overlap` is acceptable only when the overlapping area is less than ~30% of both Steps' scope and serves a different analytical purpose in each Step
- this check prevents multi-step learning tasks from producing redundant knowledge across Steps
