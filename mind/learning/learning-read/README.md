# learning-read

This directory defines the formal audit record of `Learning(Read)`.

`Learning(Read)` is a read-only stage with respect to formal knowledge sources, but it must leave a formal record showing exactly which constraints and knowledge were loaded.

## Phase Entry

`Learning(Read)` is the first stage of every task. It creates `state.md` with `Current Phase: learning-read`.

## Read Scope

`Learning(Read)` may only read:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`

It must also scan for pending cross-task items (read-only inspection — not as knowledge sources, but findings may trigger mandatory maintenance steps in the Plan per `SYSTEM.md §Capability Update Advancement` and `§Deferred Review Advancement`):

- `mind/learning/capability-updates/` — files with `Status: proposed` or `Status: approved`
- `mind/learning/reviews/` — files with `Decision: deferred`

It must not read for knowledge purposes:

- `mind/learning/knowledge-base/drafts/`
- `mind/learning/knowledge-base/archived/`
- `mind/learning/task-learning/`

## Write Scope

`Learning(Read)` may write only:

- `tasks/{task-id}/learning-read.md`
- `tasks/{task-id}/state.md` (initial creation)

## Outputs

- `tasks/{task-id}/state.md` (initial creation — see `tasks/STATE-TEMPLATE.md §Initialization Rules`)
- `tasks/{task-id}/learning-read.md` (see `TEMPLATE.md` for structure)

`state.md` is created first so that the task is immediately recoverable. `learning-read.md` is the formal audit record.

## Recording Requirements

`learning-read.md` must record at least:

- the `Soul` files read
- the approved knowledge files read (or `none`)
- why those reads are relevant to the current task
- pending cross-task items found (or `none`)
- the excluded areas (always the same three directories)

`learning-read.md` must record files that were actually read, not abstract statements like "knowledge base consulted".

## Fixed Rules

- `learning-read.md` must be generated before `task-profile.md`
- any task chain missing `learning-read.md` is considered incomplete
