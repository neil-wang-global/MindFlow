# reflection

This directory defines the `Reflection` module.

## Responsibilities

- review task results
- review the execution process
- identify issues, lessons, and `Capability Impact`
- produce `Reflection Report`

## Phase Entry

Upon entering this module, set `state.md`: `Current Phase: reflection`.

## Required Reads

Before producing `reflection-report.md`, the runtime must read:

- `mind/soul/core.md`
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/plan.md`
- `tasks/{task-id}/cache/`
- `tasks/{task-id}/_output/`
- if publish-back exists, the `sources/` publish-back paths declared in `Plan`
- the dispatch fields and parallel merge rules declared in `plan.md`

## Inputs

- `Task State`
- `Plan`
- task results
- `Step` process records

## Outputs

- `tasks/{task-id}/reflection-report.md` (see `TEMPLATE.md` for structure)

## Reflection Must Identify

- result quality
- process issues
- learning candidates
- capability impact
- inference triggers

## Inference Trigger

If `Reflection` identifies an inference trigger in its review, it triggers `Inference` before completing `reflection-report.md`. See `mind/inference/README.md`.

## Purpose

- provide structured input to terminal `Learning`
- mark issues, lessons, `Capability Impact`, and `Inference Trigger`
