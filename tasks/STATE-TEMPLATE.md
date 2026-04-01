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
- active phases: `learning-read / recognition / analysis / planning / execution-control / learning-acquire / reflection / terminal-learning`
- terminal states: `completed / cancelled` (set only by terminal `Learning` upon task conclusion — see `SYSTEM.md §Phase Transition Protocol` step 4)
- note: in compact mode, `planning` may be skipped — the runtime transitions directly from `analysis` to `execution-control` (see `mind/analysis/README.md §Compact Mode`)

## Current Step
- the `Step` currently being executed
- write `none` when there is no active step

## Overall Status
- `running / blocked / failed / completed / cancelled`
- note: when terminal `Learning` completes, `Current Phase` and `Overall Status` are set as a pair per `SYSTEM.md §Phase Transition Protocol` step 4: `completed → completed/completed`; `cancelled → cancelled/cancelled`; `failed → completed/failed`; `blocked → completed/blocked` (format: `Current Phase / Overall Status`)

## Knowledge Outcome
- `fully-acquired / partially-acquired / not-acquired / not-applicable`
- `fully-acquired`: all ACQ events completed successfully (all stages passed)
- `partially-acquired`: at least one ACQ event completed successfully, but one or more were exhausted
- `not-acquired`: all ACQ events were exhausted, or no ACQ was triggered despite the task expecting external knowledge acquisition
- `not-applicable`: no ACQ was expected or required (e.g., delivery-only tasks, tasks with `Learning: not-needed` or `Learning: terminal-only` on all Steps)
- this field is set by terminal `Learning` based on `tl-{task-id}.md §External Acquisition` results — see `mind/learning/README.md §Knowledge Outcome Determination`

## Step Status Map
- `Step 1: pending / running / completed / failed / blocked`
- `Step 2: pending / running / completed / failed / blocked`

## Parallel Branch Status
- write `none` when there is no parallel branch
- when parallel branches exist, use this format:
  - `Branch {label} (Steps {N},{M}): pending / running / completed / blocked`
  - `Synchronization Point: Step {X} — waiting / ready`

## Last Failure
- the most recent failure point
- write `none` when there has been no failure

## Retry Count
- total retry count for the current task

## Ready For Reflection
- `yes / no`

## Learning(Acquire) Log
- records the outcome of every `Learning(Acquire)` event in this task:
  - **Step-triggered (acquire-required)**: `Step {N}: pending` (placeholder added by Pre-Step Verification) → updated to `Step {N}: gap-encountered → ACQ-{NNN} triggered` | `Step {N}: no-gap → skipped (reason: {explicit reason})`
  - **Step-triggered (optional)**: uses the same format as acquire-required; the only difference is that a `skipped` entry is not required when no gap is encountered (per `mind/execution-control/README.md §Pre-Step Verification`)
  - **Reflection-triggered**: `Reflection: external-acquisition-required → ACQ-{NNN} triggered` | `Reflection: no-external-acquisition-required`
- when an ACQ event is in progress, append the current stage: `ACQ-{NNN}: stage-1-search-complete` / `ACQ-{NNN}: stage-2-fetch-complete` / `ACQ-{NNN}: stage-3-verification-complete`
- write `none` if no Step has `Learning: acquire-required` or `Learning: optional`, and reflection did not require external acquisition
```

## Initialization Rules

`state.md` is created at the start of `Learning(Read)` — the very first stage of every task.

### Initial Creation (by Learning(Read))

- `Task ID`: the current task ID
- `Current Phase`: `learning-read`
- `Current Step`: `none`
- `Overall Status`: `running`
- `Step Status Map`: `pending — not yet planned`
- `Parallel Branch Status`: `none`
- `Last Failure`: `none`
- `Retry Count`: `0`
- `Ready For Reflection`: `no`
- `Knowledge Outcome`: `not-applicable`
- `Learning(Acquire) Log`: `none`

### Step Status Map Initialization (by Planning)

When `Planning` completes and `plan.md` is written, `Planning` must update `state.md`:

- set `Current Phase: execution-control`
- set `Current Step` to Step 1
- populate `Step Status Map` with one entry per Step from `plan.md`, each set to `pending`

### Phase Transitions

See `SYSTEM.md §Phase Transition Protocol` for the complete transition sequence. Each module is responsible for setting its own phase upon entry.

## Validation Rules

- `Current Phase` must not be omitted; must be one of the defined values
- `Overall Status` must not be omitted; must be one of the defined values
- `Step Status Map` must not be omitted
- `Ready For Reflection` may only be `yes / no`
- `Knowledge Outcome` must not be omitted; must be one of `fully-acquired / partially-acquired / not-acquired / not-applicable`; terminal `Learning` must set the final value based on ACQ results before setting the terminal state; when any ACQ event has status `exhausted`, `Knowledge Outcome` must not be `fully-acquired`
- `Learning(Acquire) Log` must not be omitted
- for every Step with `Learning: acquire-required`, a corresponding Step-triggered entry must appear before that Step is marked `completed`
- for Steps with `Learning: optional`, a Step-triggered entry is required only if `Learning(Acquire)` was actually triggered during that Step; no entry is required if no gap was encountered
- if `reflection-report.md` sets either `Requires External Acquisition` to `yes`, a Reflection-triggered entry must appear before terminal `Learning` begins
- a Step-triggered `skipped` entry must include an explicit reason
- each triggered entry must record the ACQ-{NNN} label; label consistency rules: see `SYSTEM.md §ACQ Label Consistency Rule`
