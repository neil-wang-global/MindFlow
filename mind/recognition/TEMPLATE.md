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

## Task-level Learning Possibility
- `acquire-likely`: this task is likely to require external knowledge acquisition during execution
- `terminal-only`: learning from this task will come from task-internal artifacts only
- `not-expected`: no significant learnable knowledge expected from this task
- this declaration is advisory and task-level only; Step-level Learning declarations are made in `Analysis`

## Mode
- `standard` — normal full-phase flow
- `compact` — compressed artifacts; only valid when `Complexity: low` and `Risk: low` (see `SYSTEM.md §Compact Mode` for full eligibility rules)

## Inference Possibility
- whether `Inference` may be needed

## Notes
- only additional notes required at the recognition stage
```

## Validation Rules

- if the task goal itself is learning, `Task Type` must not be `delivery`
- if inputs are severely insufficient, that must be explicitly stated in `Constraints`
- if the task may drift, `Risk` must not be set to low
- `Mode` must be `standard` or `compact`; `compact` is only valid when both `Complexity: low` and `Risk: low`
- `Mode` must not be omitted
