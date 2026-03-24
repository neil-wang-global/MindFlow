# recognition

This directory defines the `Recognition` module.

Responsibilities:

- identify the task
- produce `Task Profile`
- identify task type, complexity, risk, and capability needs

Notes:

- `Recognition` must have a formal artifact
- the formal artifact is `Task Profile`
- the template is maintained separately

## Inputs

- `Learning(Read)` audit result
- the raw task statement
- current task context

## Required Reads

See `tasks/TEMPLATE.md §Required Reads Map` for the formal list of files that must be read before producing `task-profile.md`.

## Outputs

- `Task Profile`

## Not Responsible For

- producing `Plan`
- executing `Step`s
- writing task-end learning artifacts
