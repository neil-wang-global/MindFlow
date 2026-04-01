# knowledge-gaps

This directory stores unresolved knowledge gap records that persist across tasks.

## Purpose

When a `Learning(Acquire)` event is `exhausted` (zero passed sources), the knowledge gap cannot be resolved in the current task. This directory provides a cross-task tracking mechanism so that future tasks' `Learning(Read)` can detect outstanding gaps and attempt resolution with different search strategies.

## File Naming Rule

`gap-{task-id}-{slug}.md`

Where:

- `{task-id}` is the task that first identified the gap
- `{slug}` is a short descriptor of the knowledge gap

## Fixed Structure

```md
# Knowledge Gap

## Gap ID
- gap-{task-id}-{slug}

## Origin Task
- the task ID where this gap was first identified

## Origin ACQ Event
- ACQ-{NNN} from the origin task

## Knowledge Gap Description
- what knowledge was sought
- why it could not be acquired

## Exhaustion Reason
- why all sources failed (inaccessible, content mismatch, etc.)

## Attempted Strategies
- list the search queries and approaches that were tried in the origin task
- future tasks must use different strategies to avoid repeating the same failed searches

## Status
- `open` / `resolved` / `permanent`

## Retry Count
- number of tasks that have attempted to resolve this gap (incremented by each retry task)

## Resolution
- write `none` when `Status: open`
- when resolved: the task ID and ACQ event that successfully acquired the knowledge

## Scan History
- `{task-id}`: scanned, `{action}` (e.g. `retry-planned`, `not-relevant`, `resolved`)
```

## Lifecycle

- **Created by**: terminal `Learning` step 6, when an ACQ event is `exhausted`
- **Scanned by**: `Learning(Read)` as part of `§Pending Cross-Task Items`
- **Resolved by**: a future task that successfully acquires the knowledge; the resolving task updates `Status: resolved` and fills `Resolution`

## Fixed Rules

- a gap file must not be created for ACQ events that completed successfully
- a gap file must reference a real ACQ event recorded in the origin task's `state.md`
- `Status: open` gaps must not be deleted; they are resolved by updating the `Status` field
- `Attempted Strategies` must not be omitted; future retry tasks must consult this field and use different search approaches
- `Learning(Read)` scans this directory read-only; it does not modify gap files except `§Scan History` (per `learning-read/README.md §Write Scope`)
- when a retry task's `Learning(Acquire)` targets this gap and the event is `exhausted`, terminal `Learning` must increment `Retry Count` in the gap file; if `Retry Count` reaches 3 and the gap is still unresolved, the task must set `Status: permanent` — the gap requires human intervention and is no longer automatically retried
- when a retry task's `Learning(Acquire)` targets this gap and the event `completed` successfully, terminal `Learning` must update `Status: resolved` and fill the `Resolution` field — `Retry Count` is not incremented for a successful resolution
