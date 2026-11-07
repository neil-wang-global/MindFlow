# drafts

This is the pending knowledge area. It is not a free dumping area.

`draft-{type}-{task-id}-{slug}.md` files are runtime artifacts: they live in this directory under the Runtime Root, and the repository contains no drafts.

Paths in this module are relative to the Runtime Root (see `SYSTEM.md §Runtime Layout`); paths naming `README.md` / `TEMPLATE.md` files resolve against the Protocol Root.

## File Naming Rule

`draft-{type}-{task-id}-{slug}.md`

Where:

- `{type}` may only be `concept / method / domain / self`
- `{task-id}` must match the source task
- `{slug}` must match the knowledge topic

## Template and Rules

See `TEMPLATE.md` for the formal structure, required fields, validation rules, and promotion conditions.

## Fixed Rules

- every file must come from a clearly identified `Task` and a `tl-{task-id}.md`
- every file must be prepared to enter `reviews/`
- not readable by `Learning(Read)` (see `mind/learning/learning-read/README.md §Read Scope`)
- if a later `Review` accepts the draft, a `kb-{type}-{slug}.md` is generated from it and written into `approved/`; the original `draft-*.md` remains in `drafts/` as a traceability record
- if a later `Review` rejects the draft, the `draft-*.md` is moved from `drafts/` to `archived/` (see `reviews/TEMPLATE.md §Rejected Decision Handling`)
- if a later `Review` defers the draft, the `draft-*.md` remains in `drafts/` until a subsequent task re-opens the review
