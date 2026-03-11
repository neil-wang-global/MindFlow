# Task Learning Record Template

This file defines the fixed structure of task-level learning records.

## File Naming Rule

- file path: `mind/learning/task-learning/tl-{task-id}.md`
- `{task-id}` must match the source task

## Fixed Structure

```md
# Task Learning Record

## Task ID
- source task ID

## Task Summary
- what this task did
- what result it produced

## Candidate Knowledge
- what is worth promoting into candidate knowledge

## Potential Capability Impact
- which `Capability` may be affected

## Next Promotion Target
- target draft file path
- write `none` if nothing should be promoted
```

## Validation Rules

- `Task ID` must not be omitted
- `Candidate Knowledge` must not be omitted
- `Potential Capability Impact` must not be omitted
- `Next Promotion Target` must not be omitted
