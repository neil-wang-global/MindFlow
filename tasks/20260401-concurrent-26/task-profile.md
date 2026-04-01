# Task Profile

## Task ID
- 20260401-concurrent-26

## Task Type
- delivery

## Goal
- Design a monitoring dashboard specification and implement it. The task involves two steps: designing the dashboard layout and metrics (Step 1) and implementing the dashboard (Step 2). The task will be cancelled mid-execution during Step 2, testing the cancellation protocol path.

## Inputs
- Task scenario specification (cancellation test)
- Soul constraints from mind/soul/core.md

## Success Criteria
- Step 1 produces a dashboard design document
- Step 2 begins implementation
- Cancellation is handled per protocol when triggered during Step 2

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Dashboard design and specification
- Monitoring system knowledge

## Constraints
- Task will be cancelled during Step 2 — this is expected behavior, not a failure
- All files must include task-id per concurrency rules
- Must not modify existing shared files

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- not expected — task is a straightforward delivery cancelled mid-execution

## Notes
- This task is a protocol validation test for the cancellation path (cancelled/cancelled final state)
