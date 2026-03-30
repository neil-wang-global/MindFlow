# capability-updates

This directory stores `Capability Update` records.

These files are not direct capability definitions. They are formal change records derived from learning.

## File Naming Rule

`cu-{task-id}-{capability-name}.md`

## Template and Rules

See `TEMPLATE.md` for the formal structure, required fields, and validation rules.

## Advancement Rules

A capability update with `Status: proposed` or `Status: approved` is a pending cross-task item. Advancement rules are defined in `SYSTEM.md §Capability Update Advancement`.

## Fixed Rules

- `Capability Update` must be traceable back to a concrete task and a concrete review record
- `Capability Update` must not claim to be `applied` without evidence
- any update with `Status: applied` must already correspond to a real change in the target capability file
- reflection-triggered capability updates must be created with `Status: proposed` and must not be advanced within the same task — see `TEMPLATE.md §Validation Rules` for the full constraint
