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
- **Capability Updates**: list any `cu-*.md` files in `mind/learning/capability-updates/` with `Status: proposed` or `Status: approved`; write `none` if empty
- **Deferred Reviews**: list any `review-*.md` files in `mind/learning/reviews/` with `Decision: deferred`; write `none` if empty
- **Same-Context Rejections**: count `review-*.md` files in `mind/learning/reviews/` with `Verification Mode: same-context`; write the count; if count meets the threshold in `SYSTEM.md §Cross-Task Staleness Thresholds` for Same-Context Rejections, write `human-review-escalation-trigger: yes`; otherwise write `human-review-escalation-trigger: no`
- **Knowledge Gaps**: list any `gap-*.md` files in `mind/learning/knowledge-gaps/` with `Status: open`; write `none` if empty; also count those whose `Exhaustion Reason` contains `independent verification unavailable`; if count meets the threshold in `SYSTEM.md §Cross-Task Staleness Thresholds` for ACQ Verification Gaps, write `human-verification-escalation-trigger: yes`; otherwise write `human-verification-escalation-trigger: no`
- write `none` for the entire section only if all four sub-categories are empty

## Excluded Areas
- `mind/learning/knowledge-base/drafts/`
- `mind/learning/knowledge-base/archived/`
- `mind/learning/task-learning/`
```

## Validation Rules

- `Task ID` must not be omitted; must match the current task
- `Soul Reads` must not be omitted
- `Approved Knowledge Reads` may be empty, but the heading must remain; use `none` when there is no match
- `Read Scope Notes` must not be omitted
- `Pending Cross-Task Items` must not be omitted; use `none` when there are no pending items
- `Excluded Areas` must list the full required set: `mind/learning/knowledge-base/drafts/`, `mind/learning/knowledge-base/archived/`, `mind/learning/task-learning/`
