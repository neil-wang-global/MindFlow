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
- `learning-read / recognition / analysis / execution / execution-control / reflection / learning / completed / blocked`

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
```

## Validation Rules

- `Current Phase` must not be omitted
- `Overall Status` must not be omitted
- `Step Status Map` must not be omitted
- `Ready For Reflection` may only be `yes / no`
