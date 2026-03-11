# execution-control

This directory defines the `Execution Control` module.

`Execution Control` is not a new top-level center, and it is not an independent persona.

It is the runtime control responsibility inside `Mind`. Its job is to advance the generated `Plan` into actual task execution.

## Responsibilities

- advance `Step`s according to `Plan`
- check whether each `Step`'s prerequisites are satisfied before execution
- manage sequential execution, `subagent` parallelism, and branch parallelism according to `Dispatch Mode`
- manage branch merge and synchronization points
- check whether each `Step` has reached its completion criteria
- decide whether failure should trigger retry, rework, termination, or return to an upstream module
- hand stable runtime results to `Reflection`

## Inputs

- the current `Task`'s `state.md`
- the current `Task`'s `plan.md`
- the current `Task`'s `cache/`
- the current `Task`'s `_output/`
- the `Capability` definition files referenced by the current `Plan`

## Required Constraint Loading Before Execution

Before running `Execution Control`, the agent must read:

- `mind/soul/core.md`
- the current `Task`'s `state.md`
- the current `Task`'s `plan.md`
- the `Capability` definition files referenced by the current `Plan`

## Outputs

`Execution Control` does not create a new standalone formal artifact.

Its responsibility is to ensure:

- `state.md` accurately reflects the current phase, current step, branch state, and failure state
- `Plan` is executed under its declared constraints
- `cache/` contains the correct intermediate handoff files
- `_output/` contains the correct final result files
- parallel branches are merged exactly as declared in `Plan`

## Key Principles

- do not rewrite `Plan`
- do not replace `Execution`
- do not replace `Reflection`
- do not bypass `Step`
- do not bypass `Capability`
- do not replace file-based handoff with implicit context
- do not leave parallel decisions to ad hoc runtime judgment
