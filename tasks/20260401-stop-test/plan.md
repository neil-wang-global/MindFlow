# Plan

## Task ID
- 20260401-stop-test

## Goal
- Create a deployment configuration file for the staging environment, targeting `_output/deploy-config-staging.yaml`

## Runtime State
- the fixed runtime state file is: `tasks/20260401-stop-test/state.md`

## Global Constraints
- default final result directory: `tasks/20260401-stop-test/_output/`
- staging server must be reachable for configuration validation
- stop failure policy: any step failure terminates the task immediately with no retry

### Step 1
- Name: Create Staging Deployment Configuration
- Goal: Generate and validate a deployment configuration for the staging environment
- Capability: none (no formal capability defined)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-stop-test/_output/deploy-config-staging.yaml`
- Constraints: `mind/soul/core.md` -- explicit failure handling required; staging server connectivity required
- Inputs: staging environment parameters (host, port, credentials reference)
- Outputs: `tasks/20260401-stop-test/_output/deploy-config-staging.yaml`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: file `tasks/20260401-stop-test/_output/deploy-config-staging.yaml` exists and contains valid YAML with staging host, port, and environment fields
- Failure Policy: stop
- Instructions: 1. Verify staging server connectivity at staging.example.com:443. 2. If server is unreachable, report failure immediately (stop policy -- no retry). 3. If reachable, generate deployment YAML with environment=staging, host, port, resource limits, and health check configuration. 4. Write output to `_output/deploy-config-staging.yaml`.

## Handoffs
- single-step task -- no inter-step handoff

## Completion Check
- `tasks/20260401-stop-test/_output/deploy-config-staging.yaml` exists and contains valid deployment configuration
