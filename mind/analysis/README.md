# analysis

This directory defines the `Analysis` module.

Responsibilities:

- problem modeling
- task decomposition
- identification of dependencies and constraints
- production of `Analysis Output`

Notes:

- `Analysis` must have a formal artifact
- the template is maintained separately

## Inputs

- `Learning(Read)` audit result
- `Task Profile`
- current task context
- available capability information
- `Soul` constraints

## Required Constraint Loading Before Execution

Before running `Analysis`, the agent must read:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`
- the current `Task`'s `learning-read.md`
- the current `Task`'s `task-profile.md`

## Outputs

- `Analysis Output`

## Not Responsible For

- directly generating the final `Plan`
- `Step` execution
- the post-task learning closure loop
