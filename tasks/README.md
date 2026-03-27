# tasks

This file is a navigation aid for human readers. The runtime does not load this file.

This directory stores task instance directories.

## Directory Naming Rule

`tasks/{task-id}/`

Where `task-id` format is defined in `CONTRIBUTING.md §Task ID Format`.

## Fixed Files

See `tasks/TEMPLATE.md` for the complete directory structure.

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
- `state.md` is the only formal runtime state file
- `_output/` must not be empty when the task is complete
- results may be published to `sources/` only when `Plan` explicitly declares it
- a task directory missing required fixed files is considered incomplete
