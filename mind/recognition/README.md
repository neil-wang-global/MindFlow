# recognition

This directory defines the `Recognition` module.

## Responsibilities

- identify the task
- produce `Task Profile`
- identify task type, complexity, risk, and capability needs

## Phase Entry

Upon entering this module, set `state.md`: `Current Phase: recognition`.

## Required Reads

Before producing `task-profile.md`, the runtime must read:

- `mind/soul/core.md`
- `tasks/{task-id}/learning-read.md`

## Inputs

- `Learning(Read)` audit result (`learning-read.md`)
- the raw task statement
- current task context

## Outputs

- `tasks/{task-id}/task-profile.md` (see `TEMPLATE.md` for structure)

## Recognition Must Identify

- task type
- goal
- complexity
- risk
- capability needs
- whether task-level learning may be required
- whether `Inference` may be needed

## Not Responsible For

- producing `Plan`
- executing `Step`s
- writing task-end learning artifacts
