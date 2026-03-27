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
- `tasks/{task-id}/learning-read.md` (to assess whether initial knowledge and constraints were properly applied during execution)
- `tasks/{task-id}/task-profile.md` (for `§Success Criteria` — used in `Result Evaluation`)
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
- whether external acquisition is required — both for `Issue Detection` and for `Learning Candidates`; each has a `Requires External Acquisition` sub-heading (see `TEMPLATE.md`); if either is `yes`, `Learning(Acquire)` must be triggered post-reflection before terminal `Learning` begins (see `SYSTEM.md §Phase Transition Protocol` steps 2–3)

## Inference Trigger

If `Reflection` identifies an inference trigger in its review, it triggers `Inference` before completing `reflection-report.md`. See `mind/inference/README.md`.

## Exit Validation

Before transitioning out of `Reflection`, verify:

- `reflection-report.md` exists in `tasks/{task-id}/`
- all `TEMPLATE.md §Validation Rules` pass

## Purpose

- provide structured input to terminal `Learning`
- mark issues, lessons, `Capability Impact`, and `Inference Trigger`
