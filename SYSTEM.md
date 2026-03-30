# MindFlow System Protocol

This file is the flow router and cross-module contract for AI running inside MindFlow.

It defines **what flows where** and **cross-module rules**. Module-internal rules live in each module's own `README.md` and are loaded when the runtime enters that module.

## Core Design Principle: Lazy Loading

This system is designed around **on-demand context loading**: a module's rules are loaded only when the runtime reaches that module, not before.

- `SYSTEM.md` (this file) is the only file loaded at task start. It defines the flow skeleton and cross-module rules.
- Each module's `README.md` is the self-contained authority for that module. It is loaded when the runtime **enters** that module — not at task start, not in advance.
- `TEMPLATE.md` files are loaded when **producing** an artifact of that type — not when entering the module.
- Directory index READMEs (`mind/README.md`, `tasks/README.md`, `sources/README.md`, `capabilities/README.md`) are navigation aids for human readers — the runtime does not load them.
- Do not pre-load, pre-scan, or pre-summarize module contents. If you have not entered a module, you do not need its rules.

This principle minimizes context noise and ensures that each module's rules are read fresh when they are actually needed.

## Constraint Loading Rule

There are two categories of loadable resources:

1. **Module READMEs** — loaded per §Core Design Principle above.
2. **Shared constraint sources** — files like `mind/soul/core.md` that are referenced by multiple modules. These are loaded whenever a module's `Required Reads` declares them. Each module that declares `core.md` must read it independently — Soul constraints must not be carried forward from a prior phase's memory.

Before entering any module or any `Step`, the AI must read that module's `README.md` (and `TEMPLATE.md` when producing an artifact). The `Required Reads` declared in that `README.md` are mandatory inputs for that phase and must also be read. Do not recursively chase secondary references from within those input files — only the module's own `README.md` defines what must be read. `SYSTEM.md` is assumed loaded at task start.

## Task Initialization

1. Read `SYSTEM.md` (this file)
2. Determine `task-id` (format: `YYYYMMDD-short-name`, see `CONTRIBUTING.md`)
3. Create `tasks/{task-id}/` with subdirectories `_output/` and `cache/`
4. Enter `Learning(Read)` — read `mind/learning/learning-read/README.md`, create `state.md` and `learning-read.md`
5. Follow the Required Main Flow below, loading each module's `README.md` on entry

## Required Main Flow

Every task must follow this exact flow:

`Task -> Learning(Read) -> Recognition -> Analysis -> Planning -> Execution Control -> Reflection -> Learning`

### Artifact Data Flow

```
learning-read.md → task-profile.md → analysis.md → plan.md → cache/ + _output/ → reflection-report.md → tl-{task-id}.md → draft-*.md → review-*.md → kb-*.md
```

### Task Type Variants

The main flow is the same for all task types (`delivery / learning / mixed`). The differences are in content expectations, not in flow structure:

- **delivery**: `_output/` must contain a concrete deliverable. `Learning Candidates` in `reflection-report.md` are expected but not mandatory.
- **learning**: `_output/` must contain a knowledge artifact (research summary, analysis document, etc.). `Learning(Acquire)` is expected. `reflection-report.md §Learning Candidates` must not be empty unless all acquisition events were exhausted.
- **mixed**: both a deliverable and learning output are expected. Evaluation criteria from both `delivery` and `learning` apply.

## Runtime Roles

- **Mind**: runtime base — drives task through all stages. See `mind/README.md`
- **Soul**: highest constraint layer — read via `mind/soul/core.md`. See `mind/soul/README.md`
- **Capability**: action unit called by Step — see `capabilities/README.md`
- **Plan**: formal output of Planning — see `mind/planning/README.md`
- **Step**: smallest execution unit inside Plan — see `mind/planning/TEMPLATE.md`
- **Execution Control**: executes the formal Plan — see `mind/execution-control/README.md`
- **Learning**: three modes (Read / Acquire / terminal) — see `mind/learning/README.md`
- **Reflection**: post-task review — see `mind/reflection/README.md`
- **Inference**: conditional module — see `mind/inference/README.md`

## Phase Transition Protocol

