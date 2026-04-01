# Task Profile

## Task ID
- 20260401-inference-test

## Task Type
- delivery

## Goal
- Analyze whether event sourcing is appropriate for our order management system and produce a recommendation. This involves evaluating the architectural trade-offs of event sourcing vs. traditional state-based persistence, considering scalability, consistency, and operational complexity in the context of order lifecycle management.

## Inputs
- Task statement: "Analyze whether event sourcing is appropriate for our order management system and produce a recommendation"
- No pre-existing system documentation provided as input

## Success Criteria
- A clear recommendation document (_output/event-sourcing-recommendation.md) is produced
- The recommendation addresses scalability, consistency, complexity, and operational trade-offs
- The analysis covers both benefits and risks of event sourcing for order management
- Any inferences made during analysis are properly documented and evaluated

## Complexity
- high

## Risk
- medium

## Capability Needs
- Architectural analysis and evaluation
- Domain knowledge of event sourcing patterns
- Understanding of order management system requirements

## Constraints
- No existing system documentation is available as input; analysis must rely on general architectural principles and inferred requirements
- Recommendation must be actionable and context-appropriate

## Task-level Learning Possibility
- terminal-only

## Mode
- standard

## Inference Possibility
- likely needed — the task requires reasoning about system properties (e.g., write volumes, scalability limits) that are not provided in inputs, and may surface reusable architectural patterns during reflection

## Notes
- Inference is expected to be triggered during Analysis (to reason about unspecified system properties) and during Reflection (to identify reusable patterns)
