# learning

This directory defines the `Learning` module.

Responsibilities:

- provide `Learning(Read)` before task execution
- acquire and ground external knowledge through `Learning(Acquire)` when needed
- receive candidate knowledge
- review whether that knowledge should be absorbed
- consolidate knowledge assets
- produce `Capability Update`

Notes:

- `Learning(Read)` reads only `mind/soul/core.md` and `mind/learning/knowledge-base/approved/`
- `Learning(Acquire)` is mandatory whenever external information is needed; it must complete before `tl-{task-id}.md` references any external source
- terminal `Learning` may have multiple input sources, but its output path is fixed
- the internal `Learning` process must remain stable and strictly ordered

## Three Participation Modes

- `Learning(Read)`
  - occurs before `Recognition`
  - is read-only with respect to formal knowledge sources, but must write `tasks/{task-id}/learning-read.md`
  - reads only:
    - `mind/soul/core.md`
    - `mind/learning/knowledge-base/approved/`
  - provides directly readable constraints and knowledge files to `Recognition` and `Analysis`
  - must generate `tasks/{task-id}/learning-read.md` as the formal audit record
  - must not read:
    - `mind/learning/knowledge-base/drafts/`
    - `mind/learning/knowledge-base/archived/`
    - `mind/learning/task-learning/`
    - `mind/learning/reviews/`
    - `mind/learning/capability-updates/`

- `Learning(Acquire)`
  - triggered in exactly two conditions:
    - **Step-triggered**: a `Step` identifies a knowledge gap requiring external information
    - **Reflection-triggered**: `reflection-report.md` identifies a problem whose resolution requires external information
  - must execute in three stages in fixed order:
    1. **Search**: issue queries, record candidate URLs only — search summaries must not enter the pipeline
    2. **Fetch and Preserve**: fetch each candidate URL, save complete original content verbatim to `tasks/{task-id}/acquire/raw-sources/`
    3. **Verify**: dispatch an independent subagent to re-access each URL and confirm content match; produce `tasks/{task-id}/acquire/verification-report.md`
  - only sources listed as `passed` in the verification report may be cited in `tl-{task-id}.md`
  - see `mind/learning/acquire/README.md` for full protocol

- `Learning`
  - occurs after `Reflection`
  - is responsible for absorbing candidate knowledge and forming `Capability Update`

## Required Reads

See `tasks/TEMPLATE.md §Required Reads Map` for the formal list of files that must be read before each Learning participation mode.

Before running `Learning(Acquire)`, also read `mind/learning/acquire/README.md`.

## Internal Stages

- `Intake`
- `Drafting`
- `Review`
- `Consolidation`
- `Capability Update`

## Fixed Execution Order

Terminal `Learning` must execute in the following order and may not skip steps:

1. generate `mind/learning/task-learning/tl-{task-id}.md` from `reflection-report.md`; this file must always be written — if there are no learning candidates, write `Candidate Knowledge: none` and `Next Promotion Target: none` rather than omitting the file
2. if `tl-{task-id}.md` has `Candidate Knowledge: none`, skip steps 3 and 4 and proceed directly to step 5 (capability update check only); otherwise generate one or more `draft-{type}-{task-id}-{slug}.md` from `tl-{task-id}.md`
3. **dispatch an independent subagent** to generate each `review-{task-id}-{slug}.md`
   - the subagent prompt must provide: the `draft-*.md` path, the `Source Anchor` path, the output target, and an explicit instruction that the subagent must not carry any context from the drafting session
   - the agent that wrote the `draft-*.md` must not also write the corresponding `review-*.md`
   - `Verification Mode` in the review file must be `independent-subagent`; any review written in the same context as its draft is invalid and must record `Verification Mode: same-context` with `Decision: rejected`
4. only review records with `Decision: accepted` may generate `kb-{type}-{slug}.md`
5. if needed, generate `cu-{task-id}-{capability-name}.md` based on accepted review records or directly from `reflection-report.md §Capability Impact`

## Absolute Prohibition

**A search summary, snippet, or AI-generated overview is never a valid knowledge source.**

No candidate knowledge may enter `drafts/` unless it is traceable to either:

- a verified original source recorded in `tasks/{task-id}/acquire/raw-sources/` and listed as `passed` in `tasks/{task-id}/acquire/verification-report.md`, or
- a direct quotation from `tasks/{task-id}/_output/` or `tasks/{task-id}/cache/` with an explicit `Source Anchor`

Any `Candidate Conclusion` in `tl-{task-id}.md` that lacks a valid source anchor is invalid and must not be promoted to `drafts/`.

## Subdirectory Overview

- `knowledge-base/`: system-level knowledge assets
- `acquire/`: protocol and templates for `Learning(Acquire)`
- `learning-read/`: audit template for front-loaded `Learning(Read)`
- `task-learning/`: task-level `Learning Record`
- `reviews/`: learning review records
- `capability-updates/`: capability change records

## Fixed Promotion Path

Knowledge may be promoted only through the following path:

`task-learning/` -> `drafts/` -> `reviews/` -> `knowledge-base/approved/`

Additional rules:

- task-level knowledge that has not entered `drafts/` is not pending review knowledge
- draft knowledge that has not entered `reviews/` is not promotable knowledge
- knowledge that has not entered `knowledge-base/approved/` must not be read by `Learning(Read)`
- `knowledge-base/drafts/` is the only pending-review knowledge area
