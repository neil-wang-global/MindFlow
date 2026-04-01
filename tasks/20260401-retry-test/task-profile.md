# Task Profile

## Task ID
- 20260401-retry-test

## Task Type
- delivery

## Goal
- Create a load testing script for validating system resilience under stress. The script should define target endpoints, concurrency levels, ramp-up strategy, and success/failure thresholds. This task also serves as an E2E test of the retry failure policy in the MindFlow execution control module.

## Inputs
- mind/soul/core.md (Soul constraints, especially the taboo against deploying without load testing)
- tasks/20260401-retry-test/learning-read.md (audit record)

## Success Criteria
- A load testing script document exists in _output/load-test-script.md
- The retry failure policy is exercised: Step 1 fails once, retry count increments, and Step 1 re-executes successfully
- Final task state is completed/completed

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Load testing knowledge (frameworks, configuration patterns)
- Script/configuration authoring

## Constraints
- Output must be a markdown document describing the load testing script configuration
- Must follow Soul taboo: never deploy resilience patterns without load testing
- Retry policy must be exercised during execution

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- not needed

## Notes
- This task deliberately simulates a failure during Step 1 to validate the retry failure policy mechanism
