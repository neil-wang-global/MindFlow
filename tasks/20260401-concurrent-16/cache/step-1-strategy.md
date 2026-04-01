# Rollback Strategy

## Task ID
- 20260401-concurrent-16

## Purpose
Define the rollback strategy for database migrations, including trigger conditions, state machine, and rollback type classification.

## Migration Lifecycle State Machine

### States
1. **pending** -- migration is registered but not yet applied
2. **applying** -- migration is currently being executed
3. **applied** -- migration completed successfully
4. **failed** -- migration execution failed (partial or complete failure)
5. **rolling-back** -- rollback is in progress
6. **rolled-back** -- rollback completed successfully
7. **rollback-failed** -- rollback itself failed (requires human intervention)

### State Transitions
```
pending -> applying         (migration triggered)
applying -> applied         (all operations succeeded, validation passed)
applying -> failed          (any operation failed or validation failed)
applied -> rolling-back     (manual rollback triggered or downstream dependency failure)
failed -> rolling-back      (automatic rollback triggered)
rolling-back -> rolled-back (all rollback operations succeeded)
rolling-back -> rollback-failed (rollback operation failed)
rollback-failed -> rolling-back (human-approved retry)
```

### Transition Guards
- `pending -> applying`: pre-migration validation must pass (schema compatibility check, disk space, locks)
- `applying -> applied`: post-migration validation must pass (row counts, constraint checks, index verification)
- `applied -> rolling-back`: rollback window must not have expired; dependent migrations must be rolled back first
- `rolling-back -> rolled-back`: post-rollback validation must pass (schema matches pre-migration snapshot)

## Rollback Trigger Conditions

1. **Automatic triggers** (no human approval needed):
   - Migration execution fails at any operation
   - Post-migration validation fails
   - Transaction timeout exceeded during applying state

2. **Manual triggers** (require explicit invocation):
   - Application-level errors detected after migration was applied
   - Performance degradation traced to migration
   - Business logic incompatibility discovered post-deployment
   - Downstream service dependency failure

3. **Escalation triggers** (require human decision):
   - Rollback window has expired (data has been written against new schema)
   - Rollback itself fails (rollback-failed state)
   - Multiple dependent migrations need coordinated rollback

## Rollback Type Classification

### DDL Rollback (Schema Changes)
Operations that modify database structure:

| Forward Operation | Rollback Operation | Complexity |
|---|---|---|
| CREATE TABLE | DROP TABLE | low -- safe if no data written |
| ALTER TABLE ADD COLUMN | ALTER TABLE DROP COLUMN | low -- safe if column unused |
| ALTER TABLE DROP COLUMN | Cannot auto-reverse | high -- requires backup restoration |
| ALTER TABLE MODIFY COLUMN | ALTER TABLE MODIFY COLUMN (reverse) | medium -- data truncation risk |
| CREATE INDEX | DROP INDEX | low |
| DROP INDEX | CREATE INDEX (from snapshot) | medium -- requires original definition |
| DROP TABLE | Cannot auto-reverse | high -- requires backup restoration |
| RENAME TABLE | RENAME TABLE (reverse) | low |

**Key constraint**: Some DDL operations are non-transactional in many databases (MySQL DDL, for example). These require compensating actions rather than transaction rollback.

### DML Rollback (Data Transformations)
Operations that modify data content:

| Forward Operation | Rollback Strategy | Complexity |
|---|---|---|
| INSERT (new rows) | DELETE matching rows | low -- use migration batch ID |
| UPDATE (transform values) | UPDATE from audit/backup table | medium -- requires pre-migration snapshot |
| DELETE (remove rows) | INSERT from audit/backup table | medium -- requires pre-migration snapshot |
| Batch data migration | Reverse batch using change log | medium-high -- depends on change tracking |

**Key constraint**: DML rollback requires pre-migration data snapshots or change tracking (audit tables, CDC logs).

## Rollback Safety Rules

1. **Snapshot before apply**: Always capture schema snapshot and affected data snapshot before applying a migration
2. **Batch ID tracking**: Every migration must have a unique batch ID; all operations within the migration are tagged with this ID for selective rollback
3. **Dependency ordering**: Rollback must reverse migrations in reverse-chronological order (last applied, first rolled back)
4. **Idempotency**: Rollback operations must be idempotent -- running rollback twice produces the same result
5. **Point of no return**: Define explicit rollback windows; after the window expires (e.g., new data written against new schema), rollback requires a different strategy (data migration, not simple reversal)
