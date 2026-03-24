# Task Learning Record Template

This file defines the fixed structure of task-level learning records.

## File Naming Rule

- file path: `mind/learning/task-learning/tl-{task-id}.md`
- `{task-id}` must match the source task

## Fixed Structure

```md
# Task Learning Record

## Task ID
- source task ID

## Task Summary
- what this task did
- what result it produced

## External Acquisition

A task may trigger `Learning(Acquire)` multiple times (once per Step that encounters a knowledge gap, plus once if `reflection-report.md` flags `Requires External Acquisition: yes`). Each trigger is a separate acquisition event. All events must be listed individually.

If no external sources were acquired during this task, write:
- Status: `none`

Otherwise, list one entry per acquisition event:

### ACQ-{NNN}: {trigger description}

- **Trigger**: which Step or reflection trigger initiated this acquisition
- **Status**: `completed` or `exhausted`
- **Verification Report**: `tasks/{task-id}/acquire/verification-report.md` §ACQ-{NNN} (all events share one file; each event has its own section)
- **Passed Sources**: list of src-{NNN} IDs cleared for use (write `none` if exhausted)
- If `exhausted`:
  - **Reason**: why all sources failed (inaccessible, content mismatch, etc.)
  - **Impact**: how the absence of grounded sources affects the learning candidates from `reflection-report.md`
  - when `exhausted`, any `Candidate Knowledge` that depended on this event must list `Derived Conclusion: none — ACQ-{NNN} exhausted` and must not be promoted

## Candidate Knowledge

Each candidate knowledge item must include a source anchor. Items without a valid source anchor are invalid and must not be promoted.

**Required writing order per item**: the source file must be opened and read first; the `Original Excerpt` must be copied directly from the file before `Derived Conclusion` is written. Writing `Derived Conclusion` before reading the source file is not permitted.

### [KDC-{NNN}] Candidate Knowledge Title

**Source Type**: `grounded-external` or `task-output`

For `grounded-external`:
- **Acquisition Event**: ACQ-{NNN} (must reference one of the events listed under `External Acquisition`)
- **Grounded Source**: `tasks/{task-id}/acquire/raw-sources/src-{NNN}-{slug}.md`
- **Verification Status**: must be `passed` (confirmed in the verification report of the referenced ACQ-{NNN})
- **Original Excerpt**: > "verbatim quote copied directly from the raw source file — must be read from file, not recalled from memory"
- **Derived Conclusion**: the conclusion drawn from the above excerpt — written only after Original Excerpt is set

For `task-output`:
- **Source Anchor**: `tasks/{task-id}/_output/{filename}.md §{Section}` or `tasks/{task-id}/cache/{filename}.md §{Section}`
- **Original Excerpt**: > "verbatim quote copied directly from the output or cache file — must be read from file, not recalled from memory"
- **Derived Conclusion**: the conclusion drawn from the above excerpt — written only after Original Excerpt is set

## Potential Capability Impact
- which `Capability` may be affected

## Next Promotion Target
- target draft file path
- write `none` if nothing should be promoted
```

## Validation Rules

- `Task ID` must not be omitted
- `External Acquisition` must not be omitted; if any acquisition occurred, every event must be listed as a separate ACQ-{NNN} entry
- `exhausted` must not be used to silently suppress learning; the `Impact` sub-field must explain what knowledge could not be grounded and why
- every item under `Candidate Knowledge` must have a `Source Type`, a source anchor field, an `Original Excerpt`, and a `Derived Conclusion`
- `Original Excerpt` must be a verbatim quote copied directly from the source file at write time — recalling from memory is not permitted; the source file must be read before the excerpt is written
- for `grounded-external` items, the `Acquisition Event` field must reference an existing ACQ-{NNN} entry in this file
- for `grounded-external` items, the cited `src-{NNN}` must appear in the `Passed Sources` list of the referenced ACQ-{NNN}
- `Candidate Knowledge` must not be omitted
- `Potential Capability Impact` must not be omitted
- `Next Promotion Target` must not be omitted
- if the corresponding `reflection-report.md` contains non-empty `Learning Candidates`, then `Next Promotion Target` must not be `none` — it must point to at least one `draft-*.md` target; writing `none` when the reflection has identified learning candidates is a protocol violation and must not occur silently; if promotion is genuinely not possible, the reason must be stated explicitly in a `Promotion Suppressed Reason` field
