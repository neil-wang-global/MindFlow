# capabilities

This directory stores all `Capability` definition files.

## File Naming Rule

`Capability` files must use the fixed naming pattern:

`cap-{capability-name}.md`

Examples:

- `cap-research.md`
- `cap-structured-writing.md`
- `cap-code-review.md`

## Fixed Rules

- a `Capability` is an action capability, not a top-level orchestrator
- a `Capability` performs work through file-based input and output
- a `Capability` may load a `Skill`
- a `Capability` is not a `Skill`
- every `Capability` must follow the fixed template
- a `Capability` is an action unit, not a process controller
- a `Capability` must not overreach to decide system learning or system updates
- if learning is needed, it must be explicitly triggered by `Mind` or `Step`
- every `Capability` must explicitly describe its observability, common failure patterns, and parallel safety

## Required Fields

Every `Capability` file must contain:

- `Purpose`
- `Use When`
- `Do Not Use When`
- `Inputs`
- `Constraints`
- `Outputs`
- `Step Contract`
- `Execution Rules`
- `Skill Loading`
- `Failure Handling`
- `Observability`
- `Known Failure Patterns`
- `Parallel Safety`

## Validation Rules

- any definition file whose name does not match `cap-{capability-name}.md` is invalid
- any definition file missing required fields is invalid
