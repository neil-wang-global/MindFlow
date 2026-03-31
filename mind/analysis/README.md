# analysis

This directory defines the `Analysis` module.

## Responsibilities

- problem modeling
- task decomposition
- identification of dependencies and constraints
- production of `Analysis Output`

## Phase Entry

Upon entering this module, set `state.md`: `Current Phase: analysis`.

## Required Reads

Before producing `analysis.md`, the runtime must read:

- `mind/soul/core.md`
- `tasks/{task-id}/learning-read.md` (for approved knowledge already loaded; also check `§Pending Cross-Task Items` for mandatory maintenance triggers per `SYSTEM.md §Capability Update Advancement` and `§Deferred Review Advancement`)
- `tasks/{task-id}/task-profile.md`
- `capabilities/` (for available capability labels)

Note: approved knowledge files are accessed via `learning-read.md §Approved Knowledge Reads`. If specific approved knowledge needs deeper reading, read those files directly.

If `learning-read.md §Pending Cross-Task Items` reports pending items exceeding `SYSTEM.md §Cross-Task Staleness Thresholds`, `Analysis` must include dedicated maintenance `Step`(s) in `§Step Drafts` to address them.

## Inputs

- `Learning(Read)` audit result
- `Task Profile`
- current task context
- available capability information
- `Soul` constraints

## Outputs

- `tasks/{task-id}/analysis.md` (see `TEMPLATE.md` for structure)
- In compact mode: `tasks/{task-id}/analysis-plan.md` (see `COMPACT-TEMPLATE.md` for the combined structure)

`Analysis` must provide enough structure for `Planning` to generate `Plan` without ambiguity.

## Compact Mode

When `Recognition` determines `Complexity: low` and `Risk: low`, the task may use compact mode. Must be declared in `task-profile.md` as `## Mode\n- compact`. Compact mode compresses artifacts — it does not skip phases. All other rules (file handoff, Learning pipeline, state tracking) remain in full effect.

- `Analysis` and `Planning` merge into `tasks/{task-id}/analysis-plan.md` (see `COMPACT-TEMPLATE.md` for full structure and constraints)
- Single `Step` only

**Exit compact mode**: if `Analysis` discovers compact mode is no longer appropriate, it must remove the compact declaration from `task-profile.md`, produce `analysis.md` only, and record the exit reason in `analysis.md §Notes`. `plan.md` is then produced by `Planning` as normal. If a partial `analysis-plan.md` was already started, delete it before producing the separate `analysis.md`. Once a complete `analysis-plan.md` is written, compact mode is committed. Common reasons to exit compact mode: the task requires more than one Step, `learning-read.md §Pending Cross-Task Items` reports items exceeding `SYSTEM.md §Cross-Task Staleness Thresholds` that require dedicated maintenance Steps, or the problem proves more complex than Recognition estimated.

**State update in compact mode**: after writing `analysis-plan.md`, complete the `state.md` updates per `mind/planning/README.md §Phase Entry` (set `Current Phase: execution-control`, populate `Step Status Map`, set `Current Step` to Step 1). The `planning` phase marker is skipped — the runtime transitions directly from `analysis` to `execution-control`.

## Inference Trigger

If `task-profile.md §Inference Possibility` indicated inference may be needed, and `Analysis` confirms the gap, `Analysis` triggers `Inference` before completing `analysis.md`. See `mind/inference/README.md`.

## Exit Validation

Before transitioning out of `Analysis`, verify:

- `analysis.md` (or `analysis-plan.md` in compact mode) exists in `tasks/{task-id}/`
- all `TEMPLATE.md §Validation Rules` pass (or `COMPACT-TEMPLATE.md §Validation Rules` in compact mode)
- `Step Drafts` are mappable to concrete `Step`s in the subsequent `Plan`
- dispatch field values conform to `SYSTEM.md §Dispatch Field Consistency`

## Not Responsible For

- directly generating the final `Plan` (that is `Planning`'s job)
- `Step` execution
- the post-task learning closure loop
