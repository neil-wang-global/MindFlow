# MindFlow Runtime Constraints

You are running inside MindFlow.

Your job is not to invent a workflow. Your job is to execute the MindFlow workflow correctly.

Before starting any task, read `SYSTEM.md` for the complete protocol definition.

## Required Sequence

Every task must follow this exact sequence. Do not skip any stage.

1. `Learning(Read)` — read `mind/soul/core.md` and `mind/learning/knowledge-base/approved/`
2. `Recognition` — produce `tasks/{task-id}/task-profile.md`
3. `Analysis` — produce `tasks/{task-id}/analysis.md`
4. `Planning` — produce `tasks/{task-id}/plan.md`, then initialize `tasks/{task-id}/state.md`
5. `Execution Control` — advance `Step`s according to `plan.md`
6. Execute `Step`s — if a `Step` identifies an external knowledge gap, trigger `Learning(Acquire)` before proceeding
7. `Reflection` — produce `tasks/{task-id}/reflection-report.md`; if `Reflection` identifies a problem requiring external information, trigger `Learning(Acquire)` before writing `tl-{task-id}.md`
8. Terminal `Learning` — produce `mind/learning/task-learning/tl-{task-id}.md` and run the promotion path

## Required Reads

Before producing any artifact, read the files declared in `tasks/TEMPLATE.md §Required Reads Map`.

Before running `Learning(Acquire)`, read `mind/learning/acquire/README.md`.

## Formal Artifacts

Task-layer: `learning-read.md`, `state.md`, `task-profile.md`, `analysis.md`, `plan.md`, `reflection-report.md`, `_output/`, `cache/`, and (when `Learning(Acquire)` is triggered) `acquire/`.

Learning-layer: `tl-{task-id}.md`, `draft-{type}-{task-id}-{slug}.md`, `review-{task-id}-{slug}.md`, `kb-{type}-{slug}.md`, `cu-{task-id}-{capability-name}.md`.

Do not treat informal notes as substitutes for these files.

## Absolute Prohibitions

- Do not skip required stages
- Do not write directly into `mind/learning/knowledge-base/approved/` without a reviewed and accepted `review-*.md`
- Do not use search summaries, snippets, or AI overviews as knowledge sources — they may only be used to identify URLs
- Do not let the same agent both fetch and verify sources in `Learning(Acquire)`
- Do not cite sources that are not listed as `passed` in `verification-report.md`
- Do not execute from scattered notes or implied step lists — execute only from formal `plan.md`
- Do not replace file-based handoff with implicit conversational context
- During `Learning(Read)`, do not read `drafts/`, `archived/`, `task-learning/`, `reviews/`, or `capability-updates/`

## Task ID Rule

Format: `YYYYMMDD-short-name` (e.g. `20260324-refactor-learning`). A malformed `task-id` breaks cross-artifact traceability.

## Commit Rules

Before making any commit, ensure commit hooks are installed:

```sh
npm install
```

Do not include `Co-Authored-By`, `Made with`, `Generated with`, or `Signed-off-by` lines in commit messages — the commit hook will reject them.

Commit messages must follow conventional commits with a required scope and body.

## Recovery

If the current session is a continuation of a previous session, check `tasks/` for directories with `state.md` where `Overall Status` is not `completed`. If found, read `state.md` to determine the current phase and step, and resume from that point.

## General Discipline

- Prefer explicit file paths over vague references
- Prefer formal artifacts over conversational summaries
- Prefer deterministic output locations over ad hoc placement
- If a required file is missing, treat the chain as incomplete
- If a file does not match its required template, do not assume it is valid

MindFlow prioritizes stable execution over improvisation.
