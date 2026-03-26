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

Its input sources may vary, but its output path is fixed. It must execute in this order:

1. create `mind/learning/task-learning/tl-{task-id}.md` from `reflection-report.md`; this file must always be written — if there are no learning candidates, write `Candidate Knowledge: none` and `Next Promotion Target: none`
2. **self-review `tl-{task-id}.md` before promotion**: re-read each `Derived Conclusion` and verify it is clear, complete, and accurately supported by its `Original Excerpt`; if a conclusion is inadequate (vague, incomplete, or unsupported), revise it in `tl-{task-id}.md` now — this is the only stage where revision is permitted; once drafts are generated, `Candidate Conclusion` must be copied verbatim and can no longer be changed
3. if `tl-{task-id}.md` has `Candidate Knowledge: none`, skip steps 4 and 5 and proceed directly to step 6; otherwise generate one or more `draft-{type}-{task-id}-{slug}.md` from `tl-{task-id}.md`
4. **dispatch an independent subagent** to generate each `review-{task-id}-{slug}.md`
   - the subagent prompt must provide: the `draft-*.md` path, the `Source Anchor` path, the output target, and an explicit instruction that the subagent must not carry any context from the drafting session
   - the agent that wrote the `draft-*.md` must not also write the corresponding `review-*.md`
   - `Verification Mode` in the review file must be `independent-subagent`; any review written in the same context as its draft is invalid
5. only review records with `Decision: accepted` may generate `kb-{type}-{slug}.md`; when a `kb-*.md` is written to `approved/`, `INDEX.md` must be created or updated to list the new entry with its Type and one-line Summary
6. if needed, generate `cu-{task-id}-{capability-name}.md` based on accepted review records or directly from `reflection-report.md §Capability Impact`; reflection-triggered capability updates must be created with `Status: proposed`

## Subagent Unavailability

If the runtime environment does not support independent subagent dispatch for step 4 (review):

- the review must be written with `Verification Mode: same-context`
- per `reviews/TEMPLATE.md`, this forces `Decision: rejected` — the knowledge does not enter `approved/`
- this degradation must be recorded in `reflection-report.md §Issue Detection`

## Required Reads (for terminal Learning)

Before writing `tl-{task-id}.md`, the runtime must read:

- `tasks/{task-id}/reflection-report.md`
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
