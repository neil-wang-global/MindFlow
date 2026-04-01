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

### Soul Auto-Load Rule

`mind/soul/core.md` must be loaded on every module entry. This is a cross-module invariant — Soul constraints apply to all phases without exception.

Every module's Required Reads (or Read Scope) must include `mind/soul/core.md`. If a module's README omits this line, it is a protocol defect that must be corrected. The redundancy between this global rule and per-module declarations is intentional: it prevents omission when new modules are added.

This rule also covers:
- Recovery (§Recovery Protocol step 4 mandates soul reload)
- Subagent dispatch (§Subagent Soul Constraint mandates soul inclusion in prompts)

### Subagent Soul Constraint

When the main agent dispatches a subagent to execute a sub-operation (e.g., review verification, ACQ Stage 3 verification), the subagent's prompt must include `mind/soul/core.md` in its entirety. Soul constraints must not be lost at subagent boundaries.

Subagent prompts should follow the **minimum context principle**:

- **Must include**: `mind/soul/core.md` (complete content, not a summary)
- **Must include**: the `README.md` and `TEMPLATE.md` of the module relevant to the sub-operation (e.g., `reviews/TEMPLATE.md` for review subagents)
- **Should not include**: other modules' README/TEMPLATE files, the full `SYSTEM.md`, or unrelated historical context
- **Exception**: if the sub-operation requires cross-module information, include only the specific file needed

## Task Initialization

1. Read `SYSTEM.md` (this file)
2. Determine `task-id` (format: `YYYYMMDD-short-name`, see `CONTRIBUTING.md`)
3. Create `tasks/{task-id}/` with subdirectories `_output/` and `cache/`
4. Enter `Learning(Read)` — read `mind/learning/learning-read/README.md`, create `state.md` and `learning-read.md`
5. Follow the Required Main Flow below, loading each module's `README.md` on entry

## Required Main Flow

Every task must follow this exact flow — no module may be skipped or reordered:

`Task -> Learning(Read) -> Recognition -> Analysis -> Planning -> Execution Control -> Reflection -> Learning`

Each module transition is guarded by the exiting module's Exit Validation. The next module in the flow must be the one listed above — the runtime must not skip ahead (e.g., Learning(Read) must be followed by Recognition, not Analysis).

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

