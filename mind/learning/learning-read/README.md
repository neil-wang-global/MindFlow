# learning-read

This directory defines the formal audit record of `Learning(Read)`.

`Learning(Read)` is a read-only stage with respect to formal knowledge sources, but it is not a stage without traces.

It must leave a formal record showing exactly which `Soul` constraints and which approved knowledge were read for the current task.

## File Path

- `tasks/{task-id}/learning-read.md`

## Fixed Rules

- `Learning(Read)` may read only:
  - `mind/soul/core.md`
  - `mind/learning/knowledge-base/approved/`
- `Learning(Read)` must not read:
  - `mind/learning/knowledge-base/drafts/`
  - `mind/learning/knowledge-base/archived/`
  - `mind/learning/task-learning/`
  - `mind/learning/reviews/`
  - `mind/learning/capability-updates/`
- `learning-read.md` must record the files that were actually read, not an abstract statement such as “knowledge base consulted”
- `learning-read.md` must be generated before `task-profile.md`
- any task chain missing `learning-read.md` is considered incomplete in front-loaded learning
