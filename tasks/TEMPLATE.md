# Task Directory Template

Every task directory must use the fixed structure below.

## Fixed Structure

```text
tasks/{task-id}/
├── learning-read.md
├── state.md
├── task-profile.md
├── analysis.md              (standard mode)
├── plan.md                  (standard mode)
├── analysis-plan.md         (compact mode — replaces analysis.md and plan.md)
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
