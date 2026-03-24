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

- `learning-read.md`
  - before it is generated, the runtime must first read:
    - `mind/soul/core.md`
    - `mind/learning/knowledge-base/approved/`

- `state.md`
  - the initial file is created by `Execution`:
    - based on `tasks/{task-id}/analysis.md`
    - based on `tasks/{task-id}/plan.md`
  - the first formal read and all subsequent maintenance are handled by `Execution Control`:
    - `tasks/{task-id}/state.md`
    - `tasks/{task-id}/plan.md`

- `task-profile.md`
  - before it is generated, the runtime must first read:
    - `tasks/{task-id}/learning-read.md`

- `analysis.md`
  - before it is generated, the runtime must first read:
    - `mind/soul/core.md`
    - `mind/learning/knowledge-base/approved/`
    - `tasks/{task-id}/learning-read.md`
    - `tasks/{task-id}/task-profile.md`

- `plan.md`
  - before it is generated, the runtime must first read:
    - `mind/soul/core.md`
    - `tasks/{task-id}/state.md`
    - `tasks/{task-id}/analysis.md`
    - the relevant `Capability` definition files
    - the dispatch-related fields declared in `analysis.md`

- `reflection-report.md`
  - before it is generated, the runtime must first read:
    - `mind/soul/core.md`
    - `tasks/{task-id}/state.md`
    - `tasks/{task-id}/plan.md`
    - `tasks/{task-id}/cache/`
    - `tasks/{task-id}/_output/`
    - if publish-back exists, the `sources/` publish-back paths declared in `Plan`
    - the dispatch fields and parallel merge rules declared in `plan.md`

- `acquire/verification-report.md`
  - created only when `Learning(Acquire)` is triggered
  - must be read by terminal `Learning` before writing `tl-{task-id}.md` if `Learning(Acquire)` was executed
  - before it is generated, the verification subagent must first read:
    - `tasks/{task-id}/acquire/search-log.md`
    - all files in `tasks/{task-id}/acquire/raw-sources/`
  - the subagent producing this file must not share execution context with the agent that performed the fetch stage

## Fixed File Descriptions

- `learning-read.md`: the artifact of `Learning(Read)`, used to record which formal knowledge was actually loaded for this task
- `state.md`: the formal runtime state file of the task, maintained by `Execution Control`
  - the initial file is created by `Execution`
- `task-profile.md`: the artifact of `Recognition`
- `analysis.md`: the artifact of `Analysis`
- `plan.md`: the only formal artifact of `Execution`, namely `Plan`
- `reflection-report.md`: the formal artifact of `Reflection`, namely `Reflection Report`
- `_output/`: the default formal result directory of the current task
- `cache/`: the file handoff area between `Step`s

## Constraints

- each task directory serves exactly one task
- task caches must not be shared with other tasks
- formal artifacts must preferentially remain inside the task directory
- final results default to `tasks/{task-id}/_output/`
- `tasks/{task-id}/_output/` must not be empty when the task is complete
- `state.md` must exist and must reflect the current phase, current step, parallel branch state, and failure state
- results may be published back into `sources/` only when `Plan` explicitly declares it
- dispatch fields in `analysis.md`, `plan.md`, and `reflection-report.md` must remain consistent
- `Required Reads Map` must not be removed
- fixed files in the fixed structure must not be renamed
- `tasks/{task-id}/acquire/raw-sources/` must not be deleted while any knowledge derived from its files has not yet been promoted to `mind/learning/knowledge-base/approved/`
- once all derived knowledge from `acquire/raw-sources/` has been promoted to `approved/` and the corresponding `kb-*.md` files record the `Original Source URL`, the `acquire/` directory may be archived or removed
