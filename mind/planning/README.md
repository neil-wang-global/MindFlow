# planning

This directory defines the `Planning` module.

## Responsibilities

- materialize `Analysis Output` into formal `Plan`
- organize multiple `Step`s inside the `Plan`
- define inputs, outputs, capability calls, and handoff relationships
- define the dispatch mode of `Plan -> Steps`
- reuse the dispatch fields already declared in `Analysis` rather than inventing a second parallelism schema

## Phase Entry

Upon entering this module, set `state.md`: `Current Phase: planning`.

After `plan.md` is written:
- set `Current Phase: execution-control`
- populate `Step Status Map` from `plan.md`
- set `Current Step` to Step 1

## Required Reads

Before producing `plan.md`, the runtime must read:

- `mind/soul/core.md`
- `tasks/{task-id}/analysis.md`
- the relevant `Capability` definition files (if they exist in `capabilities/`)

## Inputs

- `Analysis Output`
- current task context
- available `Capabilities`

## Outputs

- `tasks/{task-id}/plan.md` (see `TEMPLATE.md` for structure)
- update `tasks/{task-id}/state.md`

## Key Principles

- every task generates a new `Plan`; old `Plan`s must not be reused
- `Step`s are organized through `Plan` and are advanced by `Execution Control`
- `Planning` must explicitly decide which work must remain sequential, which work is suitable for `subagent` parallelism, and which work should run as multiple parallel task branches
- parallelism is not the default, but when dependencies are clear, context is isolated, and outputs can be merged, the safest parallel mode should be preferred
- dispatch fields must remain consistent across `Analysis -> Plan -> Reflection` (see `SYSTEM.md §Dispatch Field Consistency`)

## Parallelism and Dispatch Rules

When generating a `Plan`, `Planning` must evaluate whether work should run in:

- sequential mode
- subagent-parallel mode inside one `Step`
- multi-task parallel mode across multiple `Step`s or task branches

Use sequential mode when:

- the next action depends on the previous action's output
- multiple actions compete for the same mutable artifact
- correctness depends on tight shared context

Use subagent-parallel mode when:

- the parent `Step` has one clear goal decomposable into independent sub-problems
- each subagent can work with isolated inputs and produce isolated outputs
- the parent `Step` can deterministically merge the results

Use multi-task parallel mode when:

- the task naturally splits into multiple independent work branches
- branches do not require hidden conversational coordination
- branch outputs can be validated and integrated through files

`Planning` must prefer the highest safe parallelism level, but must not force parallelism when coordination cost, conflict risk, or validation cost would outweigh the gain.
