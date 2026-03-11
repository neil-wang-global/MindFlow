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

## Approved Knowledge Reads
- the `kb-*.md` file paths actually read in this task

## Read Scope Notes
- why these reads are relevant to the current task
- which knowledge is treated as key constraints

## Excluded Areas
- explicitly list the excluded areas:
  - `mind/learning/knowledge-base/drafts/`
  - `mind/learning/knowledge-base/archived/`
  - `mind/learning/task-learning/`
  - `mind/learning/reviews/`
  - `mind/learning/capability-updates/`
```

## Validation Rules

- `Soul Reads` must not be omitted
- `Approved Knowledge Reads` may be empty, but the heading must remain; use `none` when there is no match
- `Read Scope Notes` must not be omitted
- `Excluded Areas` must list the full required set
