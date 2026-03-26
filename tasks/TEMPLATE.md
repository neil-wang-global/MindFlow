# Task Directory Template

Every task directory must use the fixed structure below.

## Fixed Structure

```text
tasks/{task-id}/
├── learning-read.md
├── state.md
├── task-profile.md
├── analysis.md
├── plan.md
├── reflection-report.md
├── _output/
├── cache/
└── acquire/                  (created only when Learning(Acquire) is triggered)
    ├── search-log.md
    ├── raw-sources/
    │   ├── src-001-{slug}.md
    │   └── ...
    └── verification-report.md
```

## Required Reads Map

Each module's `README.md` defines its own Required Reads. This map provides a centralized overview for human readers. If any conflict exists between this map and a module's README, the module README is authoritative.

- `learning-read.md`
  - module README: `mind/learning/learning-read/README.md`
  - reads: `mind/soul/core.md`, `mind/learning/knowledge-base/approved/`

- `state.md`
  - created by `Learning(Read)`, populated by `Planning`, maintained by `Execution Control`
  - template: `tasks/STATE-TEMPLATE.md`

- `task-profile.md`
  - module README: `mind/recognition/README.md`
  - Required Reads defined in module README: `mind/soul/core.md`, `tasks/{task-id}/learning-read.md`

- `analysis.md`
  - module README: `mind/analysis/README.md`
  - reads: `mind/soul/core.md`, `tasks/{task-id}/learning-read.md`, `tasks/{task-id}/task-profile.md`, `capabilities/`

- `plan.md`
  - module README: `mind/planning/README.md`
  - reads: `mind/soul/core.md`, `tasks/{task-id}/analysis.md`, relevant `Capability` definition files

- `reflection-report.md`
  - module README: `mind/reflection/README.md`
  - reads: `mind/soul/core.md`, `tasks/{task-id}/state.md`, `tasks/{task-id}/plan.md`, `tasks/{task-id}/cache/`, `tasks/{task-id}/_output/`

- `acquire/verification-report.md`
  - module README: `mind/learning/acquire/README.md`
  - created only when `Learning(Acquire)` is triggered
  - the subagent producing this file must not share execution context with the fetch agent

- `tl-{task-id}.md` (written to `mind/learning/task-learning/`)
  - module README: `mind/learning/README.md`
  - reads: `tasks/{task-id}/reflection-report.md`, `tasks/{task-id}/state.md`, `tasks/{task-id}/_output/`, `tasks/{task-id}/cache/`, `tasks/{task-id}/acquire/verification-report.md` (if applicable)

## Fixed File Descriptions

- `learning-read.md`: audit record of `Learning(Read)`
- `state.md`: formal runtime state file
- `task-profile.md`: artifact of `Recognition`
- `analysis.md`: artifact of `Analysis`
- `plan.md`: the only formal artifact of `Planning`
- `reflection-report.md`: artifact of `Reflection`
- `_output/`: default formal result directory
- `cache/`: file handoff area between `Step`s

## Constraints

- `{task-id}` format is defined in `CONTRIBUTING.md §Task ID Format`
- each task directory serves exactly one task
- task caches must not be shared with other tasks
- formal artifacts must preferentially remain inside the task directory
- `_output/` must not be empty when the task is complete
- results may be published to `sources/` only when `Plan` explicitly declares it
- a task directory missing required fixed files is considered incomplete
