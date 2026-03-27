# Learning(Read) Audit Template

This file defines the fixed structure of `Learning(Read)`.

## File Naming Rule

- file path: `tasks/{task-id}/learning-read.md`
- `{task-id}` must match the current task

## Fixed Structure

```md
# Learning(Read) Audit

## Task ID
- current task ID

## Soul Reads
- the `Soul` file paths actually read in this task
- if all fields in `core.md` are "To be defined", record: "Soul constraints not yet configured — no Soul constraints applied to this task"

## Approved Knowledge Reads
- the `kb-*.md` file paths actually read in this task
- when `approved/` is empty or `INDEX.md` does not exist, write `none`

## Read Scope Notes
- why these reads are relevant to the current task
- which knowledge is treated as key constraints

## Pending Cross-Task Items
- list any `cu-*.md` files in `mind/learning/capability-updates/` with `Status: proposed` or `Status: approved`
- list any `review-*.md` files in `mind/learning/reviews/` with `Decision: deferred`
- list any `gap-*.md` files in `mind/learning/knowledge-gaps/` with `Status: open`
- write `none` if no pending items exist

## Excluded Areas
- `mind/learning/knowledge-base/drafts/`
- `mind/learning/knowledge-base/archived/`
- `mind/learning/task-learning/`
```

## Validation Rules

- `Soul Reads` must not be omitted
- `Approved Knowledge Reads` may be empty, but the heading must remain; use `none` when there is no match
- `Read Scope Notes` must not be omitted
- `Pending Cross-Task Items` must not be omitted; use `none` when there are no pending items
- `Excluded Areas` must list the full required set
