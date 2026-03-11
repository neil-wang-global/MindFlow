# capability-updates

This directory stores `Capability Update` records.

These files are not direct capability definitions. They are formal change records derived from learning.

## File Naming Rule

Capability update files must use the fixed naming pattern:

`cu-{task-id}-{capability-name}.md`

## Required Fields

Every capability update record must contain:

- `Capability`
- `Update Type`
- `Reason`
- `Source`
- `Review Reference`
- `Target Capability File`
- `Planned Changes`
- `Applied Changes`
- `Validation`
- `Status`

## Fixed Rules

- `Capability Update` must be traceable back to a concrete task and a concrete review record
- `Capability Update` must not claim to be `applied` without evidence
- any update with `Status: applied` must already correspond to a real change in the target capability file
