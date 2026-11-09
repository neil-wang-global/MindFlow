# reviews

This directory stores learning review records. It is the formal review area.

`review-{task-id}-{slug}.md` files are runtime artifacts: they live in this directory under the Runtime Root, and the repository contains no review records.

Paths in this module are relative to the Runtime Root (see `SYSTEM.md §Runtime Layout`); paths naming `README.md` / `TEMPLATE.md` files resolve against the Protocol Root.

## File Naming Rule

`review-{task-id}-{slug}.md`

## Template and Rules

See `TEMPLATE.md` for the formal structure, required fields, validation rules, and decision lifecycle definitions.

## Prohibitions

- writing directly into `approved/` without a review record is forbidden
- `Decision: deferred` must not be treated as approval
- `Decision: rejected` must not be promoted
- a `deferred` review must not be left permanently unresolved; it must either be re-opened or explicitly converted to `rejected` in a subsequent review
