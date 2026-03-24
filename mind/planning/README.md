# planning

This directory defines the `Planning` module.

Responsibilities:

- materialize `Analysis Output` into formal `Plan`
- organize multiple `Step`s inside the `Plan`
- define inputs, outputs, capability calls, and handoff relationships
- define the dispatch mode of `Plan -> Steps`
- reuse the dispatch fields already declared in `Analysis` rather than inventing a second parallelism schema

Notes:

- `Planning` has only one formal output: `Plan`
- `Step` is only an internal component of `Plan`

## Inputs

- `Analysis Output`
- current task context
- available `Capabilities`

## Required Reads

See `tasks/TEMPLATE.md §Required Reads Map` for the formal list of files that must be read before producing `plan.md`.

## Outputs

- `Plan`

## Key Principles

- every task generates a new `Plan`
- old `Plan`s must not be reused
- `Step`s are organized through `Plan` and are advanced by `Execution Control`
- `Planning` must explicitly decide which work must remain sequential, which work is suitable for `subagent` parallelism, and which work should run as multiple parallel task branches
- parallelism is not the default, but when dependencies are clear, context is isolated, and outputs can be merged, the safest parallel mode should be preferred
- dispatch fields must remain consistent across `Analysis -> Plan -> Reflection`, at minimum including `Dispatch Mode`, `Parallel Group`, `Synchronization Point`, `Merge Owner`, and `Output Isolation`
