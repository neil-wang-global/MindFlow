# reviews

This directory stores learning review records. It is the formal review area.

## File Naming Rule

`review-{task-id}-{slug}.md`

## Template and Rules

See `TEMPLATE.md` for the formal structure, required fields, validation rules, and decision lifecycle definitions.

## Prohibitions

- writing directly into `approved/` without a review record is forbidden
- `Decision: deferred` must not be treated as approval
- `Decision: rejected` must not be promoted
- a `deferred` review must not be left permanently unresolved; it must either be re-opened or explicitly converted to `rejected` in a subsequent review
