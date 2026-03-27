# tasks

This file is a navigation aid for human readers. The runtime does not load this file.

This directory stores task instance directories.

## Directory Naming Rule

`tasks/{task-id}/`

Where `task-id` format is defined in `CONTRIBUTING.md §Task ID Format`.

## Fixed Files

See `tasks/TEMPLATE.md` for the complete directory structure.

## Required Reads Map

This section is a navigation aid for human readers. The runtime loads each module's `README.md` on demand — it does not use this map for constraint loading. If any conflict exists between this map and a module's README, the module README is authoritative.

- `learning-read.md` → `mind/learning/learning-read/README.md` (reads: `mind/soul/core.md`, `mind/learning/knowledge-base/approved/`)
- `state.md` → created by `Learning(Read)`, populated by `Planning`, maintained by `Execution Control` (template: `tasks/STATE-TEMPLATE.md`)
- `task-profile.md` → `mind/recognition/README.md` (reads: `mind/soul/core.md`, `learning-read.md`)
- `analysis.md` → `mind/analysis/README.md` (reads: `mind/soul/core.md`, `learning-read.md`, `task-profile.md`, `capabilities/`)
- `plan.md` → `mind/planning/README.md` (reads: `mind/soul/core.md`, `analysis.md`, `learning-read.md`, capability files)
- `reflection-report.md` → `mind/reflection/README.md` (reads: `mind/soul/core.md`, `learning-read.md`, `task-profile.md`, `state.md`, `plan.md`, `cache/`, `_output/`)
- `acquire/verification-report.md` → `mind/learning/acquire/README.md` (created only when `Learning(Acquire)` is triggered)
- `tl-{task-id}.md` → `mind/learning/README.md` (reads: `reflection-report.md`, `task-profile.md`, `plan.md`, `state.md`, `_output/`, `cache/`, `acquire/verification-report.md`)

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
