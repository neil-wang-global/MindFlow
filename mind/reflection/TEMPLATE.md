# Reflection Report Template

`Reflection Report` is the only formal output of `Reflection`.

## File Requirements

- file path: `tasks/{task-id}/reflection-report.md`
- fixed heading order is required

## Formal Template

```md
# Reflection Report

## Task ID
- current task ID

## Result Evaluation
- whether the result met the expected outcome
- what passed
- what did not pass

## Process Review
- which parts of the process were appropriate
- which parts of the process were problematic
- dispatch and merge assessment: compare the dispatch fields declared in `plan.md` against the actual execution results recorded in `state.md`; explicitly state whether each dispatch mode, parallel branch, and merge point behaved as declared

## Issue Detection
- capability gaps
- knowledge gaps
- process gaps
- runtime risks or failures

### Requires External Acquisition
- `yes` — one or more issues above require external information to resolve; `Learning(Acquire)` must be triggered before writing `tl-{task-id}.md`
- `no` — all issues can be addressed from task-internal artifacts only

## Learning Candidates
- what is worth learning from this task
- what may be promoted into terminal `Learning`

### Requires External Acquisition
- `yes` — one or more learning candidates require external information to ground; `Learning(Acquire)` must be triggered before writing `tl-{task-id}.md`
- `no` — all learning candidates are grounded in task-internal artifacts only

## Capability Impact
- which `Capability` may require upgrade, split, addition, or downgrade

## Inference Triggers
- which points may justify conditional `Inference`

## Notes
- only supplementary notes required at the reflection stage
```

## Validation Rules

- `Result Evaluation` must not be omitted
- `Process Review` must not be omitted
- `Issue Detection` must not be omitted
- `Issue Detection.Requires External Acquisition` must not be omitted; must be `yes` or `no`
- `Learning Candidates` must not be omitted
- `Learning Candidates.Requires External Acquisition` must not be omitted; must be `yes` or `no`
- if either `Requires External Acquisition` is `yes`, `Learning(Acquire)` must be triggered before terminal `Learning` begins
- `Capability Impact` must not be omitted
- `Inference Triggers` must not be omitted
