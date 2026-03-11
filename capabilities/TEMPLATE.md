# Capability Template

Every `Capability` must use the fixed template below.  
It is a stable action unit, not a free-form prose file.

## File Requirements

- fixed file path: `capabilities/cap-{capability-name}.md`
- one file defines exactly one capability
- heading order is fixed

## Formal Template

```md
# {Capability Name}

## Purpose
- the one core purpose of this capability

## Use When
- when this capability is allowed to be called

## Do Not Use When
- when this capability is forbidden

## Inputs
- required input files
- optional input files
- input format requirements

## Constraints
- which constraint files must be read before running this capability
- which constraints come from `Soul`
- which constraints come from the current `Step`

## Outputs
- output files
- output purpose

## Step Contract
- what the `Step` must provide when calling this capability
- what the `Step` can expect after execution finishes

## Execution Rules
- what is allowed
- what is forbidden
- whether overwriting existing files is allowed

## Skill Loading
- whether loading a skill is allowed
- what kinds of skills may be loaded
- what constraints a loaded skill must satisfy

## Failure Handling
- what counts as failure
- what must be output on failure
- whether partial completion is allowed

## Observability
- how to determine that this capability ran successfully
- what observable signals should be recorded

## Known Failure Patterns
- common failure modes
- which inputs are most likely to trigger failure

## Parallel Safety
- whether this capability is safe for parallel execution
- what isolation conditions are required for parallel execution
```

## Authoring Rules

- `Purpose` must describe exactly one core action, not a broad all-in-one capability
- `Use When` and `Do Not Use When` must both exist
- `Inputs` and `Outputs` must explicitly name files
- `Constraints` must not be omitted
- `Failure Handling` must not be omitted
- `Observability` must not be omitted
- `Known Failure Patterns` must not be omitted
- `Parallel Safety` must not be omitted
