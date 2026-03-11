`Task Profile` is the only formal output of `Recognition`.  
Every task must produce it before `Analysis` may continue.

## File Requirements

- file path: `tasks/{task-id}/task-profile.md`
- fixed heading order is required
- conclusions must appear before explanation

## Formal Template

```md
# Task Profile

## Task ID
- current task ID

## Task Type
- `delivery / learning / mixed`

## Goal
- explain in 2-5 sentences what this task is trying to accomplish

## Inputs
- known input files for the current task

## Success Criteria
- criteria that determine whether the task is complete

## Required Reads
- must read before running `Recognition`:
  - `tasks/{task-id}/learning-read.md`

## Complexity
- `low / medium / high`

## Risk
- `low / medium / high`

## Capability Needs
- what categories of capability are needed for the current task

## Constraints
- known boundaries
- known prohibitions
- known format requirements

## Step-level Learning Possibility
- whether some later `Step` may require temporary `Learning`

## Inference Possibility
- whether `Inference` may be needed

## Notes
- only additional notes required at the recognition stage
```

## Validation Rules

- `Required Reads` must not be omitted
- if the task goal itself is learning, `Task Type` must not be `delivery`
- if inputs are severely insufficient, that must be explicitly stated in `Constraints`
- if the task may drift, `Risk` must not be set to low
