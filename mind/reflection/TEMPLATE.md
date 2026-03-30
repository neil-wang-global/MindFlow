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
- evaluate against `task-profile.md §Success Criteria` — assess each criterion individually
- evaluate against `plan.md §Completion Check` — verify all declared completion conditions
- what passed
- what did not pass

## Process Review
- which parts of the process were appropriate
- which parts of the process were problematic
- dispatch and merge assessment — for each Step, compare planned vs actual:
  - Step {N}: Dispatch Mode: {planned} → {actual}; outcome: {consistent / deviated — reason}
  - (if parallel: merge result: {as-planned / adjusted — reason})

## Issue Detection
- capability gaps
- knowledge gaps
- process gaps
- runtime risks or failures

### Issue Detection: Requires External Acquisition
- `yes` — an identified issue (capability gap, process gap, or runtime failure) cannot be resolved without external information
- `no`

## Learning Candidates
Each candidate must include its source location so terminal `Learning` can trace it:

- {title} — source: `_output/{file} §{Section}` or `cache/{file} §{Section}` or `needs-external-acquisition`

### Learning Candidates: Requires External Acquisition
- `yes` — a learning candidate requires external evidence to be properly grounded (the task produced a valuable insight but lacks original source material)
- `no`

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
- `Process Review` must include the dispatch and merge assessment subsection; for each Step, the planned vs actual Dispatch Mode comparison must be stated; omission is only permitted in lightweight reflection mode (cancelled tasks) where the assessment may be noted as `incomplete — task cancelled`
- **task-type-conditional rules** (per `SYSTEM.md §Task Type Variants`):
  - when `Task Type: delivery`: `_output/` must contain a concrete deliverable; `Learning Candidates` may be empty
  - when `Task Type: learning`: `_output/` must contain a knowledge artifact; `Learning Candidates` must not be empty unless all ACQ events were `exhausted`
  - when `Task Type: mixed`: both a deliverable and learning output are expected; evaluation criteria from both `delivery` and `learning` apply
