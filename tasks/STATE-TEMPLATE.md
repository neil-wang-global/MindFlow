# Task State Template

This file defines the fixed structure of the task runtime state file.

## File Naming Rule

- file path: `tasks/{task-id}/state.md`
- `{task-id}` must match the current task

## Fixed Structure

```md
# Task State

## Task ID
- current task ID

## Current Phase
- `learning-read / recognition / analysis / execution / execution-control / reflection / terminal-learning / completed / blocked`
- note: `terminal-learning` is the post-Reflection terminal Learning stage; `learning-read` is the pre-Recognition Learning(Read) stage; these are distinct phases and must not share the same label

## Current Step
- the `Step` currently being executed
- write `none` when there is no active step

## Overall Status
- `pending / running / blocked / failed / completed`

## Step Status Map
- `Step 1: pending / running / completed / failed / blocked`
- `Step 2: pending / running / completed / failed / blocked`

## Parallel Branch Status
- runtime status of parallel branches
- write `none` when there is no parallel branch

## Last Failure
- the most recent failure point
- write `none` when there has been no failure

## Retry Count
- total retry count for the current task

## Ready For Reflection
- `yes / no`

## Learning(Acquire) Log
- records the outcome of every `Learning(Acquire)` event in this task, from both trigger sources:
  - **Step-triggered**: one entry per Step whose `Learning` field is `acquire-required`
    - format: `Step {N}: gap-encountered → ACQ-{NNN} triggered` | `Step {N}: no-gap → skipped (reason: {explicit reason})`
  - **Reflection-triggered**: one entry if `reflection-report.md` set either `Requires External Acquisition` to `yes`
    - format: `Reflection: external-acquisition-required → ACQ-{NNN} triggered` | `Reflection: no-external-acquisition-required`
- write `none` if no Step has `Learning: acquire-required` and reflection did not require external acquisition
```

## Validation Rules

- `Current Phase` must not be omitted; must be one of: `learning-read / recognition / analysis / execution / execution-control / reflection / terminal-learning / completed / blocked`
- `Overall Status` must not be omitted
- `Step Status Map` must not be omitted
- `Ready For Reflection` may only be `yes / no`
- `Learning(Acquire) Log` must not be omitted
- for every Step with `Learning: acquire-required`, a corresponding Step-triggered entry must appear in `Learning(Acquire) Log` before that Step is marked `completed`
- if `reflection-report.md` sets either `Requires External Acquisition` to `yes`, a Reflection-triggered entry must appear in `Learning(Acquire) Log` before terminal `Learning` begins
- a Step-triggered entry of `skipped` must include an explicit reason; `skipped (reason: none)` is not valid
- each triggered entry must record the ACQ-{NNN} label assigned to that event; the label must match the corresponding entry in `tl-{task-id}.md` and `search-log.md`
