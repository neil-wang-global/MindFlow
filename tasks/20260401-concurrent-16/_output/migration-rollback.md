# Database Migration Rollback Script Design

## Task ID
- 20260401-concurrent-16

## Overview

This document defines a database migration rollback script that safely reverses schema (DDL) and data (DML) changes. The design follows explicit failure handling, clear state machine transitions, and operational simplicity principles.

## Script Structure

```
rollback-migration.sh / rollback-migration.py
  |
  +-- 1. Pre-Rollback Phase
  |     +-- validate arguments (migration ID, target database)
  |     +-- load migration metadata
  |     +-- check rollback eligibility
  |     +-- acquire advisory lock
  |
  +-- 2. State Transition: applied/failed -> rolling-back
  |     +-- update migration state table
  |     +-- log rollback initiation
  |
  +-- 3. Execution Phase
  |     +-- execute DDL rollback operations
  |     +-- execute DML rollback operations
  |     +-- verify each operation
  |
  +-- 4. Post-Rollback Phase
  |     +-- run validation checks
  |     +-- update migration state table
  |     +-- release advisory lock
  |     +-- log completion
  |
  +-- 5. Error Handler (any phase)
        +-- capture error context
        +-- transition to rollback-failed
        +-- release lock
        +-- alert/escalate
```

## Migration Metadata Schema

The rollback script depends on a `migration_state` table that tracks all migrations:

```sql
CREATE TABLE migration_state (
    migration_id    VARCHAR(64) PRIMARY KEY,
    batch_id        VARCHAR(64) NOT NULL,
    version         INTEGER NOT NULL,
    description     TEXT,
    applied_at      TIMESTAMP,
    rolled_back_at  TIMESTAMP,
    state           VARCHAR(20) NOT NULL DEFAULT 'pending',
    -- states: pending, applying, applied, failed, rolling-back, rolled-back, rollback-failed
    checksum        VARCHAR(128),
    schema_snapshot TEXT,
    rollback_script TEXT NOT NULL,
    depends_on      VARCHAR(64),
    rollback_window_minutes INTEGER DEFAULT 1440,
    error_log       TEXT,
    CONSTRAINT valid_state CHECK (state IN (
        'pending','applying','applied','failed',
        'rolling-back','rolled-back','rollback-failed'
    ))
);

CREATE TABLE migration_data_snapshot (
    snapshot_id     VARCHAR(64) PRIMARY KEY,
    migration_id    VARCHAR(64) REFERENCES migration_state(migration_id),
    table_name      VARCHAR(128) NOT NULL,
    snapshot_type   VARCHAR(20) NOT NULL, -- 'schema' or 'data'
    snapshot_data   TEXT NOT NULL, -- JSON or SQL dump
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

## Pre-Rollback Validation

Before executing any rollback operation, the script must verify:

### 1. Migration Exists and Is Eligible
```
CHECK: migration_state.state IN ('applied', 'failed')
  IF state = 'pending':     EXIT "Nothing to roll back"
  IF state = 'rolling-back': EXIT "Rollback already in progress"
  IF state = 'rolled-back':  EXIT "Already rolled back"
  IF state = 'rollback-failed': PROMPT "Previous rollback failed. Retry? (requires --force)"
```

### 2. Rollback Window Check
```
CHECK: (NOW - applied_at) < rollback_window_minutes
  IF expired AND NOT --force:
    EXIT "Rollback window expired. New data may exist against current schema.
          Use --force to override (requires manual data reconciliation plan)."
```

### 3. Dependency Check
```
CHECK: No later migration depends on this one and is still in 'applied' state
  IF dependent migrations exist:
    LIST dependent migrations
    EXIT "Must roll back dependent migrations first: [list]
          Use --cascade to auto-rollback dependents in reverse order."
```

### 4. Lock Acquisition
```
ACQUIRE advisory lock on migration_id
  IF lock unavailable:
    EXIT "Another rollback process holds the lock. Wait or investigate."
  TIMEOUT: 30 seconds
```

## DDL Rollback Procedures

### Reversible DDL Operations

Each migration's forward DDL script has a corresponding rollback script stored in `migration_state.rollback_script`. The rollback script is generated at migration creation time, not at rollback time.

```
FOR each DDL operation IN rollback_script (reverse order):
  LOG "Executing DDL rollback: {operation_summary}"
  
  EXECUTE operation
    ON SUCCESS:
      LOG "DDL rollback succeeded: {operation_summary}"
      RECORD in migration_audit_log
    ON FAILURE:
      LOG "DDL rollback FAILED: {operation_summary}, error: {error}"
      IF operation is non-transactional (e.g., MySQL DDL):
        RECORD partial state
        TRANSITION to rollback-failed
        EXIT with error context
      ELSE:
        ROLLBACK transaction
        TRANSITION to rollback-failed
        EXIT with error context
```

### Non-Reversible DDL Operations

For destructive DDL (DROP TABLE, DROP COLUMN) where the forward migration destroyed data:

```
IF schema_snapshot exists for this migration:
  RESTORE from schema_snapshot
  RESTORE data from migration_data_snapshot WHERE snapshot_type = 'data'
ELSE:
  TRANSITION to rollback-failed
  EXIT "Cannot reverse destructive DDL without snapshot. Manual restoration required."
