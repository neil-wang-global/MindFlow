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
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/analysis.md`
- `tasks/{task-id}/learning-read.md` (for `§Pending Cross-Task Items` — if `Analysis` identified mandatory maintenance Steps, `Planning` must include them in `plan.md`)
- the relevant `Capability` definition files (if they exist in `capabilities/`)

## Inputs

- `Analysis Output`
- current task context
- available `Capabilities`

## Outputs

- `tasks/{task-id}/plan.md` (see `TEMPLATE.md` for structure)
- update `tasks/{task-id}/state.md`

## Plan Output Rules

See `TEMPLATE.md §Planning Rules` for the full set of output path rules. Key points:

- Default formal result directory: `tasks/{task-id}/_output/`
- Intermediate handoff files go to: `tasks/{task-id}/cache/`

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

## Pre-Write Verification

Before writing `plan.md`, verify that `analysis.md §Step-level Learning Need` values are carried forward consistently into each Step's `Learning` field. On failure: fix the inconsistency in `plan.md` before writing it.

## Exit Validation

Before transitioning out of `Planning` (i.e., before setting `Current Phase: execution-control`), verify:

- `plan.md` exists in `tasks/{task-id}/`
- all `TEMPLATE.md §Planning Rules` pass
- dispatch field values conform to `SYSTEM.md §Dispatch Field Consistency`
- `Step Status Map` in `state.md` has been populated from `plan.md`
