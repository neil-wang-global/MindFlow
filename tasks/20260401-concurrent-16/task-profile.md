# Task Profile

## Task ID
- 20260401-concurrent-16

## Task Type
- delivery

## Goal
- Design a database migration rollback script that provides a safe, repeatable mechanism for reversing database schema and data migrations. The script should handle failure modes explicitly, track migration state clearly, and support both schema DDL rollbacks and data transformation reversals.

## Inputs
- Task statement: "Design a database migration rollback script"
- Soul constraints: resilience over performance, explicit failure handling, clear state machines, operational simplicity

## Success Criteria
- A rollback script design document is produced in `_output/`
- The design covers rollback strategy (when/how to rollback)
- The design covers the actual rollback script structure and mechanisms
- Failure modes are explicitly addressed

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Database schema management
- Migration tooling patterns
- Error handling and recovery design

## Constraints
- Must follow Soul constraints: explicit failure handling, clear state machines, operational simplicity
- No external tools or databases are available for live testing — output is a design document
- Rollback design must handle both DDL and DML reversals

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- not expected — task is a straightforward design exercise with well-understood domain

## Notes
- This is a delivery task producing a design document, not executable code requiring runtime validation
