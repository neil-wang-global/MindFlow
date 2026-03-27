# Learning(Acquire)

This directory defines the `Learning(Acquire)` module.

`Learning(Acquire)` is a mandatory acquisition stage that must be completed before any external knowledge enters the learning pipeline. It enforces that all externally sourced knowledge is grounded in original fetched content, independently verified, and fully traceable.

## Trigger Conditions

`Learning(Acquire)` must be triggered in exactly two scenarios:

- **Step-triggered**: during `Step` execution, the agent identifies a knowledge gap that requires external information to resolve
- **Reflection-triggered**: after `Reflection`, `reflection-report.md` identifies a problem whose resolution requires external information

In both cases, `Learning(Acquire)` must complete before `tl-{task-id}.md` is written for any externally sourced knowledge item.

## Non-Negotiable Constraints

- **Search results are leads, not knowledge.** Search engine summaries, snippets, and AI-generated overviews must never be used as knowledge sources. They exist only to identify URLs worth fetching.
- **Fetch before you record.** Every piece of external information must originate from a fetched original source. If a page cannot be fetched, that information cannot enter the pipeline.
- **Preserve original content in full.** Fetched content must be saved as fetched by the tool, without modification, into `tasks/{task-id}/acquire/raw-sources/`.
- **Verification must use an independent context.** See Stage 3 below.
- **Unverified sources must not enter drafts.** Only sources that pass verification may be referenced in `tl-{task-id}.md`.

## Tool Unavailability

If search or fetch tools are not available in the current runtime environment, the acquisition event must be treated as `exhausted` with reason `required tools unavailable`. Follow the exhausted outcome rules below.

## Three-Stage Protocol

`Learning(Acquire)` executes in exactly this order and must not skip any stage:

### Stage 1: Search

Use search tools to identify candidate URLs relevant to the knowledge gap.

- Issue at least 2 search queries with different phrasings to ensure coverage
- Select at least 2 candidate URLs per query when possible
- If the first query identifies a primary authoritative source (e.g., official RFC, specification, canonical documentation), the second query may be narrowed to confirming alternatives or counterpoints rather than broad re-search
- If initial queries return no relevant results, refine query terms and retry once before declaring the search phase complete
- Record all candidate URLs
- Do not read, quote, or use any summary text from search results
- Output: `tasks/{task-id}/acquire/search-log.md` (see `SEARCH-LOG-TEMPLATE.md`)

### Stage 2: Fetch and Preserve

For each candidate URL:

1. Fetch the original page content using a web fetch tool
2. Save the complete fetched content without modification
3. Record the source URL, fetch timestamp, and source type
4. If a page cannot be fetched, record the failure and find an alternative; never fall back to the search summary

Output: one file per source in `tasks/{task-id}/acquire/raw-sources/` (see `RAW-SOURCES-TEMPLATE.md`)

### Stage 3: Verification

**Dispatch Mode: independent subagent — this stage must not be executed by the agent that performed Stage 2.**

The subagent must be dispatched with an explicit prompt that includes:
- the ACQ-{NNN} label being verified
- the path `tasks/{task-id}/acquire/search-log.md`
- the path `tasks/{task-id}/acquire/raw-sources/`
- the output path `tasks/{task-id}/acquire/verification-report.md`
- the instruction that this subagent must NOT carry context from Stage 2

The verification subagent must:

1. Read the ACQ-{NNN} section of `search-log.md` for the declared Fetch Plan
2. Read all files in `raw-sources/`
3. Cross-check coverage: every planned URL must have a `src-*.md`; every `src-*.md` must be in the plan
4. Verify each source: confirm URL accessibility, assess content consistency, evaluate source credibility
5. Write the ACQ-{NNN} section of `verification-report.md` (see `VERIFICATION-TEMPLATE.md`)

**Verification flexibility**: The subagent may verify accessibility by re-fetching the URL header or partial content. Full content re-fetch and exact match are not required — the subagent should confirm that the URL is accessible and the domain/source type matches the declared metadata. Content drift on dynamic pages is expected and should not automatically fail verification.

Only sources listed as `passed` in `Passed Sources for ACQ-{NNN}` may be cited in `tl-{task-id}.md`.

## Subagent Unavailability

If the runtime environment does not support independent subagent dispatch for Stage 3:

- the verification report must be written with `Verification Mode: same-context` annotation
- all sources are treated as `downgraded`
- the event is marked `exhausted` with reason `independent verification unavailable`
- this degradation must be recorded in `reflection-report.md §Issue Detection`
- note: `downgraded` sources from `same-context` verification may still enter the learning pipeline if human review escalation is triggered at the terminal Learning review stage — see `mind/learning/reviews/TEMPLATE.md §Human Review Escalation`

## Multi-Event Structure

A task may trigger `Learning(Acquire)` more than once. Each trigger is a separate acquisition event identified as `ACQ-001`, `ACQ-002`, etc.

All events share the same `acquire/` directory. The `search-log.md` and `verification-report.md` files contain one section per event. Raw source files from all events share `raw-sources/`; source IDs are unique across all events.

## Output Structure

```text
tasks/{task-id}/acquire/
├── search-log.md              (one ACQ-{NNN} section per event)
├── raw-sources/
│   ├── src-001-{slug}.md
│   ├── src-002-{slug}.md
│   └── ...
└── verification-report.md     (one ACQ-{NNN} section per event)
```

## Exhausted Outcome

When all sources fail verification for a given event (zero `passed`), that event is **exhausted**.

- `tl-{task-id}.md` must record the entry with `Status: exhausted`
- the triggering knowledge gap must be documented as unresolvable
- the corresponding `Candidate Knowledge` item must not be promoted to `drafts/`
- do not fabricate alternative sources or fall back to search summaries

An exhausted outcome is a legitimate terminal state, not a protocol failure.

### Cross-Task Retry for Exhausted Events

An exhausted event must be recorded in `reflection-report.md §Issue Detection` as a knowledge gap. Terminal `Learning` must also create a `gap-{task-id}-{slug}.md` file in `mind/learning/knowledge-gaps/` with `Status: open` (see `mind/learning/knowledge-gaps/README.md`). Future tasks' `Learning(Read)` scans `knowledge-gaps/` for open gaps, enabling detection and retry with different search strategies. A retry is a new ACQ event with a new ACQ label, not a continuation of the old one. When a future task successfully acquires the knowledge, it must update the gap file to `Status: resolved`.

## What Learning(Acquire) Does Not Do

- It does not analyze, interpret, or draw conclusions from fetched content
- It does not decide which knowledge is worth learning — that belongs to `tl-{task-id}.md`
- It does not write into `drafts/` — that belongs to terminal `Learning`

## Lifecycle of the acquire/ Directory

The `acquire/` directory must not be deleted while any derived knowledge has not yet been promoted to `approved/`. Once all derived knowledge is promoted and `kb-*.md` files record the `Original Source URL`, the directory may be archived or removed.
