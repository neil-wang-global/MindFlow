# tasks

This directory stores task instance directories.

## Directory Naming Rule

Task directory names are fixed to:

`tasks/{task-id}/`

Where `task-id` must use:

`YYYYMMDD-short-name`

## Fixed Files

- `learning-read.md`
- `state.md`
- `plan.md`
- `cache/`
- `task-profile.md`
- `analysis.md`
- `reflection-report.md`
- `_output/`

## Task-External Related Files

The following files do not live inside `tasks/{task-id}/`, but must correspond one-to-one with the current task:

- `mind/learning/task-learning/tl-{task-id}.md`
- `mind/learning/knowledge-base/drafts/draft-{type}-{task-id}-{slug}.md`
- `mind/learning/reviews/review-{task-id}-{slug}.md`
- `mind/learning/capability-updates/cu-{task-id}-{capability-name}.md`

## Constraints

- every task must generate a new `Plan`
- old task directories must not be reused
- task instance content must not be written back into shared template directories
- `learning-read.md` is the formal audit record of `Learning(Read)`
- `state.md` is the only formal runtime state file of the task
  - the initial file is created by `Execution`, then continuously maintained by `Execution Control`
- final results default to `tasks/{task-id}/_output/`
- `tasks/{task-id}/_output/` must not be empty when the task is complete
- results may be synchronized into `sources/` only when `Plan` explicitly declares a publish-back path
- a task directory missing required fixed files is considered incomplete
