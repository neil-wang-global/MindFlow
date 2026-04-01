# Plan

## Task ID
- 20260401-rework-test

## Goal
- Design a 3NF-compliant notification database schema, exercising the rework failure policy when the first attempt violates normalization constraints

## Runtime State
- the fixed runtime state file is: `tasks/20260401-rework-test/state.md`

## Global Constraints
- Schema must satisfy third normal form (3NF)
- Default final result directory: `tasks/20260401-rework-test/_output/`
- Intermediate files go to: `tasks/20260401-rework-test/cache/`
- Soul constraints: explicit failure handling over silent degradation; clear state machines over ad-hoc logic

### Step 1
- Name: Requirements Gathering
- Goal: Identify entities, attributes, relationships, and constraints for a notification system database schema
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-rework-test/cache/step-1-requirements.md`
- Constraints: `mind/soul/core.md`
- Inputs: task scenario (notification database schema design)
- Outputs: `tasks/20260401-rework-test/cache/step-1-requirements.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: `cache/step-1-requirements.md` exists and contains at least 3 identified entities with their attributes and relationships
- Failure Policy: retry
- Instructions: Analyze the notification system domain. Identify core entities (notifications, recipients, channels, delivery status). Document attributes for each entity. Define relationships and cardinality. List constraints (uniqueness, referential integrity, not-null).

### Step 2
- Name: Schema Design
- Goal: Produce a 3NF-compliant notification database schema based on Step 1 requirements
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-rework-test/_output/notification-schema.md`
- Constraints: `mind/soul/core.md`, schema must satisfy 3NF (no partial dependencies, no transitive dependencies)
- Inputs: `tasks/20260401-rework-test/cache/step-1-requirements.md`
- Outputs: `tasks/20260401-rework-test/_output/notification-schema.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: `_output/notification-schema.md` exists, all tables are in 3NF (no partial dependencies on composite keys, no transitive dependencies between non-key attributes), and every entity from Step 1 requirements is represented
- Failure Policy: rework
- Instructions: Read `cache/step-1-requirements.md`. Design tables for each entity. Define primary keys, foreign keys, and indexes. Validate against 3NF. If validation fails (rework triggered), preserve partial output in `cache/step-2-schema-partial.md`, re-read Step 1 requirements and Step 2 constraints, adjust approach to eliminate normalization violations, and produce corrected schema. Max rework: 1.

## Handoffs
- Step 1 produces `cache/step-1-requirements.md` which is consumed by Step 2 as input
- If Step 2 fails and rework is triggered, partial output is preserved in `cache/step-2-schema-partial.md` before re-execution

## Completion Check
- `cache/step-1-requirements.md` exists with notification system requirements
- `_output/notification-schema.md` exists with a 3NF-compliant schema
- All entities from requirements are represented in the final schema
