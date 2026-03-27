# Compact Mode Combined Template (Analysis + Plan)

When `Recognition` determines `Complexity: low` and `Risk: low`, the task uses compact mode. This template defines the combined `analysis-plan.md` artifact.

## File Requirements

- file path: `tasks/{task-id}/analysis-plan.md`
- fixed heading order is required
- all required sections from both `analysis/TEMPLATE.md` and `planning/TEMPLATE.md` must be present
- sections with no meaningful content may be written as a single line (e.g., `## Risks\n- none`)

## Compact Mode Constraints

See `mind/analysis/README.md §Compact Mode` for full eligibility rules and exit conditions. Key constraints:

- the Plan may contain only a single Step
- all other rules (file handoff, Learning pipeline, state tracking) remain in full effect

## Fixed Structure

```md
# Analysis and Plan (Compact)

## Task ID
- current task ID

## Problem Definition
- what problem this task is actually solving

## Success Conditions
- what must be true when the task is complete

## Required Reads
- which files were actually read before running Analysis

## Risks
- key risks (write `none` if genuinely empty)

## Step-level Learning Need
- Step 1: `acquire-required / terminal-only / optional / not-needed`

## Goal
- the final outcome this task must reach

## Runtime State
- the fixed runtime state file is: `tasks/{task-id}/state.md`

## Global Constraints
- global constraints for this task
- default final result directory: `tasks/{task-id}/_output/`

### Step 1
- Name:
- Goal:
- Capability:
- Dispatch Mode: sequential
- Output Isolation:
- Constraints:
- Inputs:
- Outputs:
- Publish To Sources: none
- Learning: `acquire-required / terminal-only / optional / not-needed`
- Depends On: none
- Completion Criteria:
- Failure Policy: `retry / rework / stop / escalate-to-reflection`
- Instructions:

## Handoffs
- single-step task — no inter-step handoff

## Completion Check
- what must be true before the task is considered complete
```

## Validation Rules

- `Required Reads` must not be omitted
- `Risks` must not be omitted; use `none` if genuinely empty
- `Step-level Learning Need` must use exactly one of: `acquire-required / terminal-only / optional / not-needed`
- the single Step must follow all planning rules defined in `mind/planning/TEMPLATE.md §Planning Rules`
- `state.md` must be updated as normal after this file is written (see `mind/planning/README.md §Phase Entry`)
