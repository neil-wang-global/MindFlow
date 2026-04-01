# Task Profile

## Task ID
- 20260401-concurrent-20

## Task Type
- delivery

## Goal
- Create a CI pipeline configuration for a microservice project. The pipeline includes a build-and-test step that depends on a CI runner. The scenario simulates a CI runner being unreachable, causing the step to fail. With a stop failure policy, the task terminates as failed without retry.

## Inputs
- Task scenario: CI pipeline config with simulated runner failure
- Failure policy: stop (no retry)

## Success Criteria
- CI pipeline config file is produced in _output/
- Step 1 fails due to simulated CI runner unreachable error
- Stop policy is applied: no retry, step marked failed, overall status failed
- Task completes through all 7 phases with final state completed/failed

## Complexity
- medium

## Risk
- high

## Capability Needs
- CI/CD pipeline configuration
- Failure handling and stop-policy execution

## Constraints
- Concurrency test: must not modify existing shared files
- All created files must include task-id (20260401-concurrent-20)
- Stop failure policy: on step failure, no retry, immediate task failure

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- not needed

## Notes
- This is a protocol validation scenario testing the stop failure policy and failed task terminal state
