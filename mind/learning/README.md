# learning

This directory defines the `Learning` module.

## Responsibilities

- provide `Learning(Read)` before task execution
- acquire and ground external knowledge through `Learning(Acquire)` when needed
- receive candidate knowledge
- review whether that knowledge should be absorbed
- consolidate knowledge assets
- produce `Capability Update`

## Three Participation Modes

- `Learning(Read)`: see `mind/learning/learning-read/README.md`
- `Learning(Acquire)`: see `mind/learning/acquire/README.md`
- terminal `Learning`: defined in this file (below)

## Phase Entry

Upon entering terminal `Learning`, set `state.md`: `Current Phase: terminal-learning`.

## Terminal Learning Protocol

Terminal `Learning` runs after `Reflection` and after all `Learning(Acquire)` events (including reflection-triggered ones) have completed. Upon completion, the final `Current Phase` and `Overall Status` depend on the entry state — see `SYSTEM.md §Phase Transition Protocol` step 4.

Because `tl-{task-id}.md` is written at this stage, it can consume both `reflection-report.md` and all ACQ event results simultaneously.

Its input sources may vary, but its output path is fixed.

### Inference Trigger Point

After completing §Required Reads and before step 1, evaluate whether `Inference` is needed. If terminal `Learning` requires abstraction beyond what source materials directly state, trigger `Inference` at this point. The inference output is written to `cache/` and may be referenced as a `task-output` source in `tl-{task-id}.md`. See `mind/inference/README.md`.

### Pre-Write Reads

Before writing `tl-{task-id}.md`, if post-reflection `Learning(Acquire)` was executed, re-read the updated `tasks/{task-id}/acquire/` directory — including any newly added ACQ-{NNN} sections in `search-log.md`, `raw-sources/`, and `verification-report.md`. These post-reflection ACQ results must be included in `tl-{task-id}.md §External Acquisition`.

### Execution Steps

It must execute in this order:

1. create `mind/learning/task-learning/tl-{task-id}.md` from `reflection-report.md` and all ACQ event results (including post-reflection ones); this file must always be written — if there are no learning candidates, write `Candidate Knowledge: none` and `Next Promotion Target: none`
2. **self-review `tl-{task-id}.md` before promotion**: for each `Derived Conclusion`, apply these checks:
   - **Standalone clarity**: could a reader with no task context understand the conclusion?
   - **No information injection**: does the conclusion introduce claims not present in the `Original Excerpt`?
   - **Sufficient support**: does the `Original Excerpt` contain enough evidence to support every claim in the conclusion?
   - **Excerpt fidelity**: re-read the source file and confirm `Original Excerpt` is a verbatim substring (do not rely on memory); apply the same whitespace normalization and substring match logic defined in `mind/learning/reviews/TEMPLATE.md §Source Anchor Verified`
   If any check fails, revise the conclusion (or excerpt, if the excerpt was incomplete) in `tl-{task-id}.md` now — this is the only stage where revision is permitted. **After step 2 completes, `tl-{task-id}.md` is frozen — no further edits are permitted for the remainder of the task. Reads are always permitted; frozen means write-locked only.**
3. if `tl-{task-id}.md` has `Candidate Knowledge: none`, skip steps 4 and 5 and proceed directly to step 6 (steps 6 and 7 always execute regardless of whether knowledge candidates exist); otherwise read `mind/learning/knowledge-base/drafts/TEMPLATE.md` and generate one or more `draft-{type}-{task-id}-{slug}.md` from `tl-{task-id}.md`
4. **dispatch an independent subagent** to generate each `review-{task-id}-{slug}.md`; the subagent must read `mind/learning/reviews/TEMPLATE.md` before writing
   - the subagent prompt must provide: the `draft-*.md` path, the `Source Anchor` path, the output target, and an explicit instruction that the subagent must not carry any context from the drafting session; the subagent must have access to file read and search tools (e.g., Grep) to perform Source Anchor verification
   - the agent that wrote the `draft-*.md` must not also write the corresponding `review-*.md`
   - `Verification Mode` in the review file must be `independent-subagent`; any review written in the same context as its draft is invalid
