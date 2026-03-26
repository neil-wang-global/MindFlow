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
- dispatch and merge assessment: compare dispatch fields in `plan.md` against actual execution in `state.md`

## Issue Detection
- capability gaps
- knowledge gaps
- process gaps
- runtime risks or failures

### Issue Detection: Requires External Acquisition
- `yes` or `no`

## Learning Candidates
- what is worth learning from this task
- what may be promoted into terminal `Learning`

### Learning Candidates: Requires External Acquisition
- `yes` or `no`

## Capability Impact
- which `Capability` may require upgrade, split, addition, or downgrade

## Inference Triggers
- which points may justify conditional `Inference`

## Notes
- only supplementary notes required at the reflection stage
```

## Validation Rules

- `Result Evaluation`, `Process Review`, `Issue Detection` must not be omitted
- `Issue Detection: Requires External Acquisition` must be `yes` or `no`
- `Learning Candidates` must not be omitted
- `Learning Candidates: Requires External Acquisition` must be `yes` or `no`
- if either `Requires External Acquisition` is `yes`, `Learning(Acquire)` must be triggered before terminal `Learning`
- `Capability Impact` and `Inference Triggers` must not be omitted
