# task-learning

This directory stores task-level `Learning Record`s.

It is not a free-note area. It is the task-level candidate knowledge area.

## File Naming Rule

Task-level learning records must use the fixed naming pattern:

`tl-{task-id}.md`

Example:

- `tl-20260311-ddd-learning.md`

## Required Fields

Every task-level learning record must contain:

- `Task ID`
- `Task Summary`
- `Candidate Knowledge`
- `Potential Capability Impact`
- `Next Promotion Target`

## Fixed Rules

- one `Task` may have only one primary `Learning Record`
- content in `task-learning/` must not be read by `Learning(Read)`
- content in `task-learning/` must first enter `drafts/`, then enter `reviews/`
- any task without `tl-{task-id}.md` is considered to have produced no task-level learning consolidation
- `tl-{task-id}.md` must always be written as part of terminal `Learning`, even when `reflection-report.md` has no learning candidates; in that case, write `Candidate Knowledge: none` and `Next Promotion Target: none` — skipping `tl-{task-id}.md` entirely is not permitted