5. only review records with `Decision: accepted` may generate `kb-{type}-{slug}.md`; read `mind/learning/knowledge-base/approved/TEMPLATE.md` before writing; if a `kb-*.md` with the same name already exists in `approved/`, move the existing file to `archived/` first (per `approved/README.md §Prohibitions` and `archived/README.md §Superseded Approved Knowledge`); when a `kb-*.md` is written to `approved/`, `INDEX.md` must be created or updated to list the new entry with its Type and one-line Summary; for review records with `Decision: rejected`, move the corresponding `draft-*.md` from `drafts/` to `archived/` (per `reviews/TEMPLATE.md §Rejected Decision Handling` and `archived/README.md §Rejected Drafts`); for review records with `Decision: deferred`, the corresponding `draft-*.md` remains in `drafts/` (per `reviews/TEMPLATE.md §Deferred Decision Lifecycle`)
6. process knowledge gap files based on ACQ event outcomes in `tl-{task-id}.md §External Acquisition`:
   - for each `completed` ACQ event that targeted an existing gap file in `mind/learning/knowledge-gaps/`: update that file to `Status: resolved`, fill the `Resolution` field with the current task-id and ACQ event label (per `SYSTEM.md §Knowledge Gap Retry Advancement`)
   - for each `exhausted` ACQ event: if the event targeted an existing gap file, update that file — increment `Retry Count`, append to `Attempted Strategies`, and if `Retry Count` reaches 3, set `Status: permanent` (per `knowledge-gaps/README.md §Fixed Rules`); if the event did not target an existing gap, create a new `mind/learning/knowledge-gaps/gap-{task-id}-{slug}.md` with `Status: open` (see `mind/learning/knowledge-gaps/README.md` for structure)
7. if needed, generate `cu-{task-id}-{capability-name}.md` based on accepted review records; if `reflection-report.md §Capability Impact` identifies a capability change not covered by any review record, create the `cu-*.md` with `Status: proposed` (requires review before activation)

## Subagent Unavailability

If the runtime environment does not support independent subagent dispatch for step 4 (review):

- the review must be written with `Verification Mode: same-context`
- per `reviews/TEMPLATE.md`, this forces `Decision: rejected` — the knowledge does not enter `approved/`
- this degradation must be recorded in `tl-{task-id}.md §Notes`
- **Human review escalation**: if the escalation trigger defined in `reviews/TEMPLATE.md §Human Review Escalation` is met, the runtime may escalate to human review — see that section for the full protocol

## Self-Check Points (terminal Learning)

These checks are referenced from `SYSTEM.md §Self-Check Points`. Each must pass before proceeding — stop and resolve on failure.

### ACQ Label Reconciliation

Before writing `tl-{task-id}.md`: read `state.md §Learning(Acquire) Log` and verify all ACQ labels are consistent with `acquire/search-log.md` and `acquire/verification-report.md`. On failure: pause and resolve the label mismatch before writing.

**Resolve action**: `state.md §Learning(Acquire) Log` is the authoritative first-written record. If the mismatch is a numbering error (e.g., `ACQ-001` in `state.md` but `ACQ-002` in `search-log.md` for the same event), normalize all files to the label recorded in `state.md`. If the mismatch is structural (e.g., an event exists in one file but not another), investigate which file is incomplete and fill the missing entry before proceeding.

### Excerpt Fidelity Check

Defined inline in §Execution Steps step 2. Verification: re-read source file, confirm `Original Excerpt` is a verbatim substring (apply whitespace normalization per `reviews/TEMPLATE.md §Source Anchor Verified`). On failure: correct in `tl-{task-id}.md` before freeze. Once this check passes, step 2 is complete and the file is frozen.

### Promotion Gate Check

Before writing `kb-*.md`: verify the corresponding `review-*.md` has `Decision: accepted`, `Verification Mode: independent-subagent` or `human-reviewed`, `Summary Verified: yes`, and `Source Anchor Verified: yes`. On failure: do not write the `kb-*.md`; the candidate remains in `drafts/`.

### Task Completion Check

Before setting the final state per `SYSTEM.md §Phase Transition Protocol` step 4: when `Overall Status` at entry is `completed`, verify `_output/` is not empty and all Steps in `Step Status Map` are `completed` (or `failed` with escalation handled). On failure: do not mark the task as completed; investigate the missing output or unfinished Step. When `Overall Status` at entry is `failed`, `blocked`, or `cancelled`, the `_output/` non-empty check is waived — proceed to set the final state.

## Required Reads (for terminal Learning)

Before writing `tl-{task-id}.md`, the runtime must read:

- `mind/soul/core.md`
- `tasks/{task-id}/reflection-report.md`
- `tasks/{task-id}/task-profile.md` (for task type, goal, and success criteria context)
- `tasks/{task-id}/plan.md` (or `analysis-plan.md` in compact mode — for Step structure and capability usage)
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/_output/`
- `tasks/{task-id}/cache/`
- `tasks/{task-id}/acquire/verification-report.md` (if `Learning(Acquire)` was executed)

Before running `Learning(Acquire)` mid-flow, also read `mind/learning/acquire/README.md`.

## Subdirectory Overview

- `knowledge-base/`: system-level knowledge assets
- `acquire/`: protocol and templates for `Learning(Acquire)`
- `learning-read/`: audit template for front-loaded `Learning(Read)`
- `task-learning/`: task-level `Learning Record`
- `reviews/`: learning review records
- `capability-updates/`: capability change records
- `knowledge-gaps/`: unresolved knowledge gap records from exhausted ACQ events
