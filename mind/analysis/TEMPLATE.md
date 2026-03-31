`Analysis Output` is the formal artifact of `Analysis`.
It is not the final `Plan`, but it must be stable enough for `Planning` to generate `Plan` without ambiguity.

## File Requirements

- file path: `tasks/{task-id}/analysis.md`
- fixed heading order is required
- dependencies and risks must be stated explicitly

## Formal Template

```md
# Analysis Output

## Task ID
- must match `Task Profile`

## Problem Definition
- what problem this task is actually solving
- what the problem boundary is

## Success Conditions
- what must be true when the task is complete

## Required Reads
- which files were actually read before running `Analysis`

## Stage Breakdown
- what stages the task should be divided into
- what each stage must solve

## Step Drafts
- `Step 1`: goal / dependencies / candidate capability / Dispatch Mode / Output Isolation / Learning (add Parallel Group / Synchronization Point / Merge Owner only when Dispatch Mode is not sequential)
- `Step N`: (same fields)

## Dispatch Assessment
- for each Step, state the `Dispatch Mode` decision and the reason:
  - `sequential`: why this Step must run in order (e.g., depends on prior output, shared mutable state)
  - `subagent`: why this Step is decomposable (e.g., independent sub-problems, isolated inputs/outputs); state decomposition boundary and merge method
  - `parallel-branch`: why this Step can run alongside others (e.g., no shared output, independent work branch); state parallel group, synchronization point, and merge owner
- per-Step field values must use the canonical dispatch fields and value domains defined in `SYSTEM.md §Dispatch Field Consistency`

## Risks
- key risks
- source of each risk
- impact on `Plan`

## Step-level Learning Need
- for each Step, declare the expected Learning mode:
  - `acquire-required`: this Step may encounter an external knowledge gap requiring `Learning(Acquire)`
  - `terminal-only`: learning from this Step will come from task-internal artifacts only
  - `optional`: learning may occur but is not mandatory
  - `not-needed`: this Step is not expected to produce learnable knowledge
- this is the primary Step-level declaration; `plan.md` must carry forward the same classification per Step
- must be consistent with `task-profile.md §Task-level Learning Possibility`:
  - task-level values (from `task-profile.md`): `acquire-likely / terminal-only / not-expected`
  - mapping: `acquire-likely` → `acquire-required` or `optional`; `terminal-only` → `terminal-only`; `not-expected` → `not-needed`
  - if task-level is `not-expected`, no Step should be `acquire-required` without explicit justification

## Possible Inference Trigger
- which points may require inference

## Inference References
(include this section only if Inference was triggered during Analysis)
- format: `tasks/{task-id}/cache/inference-{slug}.md` — status: `accepted-into-analysis` / `rejected`

## Notes
- only additional information required at the analysis stage
```

## Validation Rules

- `Task ID` must not be omitted; must match `task-profile.md §Task ID`
- `Problem Definition` must not be omitted
- `Success Conditions` must not be omitted
- `Required Reads` must not be omitted; must include `mind/soul/core.md`, `learning-read.md`, `task-profile.md`; also include any `cap-{name}.md` files read from `capabilities/` (omit capability reads if no definition files exist yet)
- `Stage Breakdown` must not be omitted
- `Step Drafts` must not be omitted; must be mappable to concrete `Step`s in the subsequent `Plan`
- `Dispatch Assessment` must not be omitted; for each Step, the Dispatch Mode decision and reason must be stated
- any `Analysis Output` without dependency information is incomplete
- any `Analysis Output` without risk information is incomplete
- `Risks` must not be omitted; write `none` if genuinely empty
- `Step-level Learning Need` must use exactly one of: `acquire-required / terminal-only / optional / not-needed` per Step
- classifications must be consistent with `task-profile.md §Task-level Learning Possibility` per the mapping rules in `§Step-level Learning Need` above; if task-level is `not-expected`, no Step should be `acquire-required` without explicit justification in `Notes`
- `Possible Inference Trigger` must not be omitted; write `none` if not applicable
