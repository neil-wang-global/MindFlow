# Capability Update Record Template

This file defines the fixed structure of `Capability Update Record`.

## File Naming Rule

- file path: `mind/learning/capability-updates/cu-{task-id}-{capability-name}.md`
- `{task-id}` must match the source task
- `{capability-name}` must match the affected capability

## Fixed Structure

```md
# Capability Update Record

## Capability
- affected capability

## Update Type
- `add / modify / split / deprecate`

## Reason
- why this update is needed

## Source
- source `Task` or `Learning Record`

## Review Reference
- corresponding `review-*.md` — if this capability update was triggered by an accepted knowledge review
- write `reflection-triggered: tasks/{task-id}/reflection-report.md §Capability Impact` — if this update was triggered directly by `Reflection` without a corresponding knowledge review (e.g., process or structural capability changes that do not go through the knowledge promotion path)
- this field must not be omitted; it must always identify the authoritative source that justified the capability change

## Target Capability File
- target capability file path

## Planned Changes
- what is planned to change

## Applied Changes
- what has actually been applied
- write `none` when not yet applied

## Validation
- how to confirm that the change has entered the target capability file
- write `none` when not yet validated

## Status
- `proposed / approved / applied`
```

## Validation Rules

- `Review Reference` must not be omitted; must be either a `review-*.md` path or a `reflection-triggered: ...` pointer — it may not be `none`
- `Target Capability File` must not be omitted
- `Planned Changes` must not be omitted
- `Status` may only be `proposed / approved / applied`
- when `Status: proposed`, `Applied Changes` and `Validation` must be `none`
- when `Status: approved`, `Applied Changes` and `Validation` may be `none`
- when `Status: applied`, the corresponding `Capability` file update must already be complete, and `Applied Changes` and `Validation` must not be `none`