```

## DML Rollback Procedures

### Data Transformation Reversal

DML rollback uses pre-migration data snapshots stored in `migration_data_snapshot`:

```
FOR each affected table IN rollback_script (reverse order):
  
  -- Identify affected rows using batch_id
  SELECT affected_row_ids FROM migration_audit_log
    WHERE migration_id = {id} AND table_name = {table}
  
  IF operation_type = 'INSERT':
    -- Reverse: delete inserted rows
    DELETE FROM {table} WHERE batch_id = {migration_batch_id}
    VERIFY: row count matches expected
    
  ELSE IF operation_type = 'UPDATE':
    -- Reverse: restore from snapshot
    FOR each row IN affected_row_ids:
      UPDATE {table}
        SET columns = (SELECT columns FROM migration_data_snapshot
                       WHERE snapshot_id = {id} AND row_id = {row_id})
        WHERE id = {row_id}
    VERIFY: checksums match pre-migration values
    
  ELSE IF operation_type = 'DELETE':
    -- Reverse: re-insert from snapshot
    INSERT INTO {table}
      SELECT * FROM migration_data_snapshot
      WHERE snapshot_id = {id} AND table_name = {table}
    VERIFY: row count matches snapshot count
    
  LOG "{operation_type} rollback on {table}: {row_count} rows affected"
```

## Error Handling

### Error Classification

| Error Type | Action | Retry? |
|---|---|---|
| Lock acquisition timeout | Wait and retry | yes, up to 3 attempts |
| DDL operation failure (transactional DB) | Rollback transaction, transition to rollback-failed | yes, 1 retry |
| DDL operation failure (non-transactional DB) | Record partial state, transition to rollback-failed | no -- manual fix required |
| DML row count mismatch | Log warning, continue if within tolerance (< 1%) | no -- investigate |
| DML checksum mismatch | Stop, transition to rollback-failed | no -- data corruption risk |
| Connection lost | Reconnect, verify state, resume or restart | yes, up to 3 attempts |
| Snapshot not found | Transition to rollback-failed, escalate | no -- cannot proceed |

### Error Recovery Flow

```
ON ERROR:
  1. Capture: error message, operation, timestamp, partial state
  2. Log: write to migration_state.error_log AND external log
  3. Decide:
     IF retryable AND retry_count < max_retries:
       INCREMENT retry_count
       WAIT exponential_backoff(retry_count)
       RETRY operation
     ELSE:
       UPDATE migration_state SET state = 'rollback-failed'
       RELEASE advisory lock
       SEND alert (email/webhook/pager)
       EXIT with full error context
```

### Compensating Actions

When rollback itself fails and leaves the database in an inconsistent state:

1. **Capture current state**: dump affected table schemas and sample data
2. **Generate diff**: compare current state against both pre-migration and post-migration snapshots
3. **Produce remediation script**: auto-generate SQL to reach a consistent state (requires human review)
4. **Block forward migrations**: prevent new migrations until the inconsistency is resolved

## Logging

Every state transition and operation is logged with the following structure:

```
[TIMESTAMP] [LEVEL] [MIGRATION_ID] [PHASE] [OPERATION] [RESULT] [DETAILS]

Examples:
[2026-04-01T10:00:00Z] [INFO]  [mig-042] [pre-rollback]  [eligibility-check]  [pass]   state=applied, within_window=true
[2026-04-01T10:00:01Z] [INFO]  [mig-042] [state-change]  [applied->rolling-back] [ok]   lock_acquired=true
[2026-04-01T10:00:02Z] [INFO]  [mig-042] [ddl-rollback]  [DROP INDEX idx_users_email] [ok]   duration=120ms
[2026-04-01T10:00:03Z] [WARN]  [mig-042] [dml-rollback]  [UPDATE users]         [warn] row_count_mismatch: expected=1000, actual=999
[2026-04-01T10:00:04Z] [ERROR] [mig-042] [dml-rollback]  [DELETE orders]        [fail] checksum_mismatch, transition=rollback-failed
```

Log destinations:
- `migration_state.error_log` -- per-migration error context
- Application log file -- full operation log
- External monitoring system -- errors and state transitions only

## Post-Rollback Validation

After all rollback operations complete, before marking as `rolled-back`:

### Schema Validation
```
COMPARE current_schema AGAINST migration_data_snapshot WHERE snapshot_type = 'schema'
  IF match: PASS
  IF mismatch: LIST differences, FAIL validation
```

### Data Validation
```
FOR each affected table:
  CHECK row_count matches expected (pre-migration count +/- tolerance)
  CHECK constraint violations = 0
  CHECK index integrity (reindex if needed)
```

### Application Smoke Test (optional, configurable)
```
IF smoke_test_endpoint configured:
  CALL endpoint
  CHECK response = expected
  IF fail: LOG warning (do not block rollback completion)
```

### Final State Update
```
IF all validations pass:
  UPDATE migration_state SET state = 'rolled-back', rolled_back_at = NOW()
  RELEASE advisory lock
  LOG "Rollback completed successfully"
ELSE:
  UPDATE migration_state SET state = 'rollback-failed', error_log = {validation_errors}
  RELEASE advisory lock
  SEND alert
  LOG "Rollback completed with validation failures"
```

## Command-Line Interface

```
Usage: rollback-migration [OPTIONS] MIGRATION_ID

Options:
  --database URL    Target database connection string
  --force           Override rollback window expiration check
  --cascade         Auto-rollback dependent migrations in reverse order
  --dry-run         Show operations without executing
  --verbose         Enable detailed logging
  --timeout SECS    Overall rollback timeout (default: 3600)

Examples:
  rollback-migration mig-042
  rollback-migration --cascade --verbose mig-042
  rollback-migration --dry-run mig-042
  rollback-migration --force mig-042
```

## Summary

This rollback script design provides:
- A 7-state migration lifecycle with explicit state transitions
- Separate DDL and DML rollback procedures with appropriate strategies for each
- Pre-rollback validation to prevent unsafe rollbacks
- Comprehensive error handling with retry, escalation, and compensating actions
- Structured logging for every operation and state change
- Post-rollback validation to confirm database consistency
- A clear CLI interface with safety flags (--force, --cascade, --dry-run)
