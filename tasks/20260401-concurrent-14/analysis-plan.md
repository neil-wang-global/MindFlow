# Analysis and Plan (Compact)

## Task ID
- 20260401-concurrent-14

## Problem Definition
- The task requires creating a production-ready Dockerfile for a Go microservice. The Dockerfile must follow containerization best practices: multi-stage build to minimize image size, non-root execution for security, and clear build/runtime separation.

## Success Conditions
- A valid Dockerfile is produced at `tasks/20260401-concurrent-14/_output/Dockerfile.md`
- Multi-stage build separates compilation from runtime
- Final image uses a minimal base (distroless or alpine)
- Application runs as a non-root user
- Build is reproducible (pinned Go version, module caching)

## Required Reads
- `mind/soul/core.md` — Soul constraints (operational simplicity, minimal configuration, sensible defaults)
- `tasks/20260401-concurrent-14/learning-read.md` — no relevant approved knowledge; pending cross-task items noted but not relevant to this task
- `tasks/20260401-concurrent-14/task-profile.md` — delivery task, low complexity, low risk, compact mode

## Risks
- none

## Step-level Learning Need
- Step 1: not-needed

## Possible Inference Trigger
- none

## Goal
- Produce a well-structured Dockerfile for a Go microservice in `_output/Dockerfile.md`

## Runtime State
- the fixed runtime state file is: `tasks/20260401-concurrent-14/state.md`

## Global Constraints
- Must not modify existing shared files (concurrency rule)
- All created files must include task-id
- Default final result directory: `tasks/20260401-concurrent-14/_output/`

### Step 1
- Name: Create Go Microservice Dockerfile
- Goal: Write a production-ready multi-stage Dockerfile for a Go microservice
- Capability: none (general Docker/Go knowledge)
- Dispatch Mode: sequential
- Output Isolation: single output file in `_output/`
- Constraints: Must use multi-stage build, non-root user, minimal base image; must follow Soul values (operational simplicity, sensible defaults)
- Inputs: task-profile.md, Soul constraints
- Outputs: `tasks/20260401-concurrent-14/_output/Dockerfile.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: Dockerfile.md exists in `_output/` with valid multi-stage Dockerfile content
- Failure Policy: retry
- Instructions: Create a Dockerfile with two stages. Build stage: use `golang:1.22-alpine` as builder, set working directory, copy go.mod/go.sum first for layer caching, download dependencies, copy source, build static binary with CGO disabled. Runtime stage: use `gcr.io/distroless/static-debian12` or `alpine:3.19`, create non-root user, copy binary from builder, expose port 8080, set entrypoint. Include comments explaining each section.

## Handoffs
- single-step task — no inter-step handoff

## Completion Check
- `_output/Dockerfile.md` exists and contains a valid multi-stage Dockerfile for a Go microservice

## Notes
- Compact mode appropriate: single-step delivery, low complexity, low risk, no learning needed
