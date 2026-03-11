# learning

This directory defines the `Learning` module.

Responsibilities:

- provide `Learning(Read)` before task execution
- receive candidate knowledge
- review whether that knowledge should be absorbed
- consolidate knowledge assets
- produce `Capability Update`

Notes:

- `Learning(Read)` reads only `mind/soul/core.md` and `mind/learning/knowledge-base/approved/`
- terminal `Learning` may have multiple input sources, but its output path is fixed
- the internal `Learning` process must remain stable and strictly ordered

## Two Participation Modes

- `Learning(Read)`
  - occurs before `Recognition`
  - is read-only with respect to formal knowledge sources, but must write `tasks/{task-id}/learning-read.md`
  - reads only:
    - `mind/soul/core.md`
    - `mind/learning/knowledge-base/approved/`
  - provides directly readable constraints and knowledge files to `Recognition` and `Analysis`
  - must generate `tasks/{task-id}/learning-read.md` as the formal audit record
  - must not read:
    - `mind/learning/knowledge-base/drafts/`
    - `mind/learning/knowledge-base/archived/`
    - `mind/learning/task-learning/`
    - `mind/learning/reviews/`
    - `mind/learning/capability-updates/`

- `Learning`
  - occurs after `Reflection`
  - is responsible for absorbing candidate knowledge and forming `Capability Update`

## Required Constraint Loading Before Execution

Before running `Learning(Read)`, the agent must read:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`

Before running `Recognition`, the agent must read:

- `tasks/{task-id}/learning-read.md`

Before running terminal `Learning`, the agent must read:

- `mind/soul/core.md`
- the current `Task`'s `reflection-report.md`

## Internal Stages

- `Intake`
- `Drafting`
- `Review`
- `Consolidation`
- `Capability Update`

## Fixed Execution Order

Terminal `Learning` must execute in the following order and may not skip steps:

1. generate `mind/learning/task-learning/tl-{task-id}.md` from `reflection-report.md`
2. generate one or more `draft-{type}-{task-id}-{slug}.md` from `tl-{task-id}.md`
3. generate a corresponding `review-{task-id}-{slug}.md` for each `draft-*.md`
4. only review records with `Decision: accepted` may generate `kb-{type}-{slug}.md`
5. if needed, generate `cu-{task-id}-{capability-name}.md` based on accepted review records

## Subdirectory Overview

- `knowledge-base/`: system-level knowledge assets
- `learning-read/`: audit template for front-loaded `Learning(Read)`
- `task-learning/`: task-level `Learning Record`
- `reviews/`: learning review records
- `capability-updates/`: capability change records

## Fixed Promotion Path

Knowledge may be promoted only through the following path:

`task-learning/` -> `drafts/` -> `reviews/` -> `knowledge-base/approved/`

Additional rules:

- task-level knowledge that has not entered `drafts/` is not pending review knowledge
- draft knowledge that has not entered `reviews/` is not promotable knowledge
- knowledge that has not entered `knowledge-base/approved/` must not be read by `Learning(Read)`
- `knowledge-base/drafts/` is the only pending-review knowledge area
