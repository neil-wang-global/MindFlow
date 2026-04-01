# Task Profile

## Task ID
- 20260401-concurrent-15

## Task Type
- delivery

## Goal
- Write a Makefile for multi-service build orchestration. The Makefile should provide targets for building, testing, and managing multiple services in a monorepo or multi-service project layout. It should follow best practices for parallel builds, dependency management between services, and clean/rebuild operations.

## Inputs
- Task statement: "Write a Makefile for multi-service build"
- Soul constraints from mind/soul/core.md (operational simplicity, minimal configuration surface)

## Success Criteria
- A complete Makefile is produced in _output/Makefile.md
- The Makefile handles multiple service builds with proper dependency ordering
- Includes standard targets: all, build, test, clean, and per-service targets
- Follows Make best practices (phony targets, variable definitions, pattern rules where appropriate)

## Complexity
- low

## Risk
- low

## Capability Needs
- Build system knowledge (Make syntax and conventions)
- Multi-service project structure understanding

## Constraints
- Output must be placed in tasks/20260401-concurrent-15/_output/Makefile.md
- Must not modify existing shared files (concurrency rule)
- All created files must include task-id

## Task-level Learning Possibility
- not-expected

## Mode
- compact

## Inference Possibility
- not needed — the task is straightforward Makefile authoring with no ambiguous requirements requiring inference resolution

## Notes
- Low complexity, low risk delivery task suitable for compact mode processing
