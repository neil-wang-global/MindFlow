# learning-read

This directory defines the formal audit record of `Learning(Read)`.

`Learning(Read)` is a read-only stage with respect to formal knowledge sources, but it is not a stage without traces.

It must leave a formal record showing exactly which `Soul` constraints and which approved knowledge were read for the current task.

## File Path

- `tasks/{task-id}/learning-read.md`

## Fixed Rules

- see `SYSTEM.md §Learning(Read) Protocol` for the authoritative read/write rules
- `learning-read.md` must record the files that were actually read, not an abstract statement such as “knowledge base consulted”
- `learning-read.md` must be generated before `task-profile.md`
- any task chain missing `learning-read.md` is considered incomplete in front-loaded learning