Every phase transition must update `tasks/{task-id}/state.md`. Each module is responsible for setting its own phase upon entry (see each module's `README.md §Phase Entry`). Exceptions: `Execution Control` phase is set by `Planning` upon plan completion (or by `Analysis` in compact mode — see `mind/analysis/README.md §Compact Mode`); `Inference` does not set a separate phase (see §Inference State Rule below); `Learning(Acquire)` phase is set by the runtime (Mind) at the trigger point, not by the acquire module itself (see steps 2–3 below). Failure to update `state.md` makes the task non-recoverable.

The cross-module transition rules that no single module owns:

1. After `Execution Control` completes, transition to `Reflection` — see `mind/execution-control/README.md §Transition to Reflection` for the three scenarios and their `Overall Status` values
2. After `Reflection` completes, check whether either `Requires External Acquisition` sub-heading in `reflection-report.md` is `yes`:
   - **yes**: trigger `Learning(Acquire)` post-reflection — set `Current Phase: learning-acquire`, `Ready For Reflection: no`; upon completion, set `Current Phase: terminal-learning`
   - **no**: set `Current Phase: terminal-learning`, `Ready For Reflection: no`, and proceed directly to terminal `Learning`
3. When `Learning(Acquire)` is triggered **mid-step**: set `Current Phase: learning-acquire`, mark Step as `blocked`; `Overall Status` remains `running`; upon completion, restore `Current Phase: execution-control`, mark Step as `running`
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
| Same-Context Rejections | 2+ accumulated | — | human review escalation |
| ACQ Verification Gaps | 2+ with `independent verification unavailable` | — | human verification escalation |

### Capability Update Advancement

- `Learning(Read)` scans `mind/learning/capability-updates/` for files with `Status: proposed` or `Status: approved`
- Thresholds and staleness actions: see §Cross-Task Staleness Thresholds table above
- Staleness is tracked via `§Scan History` in each file
- Reflection-triggered capability updates must be created with `Status: proposed` and must not be advanced to `approved` or `applied` within the same task
- **Advancement workflow**: when `Analysis` identifies pending capability updates exceeding thresholds, a maintenance `Step` must be included in the `Plan`; that `Step` is responsible for reviewing the `cu-*.md`, advancing `proposed → approved` (if the change is confirmed valid), and `approved → applied` (if the target capability file is updated); `applied` status requires the `Applied Changes` and `Validation` fields to be filled

### Deferred Review Advancement

- `Learning(Read)` scans `mind/learning/reviews/` for files with `Decision: deferred`
- Thresholds and staleness actions: see §Cross-Task Staleness Thresholds table above
- Staleness is tracked via `§Scan History` in each file
- Re-evaluation produces a new `review-{new-task-id}-{slug}.md` that references and supersedes the deferred review

### Knowledge Gap Retry Advancement

- `Learning(Read)` scans `mind/learning/knowledge-gaps/` for files with `Status: open`
- Gaps with `Status: permanent` are skipped — they require human intervention
- Thresholds and staleness actions: see §Cross-Task Staleness Thresholds table above
- Staleness is tracked via `§Scan History` in each file
- If an open gap is relevant to the current task's goal (as determined by `Analysis`), the `Plan` should include a `Step` with `Learning: acquire-required` targeting that gap; the `Step` instructions must reference the gap file and note the previous exhaustion reason so a different search strategy can be used
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

All `ACQ-{NNN}` labels must be consistent across `state.md §Learning(Acquire) Log`, `acquire/search-log.md`, `acquire/verification-report.md`, and `tl-{task-id}.md`. Resolution protocol: see `mind/learning/README.md §ACQ Label Reconciliation`.

## Recovery Protocol

When a session resumes after interruption:

1. Scan `tasks/` for directories containing `state.md` where `Current Phase` is not `completed` and not `cancelled` (note: when terminal `Learning` completes, `Current Phase` is always set to `completed` or `cancelled` per §Phase Transition Protocol step 4, regardless of `Overall Status`; such tasks are finished and must not be recovered)
2. Read the `state.md` of the unfinished task to determine `Current Phase` and `Current Step`
3. Resume execution from the recorded phase and step — do not restart from the beginning
4. Before resuming, read the `README.md` of the module corresponding to `Current Phase`; also read `mind/soul/core.md` (Soul constraints must be reloaded on recovery regardless of phase)
5. **Early-phase recovery**: when `Current Phase` is `learning-read`, `recognition`, or `analysis`, check whether the phase's output artifact exists (`learning-read.md`, `task-profile.md`, or `analysis.md` / `analysis-plan.md` respectively); if the artifact exists and passes its `TEMPLATE.md §Validation Rules`, update `state.md` to the next phase and advance; if missing or incomplete, re-execute the current phase
6. **Execution-control recovery**: when `Current Phase: execution-control`, read `Step Status Map` to find the first non-completed Step; set `Current Step` to that Step and resume execution; if the interrupted Step was `running`, re-read its Constraints and Inputs before resuming
7. **Reflection recovery**: when `Current Phase: reflection`, check whether `reflection-report.md` exists and passes `TEMPLATE.md §Validation Rules`; verify `Overall Status` is one of `completed / failed / blocked / cancelled` (as set by Execution Control before entering Reflection; `cancelled` triggers lightweight Reflection per `mind/execution-control/README.md §Cancellation Protocol`); if complete, advance to the post-reflection ACQ check (§Phase Transition Protocol step 2) — for `cancelled` tasks, this check will yield `no` since both `Requires External Acquisition` fields must be `no`; if missing or incomplete, re-execute Reflection
8. **Planning recovery**: when `Current Phase: planning` and `plan.md` already exists, complete the `state.md` updates (set `Current Phase: execution-control`, populate `Step Status Map`, set `Current Step` to Step 1) without re-running Planning
9. **Compact mode recovery**: when `Current Phase: analysis` but `analysis-plan.md` already exists, the task is in compact mode and analysis is complete — resume by transitioning directly to `execution-control` (populate `Step Status Map` and `Current Step` if not yet populated)
10. When `Current Phase: learning-acquire`, determine the trigger context: if any Step in `Step Status Map` is `blocked`, this is a mid-step ACQ — after completion, restore `Current Phase: execution-control` and resume that Step; if `reflection-report.md` exists and no Step is `blocked`, this is a post-reflection ACQ — after completion, set `Current Phase: terminal-learning`. Then check `acquire/` directory to determine the sub-stage (search-log exists? raw-sources populated? verification-report exists?) and resume from the incomplete sub-stage
11. When `Current Phase: terminal-learning`, check which terminal Learning step was last completed: if `tl-{task-id}.md` does not exist, resume from step 1; if `tl-{task-id}.md` exists but no `draft-*.md` (and `Candidate Knowledge` is not `none`), resume from step 3; if `draft-*.md` exists but no `review-*.md`, resume from step 4; if `review-*.md` exists but no `kb-*.md` (and review is accepted), resume from step 5; if all promotion is done (or `Candidate Knowledge: none`), resume from step 6 (gap processing and capability updates — these steps always execute). After completing the remaining terminal Learning steps on recovery, re-evaluate `Knowledge Outcome` per `mind/learning/README.md §Knowledge Outcome Determination` — the value may have been left at its initialization default (`not-applicable`) if the original session was interrupted before the determination step
12. If `state.md` is missing or corrupted, treat the task as non-resumable and report the issue

## Self-Check Points

At critical junctures, the runtime must pause and explicitly verify consistency before proceeding. If any check fails, **stop and resolve** — do not skip, defer, or work around a failed self-check.

Each check is defined in the module responsible for the artifact:

1. **Before writing `plan.md`** — see `mind/planning/README.md §Pre-Write Verification`
2. **Before executing a Step with `Learning: acquire-required`** — see `mind/execution-control/README.md §Pre-Step Verification`
3. **Before writing `tl-{task-id}.md`** — see `mind/learning/README.md §ACQ Label Reconciliation`
4. **Final sub-step of terminal Learning step 2 (before freeze)** — see `mind/learning/README.md §Excerpt Fidelity Check`
5. **Before writing `kb-*.md`** — see `mind/learning/README.md §Promotion Gate Check`
6. **Before marking task as `completed`** — see `mind/learning/README.md §Task Completion Check`
