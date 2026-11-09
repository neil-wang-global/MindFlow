# tasks

This file is a navigation aid for human readers. The runtime does not load this file.

This directory stores task instance directories.

`tasks/` belongs to the Runtime Root, which is not under git — see `SYSTEM.md §Runtime Layout`. The path is written as a bare relative path throughout the protocol and resolves against the Runtime Root, not the Protocol Root. The repository ships only the document templates in this directory (`README.md`, `TEMPLATE.md`, `STATE-TEMPLATE.md`, `EXAMPLE-TEMPLATE.md`) and the empty skeleton `templates/tasks/`; no task instance is ever created inside the Protocol Root.

## Directory Naming Rule

`tasks/{task-id}/`

Where `task-id` format is defined in `CONTRIBUTING.md §Task ID Format`.

## Runtime Root Record

Each `state.md` records the absolute Runtime Root path resolved for that task in `§Runtime Root`. Recovery, `Reflection`, and terminal `Learning` must use that record rather than the default location, so one task never writes across two runtime trees.

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
- for directory structure and file-level constraints, see `tasks/TEMPLATE.md §Constraints`
