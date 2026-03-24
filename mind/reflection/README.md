# reflection

This directory defines the `Reflection` module.

Responsibilities:

- review task results
- review the execution process
- identify issues, lessons, and `Capability Impact`
- produce `Reflection Report`

Notes:

- `Reflection Report` must use the fixed template
- template details are maintained separately

## Inputs

- `Task State`
- `Plan`
- task results
- `Step` process records

## Required Constraint Loading Before Execution

Before running `Reflection`, the agent must read:

- `mind/soul/core.md`
- the current `Task`'s `state.md`
- the current `Task`'s `plan.md`
- the current `Task`'s `_output/` (read all files present; if empty due to task failure, note the absence and reflect on why)
- the current `Task`'s `cache/` (read all files present; if empty or absent, record that fact and continue)
- if publish-back exists, the `sources/` publish-back paths declared in `Plan`
- the dispatch fields and parallel merge rules declared in `plan.md` (compare against actual execution results recorded in `state.md` — both must be read to assess whether dispatch and merge behaved as expected)

## Outputs

- `Reflection Report`

## Purpose

- provide structured input to `Learning`
- mark issues, lessons, `Capability Impact`, and `Inference Trigger`