Every phase transition must update `tasks/{task-id}/state.md`. Each module is responsible for setting its own phase upon entry (see each module's `README.md §Phase Entry`). Exceptions: `Execution Control` phase is set by `Planning` upon plan completion; `Inference` does not set a separate phase (see §Inference State Rule below). Failure to update `state.md` makes the task non-recoverable.

The cross-module transition rules that no single module owns:

1. After `Execution Control` completes, transition to `Reflection` — see `mind/execution-control/README.md §Transition to Reflection` for the three scenarios and their `Overall Status` values
2. After `Reflection` completes, check whether either `Requires External Acquisition` sub-heading in `reflection-report.md` is `yes`:
   - **yes**: trigger `Learning(Acquire)` post-reflection — set `Current Phase: learning-acquire`; upon completion, set `Current Phase: terminal-learning`
   - **no**: set `Current Phase: terminal-learning` and proceed directly to terminal `Learning`
3. When `Learning(Acquire)` is triggered **mid-step**: set `Current Phase: learning-acquire`, mark Step as `blocked`; upon completion, restore `Current Phase: execution-control`, mark Step as `running`
4. Terminal `Learning` runs; upon completion, set final state based on `Overall Status` at entry: `completed` → `completed/completed`; `cancelled` → `cancelled/cancelled`; `failed` → `completed/failed`; `blocked` → `completed/blocked` (format: `Current Phase / Overall Status`)

### Inference State Rule

When `Inference` is triggered mid-phase (during `Analysis`, `Reflection`, or terminal `Learning`), `Current Phase` remains unchanged — `Inference` is a sub-operation within the triggering phase, not a separate phase. The inference output file path must be recorded in the triggering artifact's `Inference References` section.

## Cross-Module Rules

The following rules span multiple modules and are therefore defined here rather than in any single module's README.

### Knowledge Source Prohibition

A search summary, snippet, or AI-generated overview is never a valid knowledge source. This applies across all modules.

### Fixed Promotion Path

Knowledge must follow this path without shortcuts:

`task-learning/` → `drafts/` → `reviews/` → `knowledge-base/approved/`

Only approved knowledge may be reused by future `Learning(Read)`.

### Independent Subagent Review

Both `Learning(Acquire)` Stage 3 (verification) and terminal `Learning` step 4 (review) must be executed by an independent subagent that does not share execution context with the agent that produced the artifact being reviewed. Degradation rules are defined in each module's README.

### Cross-Task Staleness Thresholds

| Item Type | Mandatory Plan Step Threshold | Staleness Flag Threshold | Action on Staleness |
|-----------|------------------------------|--------------------------|---------------------|
| Capability Updates | 3+ pending | scan count > 2 | flag in reflection |
| Deferred Reviews | 2+ pending | scan count > 2 | re-open or reject |
| Knowledge Gaps | relevant to task | scan count > 3 | flag in reflection |

### Capability Update Advancement

- `Learning(Read)` scans `mind/learning/capability-updates/` for files with `Status: proposed` or `Status: approved`
- If 3 or more pending capability updates are found, the current task's `Plan` must include a dedicated `Step` to review and advance them
- Staleness is tracked via `§Scan History` in each file — if the scan count exceeds two, it must be flagged in `reflection-report.md §Issue Detection`
- Reflection-triggered capability updates must be created with `Status: proposed` and must not be advanced to `approved` or `applied` within the same task

### Deferred Review Advancement

- `Learning(Read)` scans `mind/learning/reviews/` for files with `Decision: deferred`
- If 2 or more deferred reviews are found, the current task's `Plan` must include a dedicated `Step` to re-evaluate them
- Staleness is tracked via `§Scan History` in each file — if the scan count exceeds two, it must be flagged in `reflection-report.md §Issue Detection` and must be either re-opened or explicitly converted to `rejected`
- Re-evaluation produces a new `review-{new-task-id}-{slug}.md` that references and supersedes the deferred review

### Knowledge Gap Retry Advancement

- `Learning(Read)` scans `mind/learning/knowledge-gaps/` for files with `Status: open`
- If an open knowledge gap is relevant to the current task's goal (as determined by `Analysis`), the `Plan` should include a `Step` with `Learning: acquire-required` targeting that gap; the `Step` instructions must reference the gap file and note the previous exhaustion reason so a different search strategy can be used
- If the gap is not relevant to the current task, no action is required — the gap remains `open` for a future relevant task
- Staleness is tracked via `§Scan History` in each file — if the scan count exceeds three, it must be flagged in `reflection-report.md §Issue Detection`
- When a future task successfully acquires the knowledge, terminal `Learning` must update the gap file to `Status: resolved` and fill the `Resolution` field

### Dispatch Field Consistency

The five canonical dispatch fields and their value domains:

- `Dispatch Mode`: `sequential / subagent / parallel-branch`
- `Parallel Group`: group label or `none` (default when sequential)
- `Synchronization Point`: Step reference or `none` (default when sequential)
- `Merge Owner`: Step reference or `none` (default when sequential)
- `Output Isolation`: description of output boundaries

These fields must remain structurally consistent across `analysis.md`, `plan.md`, and `reflection-report.md`.

### ACQ Label Consistency Rule

All `ACQ-{NNN}` labels must be consistent across `state.md §Learning(Acquire) Log`, `acquire/search-log.md`, `acquire/verification-report.md`, and `tl-{task-id}.md`. If a mismatch is detected, the runtime must pause and resolve before proceeding.

## Recovery Protocol

When a session resumes after interruption:

1. Scan `tasks/` for directories containing `state.md` where `Overall Status` is not `completed` and not `cancelled`
2. Read the `state.md` of the unfinished task to determine `Current Phase` and `Current Step`
3. Resume execution from the recorded phase and step — do not restart from the beginning
4. Before resuming, read the `README.md` of the module corresponding to `Current Phase`; also read `mind/soul/core.md` (Soul constraints must be reloaded on recovery regardless of phase)
5. **Early-phase recovery**: when `Current Phase` is `learning-read`, `recognition`, or `analysis`, check whether the phase's output artifact exists (`learning-read.md`, `task-profile.md`, or `analysis.md` / `analysis-plan.md` respectively); if the artifact exists and is complete, advance to the next phase; if missing or incomplete, re-execute the current phase
6. **Planning recovery**: when `Current Phase: planning` and `plan.md` already exists, complete the `state.md` updates (set `Current Phase: execution-control`, populate `Step Status Map`, set `Current Step` to Step 1) without re-running Planning
7. **Compact mode recovery**: when `Current Phase: analysis` but `analysis-plan.md` already exists, the task is in compact mode and analysis is complete — resume by transitioning directly to `execution-control` (populate `Step Status Map` and `Current Step` if not yet populated)
8. When `Current Phase: learning-acquire`, check `acquire/` directory to determine the sub-stage (search-log exists? raw-sources populated? verification-report exists?) and resume from the incomplete sub-stage
9. When `Current Phase: terminal-learning`, check which terminal Learning step was last completed: if `tl-{task-id}.md` does not exist, resume from step 1; if `tl-{task-id}.md` exists but no `draft-*.md`, resume from step 3; if `draft-*.md` exists but no `review-*.md`, resume from step 4; if `review-*.md` exists but no `kb-*.md` (and review is accepted), resume from step 5
10. If `state.md` is missing or corrupted, treat the task as non-resumable and report the issue

## Self-Check Points

At critical junctures, the runtime must pause and explicitly verify consistency before proceeding. If any check fails, **stop and resolve** — do not skip, defer, or work around a failed self-check.

Each check is defined in the module responsible for the artifact:

1. **Before writing `plan.md`** — see `mind/planning/README.md §Pre-Write Verification`
2. **Before executing a Step with `Learning: acquire-required`** — see `mind/execution-control/README.md §Pre-Step Verification`
3. **Before writing `tl-{task-id}.md`** — see `mind/learning/README.md §ACQ Label Reconciliation`
4. **Final sub-step of terminal Learning step 2 (before freeze)** — see `mind/learning/README.md §Excerpt Fidelity Check`
5. **Before writing `kb-*.md`** — see `mind/learning/README.md §Promotion Gate Check`
6. **Before marking task as `completed`** — see `mind/learning/README.md §Task Completion Check`
