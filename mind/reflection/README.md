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
- the current `Task`'s `_output/`
- the current `Task`'s `cache/`
- if publish-back exists, the `sources/` publish-back paths declared in `Plan`
- the dispatch fields and parallel merge rules declared in `plan.md` (to verify whether the actual execution matched the declared dispatch schema)

## Outputs

- `Reflection Report`

## Purpose

- provide structured input to `Learning`
- mark issues, lessons, `Capability Impact`, and `Inference Trigger`
