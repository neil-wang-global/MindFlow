# Task Profile

## Task ID
- 20260401-stop-test

## Task Type
- delivery

## Goal
- Create a deployment configuration for a staging environment. This task serves as an E2E test of the stop failure policy. Step 1 will simulate a failure (staging server unreachable), triggering the stop protocol: immediate termination with no retry and no rework.

## Inputs
- Deployment target: staging environment
- Failure scenario: staging server unreachable (simulated)

## Success Criteria
- Deployment configuration artifact produced in `_output/`
- Note: due to the simulated failure, this criterion will NOT be met; the task is expected to fail

## Complexity
- low

## Risk
- high -- the stop failure policy means any failure terminates the entire task with no recovery path

## Capability Needs
- deployment configuration authoring
- environment connectivity verification

## Constraints
- Failure Policy for the single step is `stop` -- no retry, no rework permitted
- Staging server is unreachable (simulated failure condition)
- No fallback environments available

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- no

## Notes
- This task is an E2E protocol test of the stop failure policy path. The failure is intentionally simulated.
