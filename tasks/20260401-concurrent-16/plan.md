# Plan

## Task ID
- 20260401-concurrent-16

## Goal
- Produce a database migration rollback script design document that covers rollback strategy, state machine, failure handling, and concrete script mechanisms for both DDL and DML rollbacks

## Runtime State
- the fixed runtime state file is: tasks/20260401-concurrent-16/state.md

## Global Constraints
- Soul constraints: resilience over performance, explicit failure handling, clear state machines, operational simplicity
- Default final result directory: tasks/20260401-concurrent-16/_output/
- Concurrency rules: do not modify existing shared files; all created files must include task-id

### Step 1
- Name: Design rollback strategy
- Goal: Define the rollback strategy including trigger conditions, state machine for migration lifecycle, and classification of rollback types
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-16/cache/step-1-strategy.md
- Constraints: mind/soul/core.md (explicit failure handling, clear state machines)
- Inputs: tasks/20260401-concurrent-16/task-profile.md, tasks/20260401-concurrent-16/analysis.md
- Outputs: tasks/20260401-concurrent-16/cache/step-1-strategy.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: cache/step-1-strategy.md exists and contains at minimum: rollback trigger conditions, migration state machine with at least 3 states, and DDL vs DML rollback classification
- Failure Policy: retry
- Instructions: 1. Define migration lifecycle states (pending, applied, failed, rolled-back). 2. Define rollback trigger conditions (migration failure, manual trigger, validation failure). 3. Classify rollback types: DDL (schema changes — CREATE, ALTER, DROP) vs DML (data transformations — INSERT, UPDATE, DELETE). 4. Define state transitions for rollback process. 5. Write output to cache/step-1-strategy.md.

### Step 2
- Name: Write rollback script design
- Goal: Produce the complete rollback script design document incorporating the strategy from Step 1
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-16/_output/migration-rollback.md
- Constraints: mind/soul/core.md (operational simplicity, resilience over performance)
- Inputs: tasks/20260401-concurrent-16/cache/step-1-strategy.md
- Outputs: tasks/20260401-concurrent-16/_output/migration-rollback.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/migration-rollback.md exists and contains: rollback script structure, error handling mechanisms, logging approach, validation checks, and concrete rollback procedures for both DDL and DML operations
- Failure Policy: retry
- Instructions: 1. Read cache/step-1-strategy.md for the rollback strategy. 2. Design the rollback script structure with clear entry point, state validation, and execution phases. 3. Define error handling: what happens when rollback itself fails (compensating actions, human escalation). 4. Define logging: each state transition and operation must be logged. 5. Define validation checks: pre-rollback (is rollback safe?), in-progress (are operations succeeding?), post-rollback (is the database in expected state?). 6. Write concrete DDL rollback procedures (reverse CREATE/ALTER/DROP). 7. Write concrete DML rollback procedures (reverse data transformations using backup/audit tables). 8. Write output to _output/migration-rollback.md.

## Handoffs
- Step 1 produces cache/step-1-strategy.md which is consumed by Step 2
- Step 2 produces the final deliverable _output/migration-rollback.md

## Completion Check
- tasks/20260401-concurrent-16/cache/step-1-strategy.md exists with rollback strategy content
- tasks/20260401-concurrent-16/_output/migration-rollback.md exists with complete rollback script design
- Both DDL and DML rollback mechanisms are covered in the final deliverable
