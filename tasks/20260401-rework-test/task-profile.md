# Task Profile

## Task ID
- 20260401-rework-test

## Task Type
- delivery

## Goal
- Design a notification database schema for a notification system. Step 1 gathers requirements for the schema. Step 2 designs the schema in 3NF. The task exercises the rework failure policy when Step 2 produces a partial output that violates 3NF.

## Inputs
- Task scenario specification (notification database schema design)
- Soul constraints from `mind/soul/core.md`

## Success Criteria
- Requirements document produced in Step 1
- Schema design produced in Step 2 that satisfies 3NF
- Rework failure policy correctly exercised when Step 2 first attempt fails

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Database schema design
- Normalization (3NF) validation
- Requirements analysis

## Constraints
- Schema must be in third normal form (3NF)
- Rework failure policy governs Step 2 with max rework: 1
- Partial output must be preserved on failure

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- not needed

## Notes
- This task is a protocol test exercising the rework failure policy in Execution Control
