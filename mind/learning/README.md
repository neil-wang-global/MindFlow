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

## Terminal Learning Protocol

Terminal `Learning` runs after `Reflection` and after all `Learning(Acquire)` events (including reflection-triggered ones) have completed. Upon entering, set `state.md`: `Current Phase: terminal-learning`. Upon completion, the final `Current Phase` and `Overall Status` depend on the entry state — see `SYSTEM.md §Phase Transition Protocol` step 9.

Because `tl-{task-id}.md` is written at this stage, it can consume both `reflection-report.md` and all ACQ event results simultaneously.

Its input sources may vary, but its output path is fixed.

### Inference Trigger Point

If terminal `Learning` requires abstraction beyond what source materials directly state, trigger `Inference` before step 1. The inference output is written to `cache/` and may be referenced as a `task-output` source in `tl-{task-id}.md`. See `mind/inference/README.md`.

### Pre-Write Reads

Before writing `tl-{task-id}.md`, if post-reflection `Learning(Acquire)` was executed, re-read the updated `tasks/{task-id}/acquire/` directory — including any newly added ACQ-{NNN} sections in `search-log.md`, `raw-sources/`, and `verification-report.md`. These post-reflection ACQ results must be included in `tl-{task-id}.md §External Acquisition`.

### Execution Steps

It must execute in this order:

1. create `mind/learning/task-learning/tl-{task-id}.md` from `reflection-report.md` and all ACQ event results (including post-reflection ones); this file must always be written — if there are no learning candidates, write `Candidate Knowledge: none` and `Next Promotion Target: none`
2. **self-review `tl-{task-id}.md` before promotion**: for each `Derived Conclusion`, apply these checks:
   - **Standalone clarity**: could a reader with no task context understand the conclusion?
   - **No information injection**: does the conclusion introduce claims not present in the `Original Excerpt`?
   - **Sufficient support**: does the `Original Excerpt` contain enough evidence to support every claim in the conclusion?
   - **Excerpt fidelity**: re-read the source file and confirm `Original Excerpt` is a verbatim substring (do not rely on memory)
   If any check fails, revise the conclusion (or excerpt, if the excerpt was incomplete) in `tl-{task-id}.md` now — this is the only stage where revision is permitted. **After step 2 completes, `tl-{task-id}.md` is frozen — no further edits are permitted for the remainder of the task.**
3. if `tl-{task-id}.md` has `Candidate Knowledge: none`, skip steps 4 and 5 and proceed directly to step 6; otherwise generate one or more `draft-{type}-{task-id}-{slug}.md` from `tl-{task-id}.md`
4. **dispatch an independent subagent** to generate each `review-{task-id}-{slug}.md`
   - the subagent prompt must provide: the `draft-*.md` path, the `Source Anchor` path, the output target, and an explicit instruction that the subagent must not carry any context from the drafting session; the subagent must have access to file read and search tools (e.g., Grep) to perform Source Anchor verification
   - the agent that wrote the `draft-*.md` must not also write the corresponding `review-*.md`
   - `Verification Mode` in the review file must be `independent-subagent`; any review written in the same context as its draft is invalid
5. only review records with `Decision: accepted` may generate `kb-{type}-{slug}.md`; when a `kb-*.md` is written to `approved/`, `INDEX.md` must be created or updated to list the new entry with its Type and one-line Summary
6. for each `exhausted` ACQ event in `tl-{task-id}.md §External Acquisition`, create `mind/learning/knowledge-gaps/gap-{task-id}-{slug}.md` with `Status: open` (see `mind/learning/knowledge-gaps/README.md` for structure); this enables future tasks' `Learning(Read)` to detect and retry the unresolved knowledge gap
7. if needed, generate `cu-{task-id}-{capability-name}.md` based on accepted review records or directly from `reflection-report.md §Capability Impact`; reflection-triggered capability updates must be created with `Status: proposed`

## Subagent Unavailability

If the runtime environment does not support independent subagent dispatch for step 4 (review):

- the review must be written with `Verification Mode: same-context`
- per `reviews/TEMPLATE.md`, this forces `Decision: rejected` — the knowledge does not enter `approved/`
- this degradation must be recorded in `reflection-report.md §Issue Detection`
- **Human review escalation**: if 2 or more consecutive tasks have produced `same-context` rejections, the runtime may escalate to human review — see `reviews/TEMPLATE.md §Human Review Escalation` for the full protocol

## Self-Check Points (terminal Learning)

These checks are referenced from `SYSTEM.md §Self-Check Points`. Each must pass before proceeding — stop and resolve on failure.

### ACQ Label Reconciliation

Before writing `tl-{task-id}.md`: read `state.md §Learning(Acquire) Log` and verify all ACQ labels are consistent with `acquire/search-log.md` and `acquire/verification-report.md`. On failure: pause and resolve the label mismatch before writing.

### Excerpt Fidelity Check

Before writing `draft-*.md`: verify that each `Original Excerpt` in `tl-{task-id}.md` is a verbatim substring of the referenced source file content (read the source file, do not rely on memory). On failure: correct the excerpt in `tl-{task-id}.md` (only if still in step 2 of terminal Learning; if already frozen, the candidate must not be promoted).

### Promotion Gate Check

Before writing `kb-*.md`: verify the corresponding `review-*.md` has `Decision: accepted`, `Verification Mode: independent-subagent` or `human-reviewed`, `Summary Verified: yes`, and `Source Anchor Verified: yes`. On failure: do not write the `kb-*.md`; the candidate remains in `drafts/`.

### Task Completion Check

Before marking task as `completed`: verify `_output/` is not empty and all Steps in `Step Status Map` are `completed` (or `failed` with escalation handled). On failure: do not mark the task as completed; investigate the missing output or unfinished Step.

## Required Reads (for terminal Learning)

Before writing `tl-{task-id}.md`, the runtime must read:

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
