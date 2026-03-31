# Verification Report Template

This file defines the fixed structure of `tasks/{task-id}/acquire/verification-report.md`.

## Execution Requirement

The verification report must be produced by an independent subagent that does not share execution context with the agent that performed the fetch stage. The verifying agent must:

1. Read `tasks/{task-id}/acquire/search-log.md` to obtain the declared `Fetch Plan` for each ACQ-{NNN} event
2. Read all files in `tasks/{task-id}/acquire/raw-sources/`
3. Cross-check per event using both URL and `ACQ Event` field:
   - every URL listed in the event's `Fetch Plan` must have a corresponding `src-*.md` file whose `ACQ Event` field matches this event; any URL with no such file must be recorded as `missing`
   - every `src-*.md` file whose `ACQ Event` field declares this event must have its URL listed in this event's `Fetch Plan`; any file that declares this event but whose URL is not in the Fetch Plan must be recorded as `unplanned` and treated as an unverifiable source
   - any `src-*.md` file with an `ACQ Event` field that does not match any known ACQ-{NNN} event must be recorded as `unplanned` and treated as an unverifiable source
4. Independently verify each URL in the `src-*.md` files — per `acquire/README.md §Verification flexibility`, header or partial re-fetch is sufficient; full content re-fetch and exact match are not required; confirm accessibility and that the domain/source type matches declared metadata

## File Path

`tasks/{task-id}/acquire/verification-report.md`

When a task has multiple acquisition events, all events are verified in a single report file. Each event is reported as a separate `ACQ-{NNN}` section. Label consistency rules: see `SYSTEM.md §ACQ Label Consistency Rule`.

## Fixed Structure

```md
# Acquire Verification Report

## Task ID
- source task ID

## Verification Timestamp
- date and time when verification was performed

## Verification Mode
- `independent-subagent` — this report was produced by a subagent with no shared context with the fetching agent
- `same-context` — this report was produced in the same execution context as fetching (degraded; see `acquire/README.md §Subagent Unavailability`)

## Summary
- total acquisition events: N
- total sources verified: N
- passed: N
- failed: N
- downgraded: N

## ACQ-{NNN}: {trigger description}

### Fetch Coverage

Cross-check between this event's `Fetch Plan` in `search-log.md` and actual `raw-sources/` files:

| Status | URL | Detail |
|--------|-----|--------|
| covered | https://... | src-001 present |
| missing | https://... | in Fetch Plan but no src-*.md found |
| unplanned | https://... | src-*.md exists but URL not in Fetch Plan |

- `missing` sources: these URLs were planned but not fetched; record why if known
- `unplanned` sources: these files have no declared provenance; their verification status must be `failed`

### Source Verification Results

#### src-{NNN}: {slug}

- **URL**: the URL verified
- **Accessibility**: accessible / inaccessible / redirected
- **Content Match**: matched / substantially-matched / mismatched / partial
- **Verification Status**: `passed` / `failed` / `downgraded`
- **Notes**: any discrepancy or issue found

(repeat for each source in this event)

### Passed Sources for ACQ-{NNN}

List of source IDs that passed verification for this event and may be cited in `tl-{task-id}.md`:

- src-{NNN}
- src-{NNN}

### Event Conclusion
- whether sufficient grounded sources exist for this acquisition event

(repeat ACQ-{NNN} section for each additional acquisition event)

## Failed Sources (all events)

| Source ID | ACQ Event | URL | Failure Reason | Disposition |
|-----------|-----------|-----|---------------|-------------|
| src-001 | ACQ-001 | https://... | 404 Not Found | eliminated |
| src-002 | ACQ-002 | https://... | content mismatch | eliminated |

## Downgraded Sources (all events)

| Source ID | ACQ Event | Reason | Downgrade Action |
|-----------|-----------|--------|-----------------|
| src-003 | ACQ-001 | low authority source | annotated as low credibility |

## Overall Verification Conclusion
- overall assessment across all events
- whether sufficient grounded sources exist to support the knowledge acquisition goals of this task
```

## Content Match → Verification Status Mapping

| Accessibility | Content Match | → Verification Status |
|--------------|---------------|----------------------|
| accessible | matched | `passed` |
| accessible | substantially-matched | `passed` (with note explaining variance) |
| accessible | partial | `downgraded` |
| accessible | mismatched | `failed` |
| inaccessible | any | `failed` |
| redirected | matched or substantially-matched | `passed` (with note about redirect) |
| redirected | partial or mismatched | `failed` |

## Validation Rules

- `Verification Mode` must not be omitted; must be `independent-subagent` or `same-context`
- when `Verification Mode: same-context`, all sources are treated as `downgraded` and the event is marked `exhausted` (per `acquire/README.md §Subagent Unavailability`)
- every ACQ-{NNN} event listed in `search-log.md` must have a corresponding section in this report
- `Fetch Coverage` must not be omitted for each event; the cross-check between Fetch Plan and raw-sources must be explicit
- `unplanned` sources must be assigned `Verification Status: failed` and must not appear in any `Passed Sources` list
- `Passed Sources for ACQ-{NNN}` is the only authoritative list of sources permitted to enter the learning pipeline for that event
- a source not listed under the relevant `Passed Sources for ACQ-{NNN}` must not be cited in any `tl-*.md`, `draft-*.md`, or `kb-*.md` file
- `Verification Timestamp` must not be omitted
