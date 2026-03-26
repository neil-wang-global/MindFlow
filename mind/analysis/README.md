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
- `tasks/{task-id}/learning-read.md` (for approved knowledge already loaded)
- `tasks/{task-id}/task-profile.md`
- `capabilities/` (for available capability labels)

Note: approved knowledge files are accessed via `learning-read.md §Approved Knowledge Reads`. If specific approved knowledge needs deeper reading, read those files directly.

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

## Inference Trigger

If `task-profile.md §Inference Possibility` indicated inference may be needed, and `Analysis` confirms the gap, `Analysis` triggers `Inference` before completing `analysis.md`. See `mind/inference/README.md`.

## Not Responsible For

- directly generating the final `Plan` (that is `Planning`'s job)
- `Step` execution
- the post-task learning closure loop
