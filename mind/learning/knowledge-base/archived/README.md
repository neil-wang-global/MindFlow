# archived

This is the historical knowledge area. It stores knowledge files that have been replaced, retired, or kept only for traceability.

## File Naming Rules

This directory receives files from two scenarios:

### Superseded Approved Knowledge

When an `approved/` entry is superseded by a newer version:

- rename to: `kb-{type}-{slug}-superseded-by-{new-task-id}.md`
- before moving, add this field at the top of its `Source Lineage` section:
  ```
  - Superseded By: mind/learning/knowledge-base/approved/kb-{type}-{slug}.md
  - Superseded In Task: {new-task-id}
  ```
- remove the corresponding entry from `approved/INDEX.md`

### Rejected Drafts

When a `review-*.md` has `Decision: rejected` (per `reviews/TEMPLATE.md §Rejected Decision Handling`):

- move the `draft-*.md` from `drafts/` to `archived/` with its original filename unchanged
- no additional fields are required — the rejection reason is recorded in the corresponding `review-*.md`

## Fixed Rules

- not readable by `Learning(Read)` (see `mind/learning/learning-read/README.md §Read Scope`)
- may be inspected as historical reference only when explicitly requested by a human
- content must not be treated as current active knowledge
- files must not be deleted; they are permanent traceability records
- superseded `kb-*.md` files must not be moved here without first adding the `Superseded By` field
- rejected `draft-*.md` files may be moved here without additional fields
