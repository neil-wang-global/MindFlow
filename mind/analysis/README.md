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

## Required Reads

See `tasks/TEMPLATE.md §Required Reads Map` for the formal list of files that must be read before producing `analysis.md`.

## Outputs

- `Analysis Output`

## Not Responsible For

- directly generating the final `Plan` (that is `Planning`'s job)
- `Step` execution
- the post-task learning closure loop
