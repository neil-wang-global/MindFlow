# Task Profile

## Task ID
- 20260401-concurrent-14

## Task Type
- delivery

## Goal
- Create a Dockerfile for a Go microservice. The Dockerfile should follow best practices: multi-stage build for minimal image size, non-root user for security, and operational simplicity per Soul constraints.

## Inputs
- Task statement specifying Go microservice Dockerfile creation
- Soul constraints (operational simplicity, minimal configuration surface, sensible defaults)

## Success Criteria
- A valid Dockerfile is produced in `_output/Dockerfile.md`
- The Dockerfile uses multi-stage build (build stage + runtime stage)
- The runtime image is minimal (e.g., distroless or alpine)
- The image runs as a non-root user

## Complexity
- low

## Risk
- low

## Capability Needs
- Docker containerization knowledge
- Go build toolchain familiarity

## Constraints
- Output must be placed in `tasks/20260401-concurrent-14/_output/Dockerfile.md`
- Must not modify existing shared files (concurrency rule)
- All created files must include task-id

## Task-level Learning Possibility
- not-expected

## Mode
- compact

## Inference Possibility
- not needed — straightforward delivery task with well-known patterns

## Notes
- Low complexity, low risk delivery task suitable for compact mode
