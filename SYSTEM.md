# MindFlow System Protocol

This file defines the system protocol for AI running inside MindFlow.

It is the authoritative flow definition and cross-module rule set. Module-internal rules live in each module's own `README.md` and are loaded when the runtime enters that module.

## Core Design Principle: Lazy Loading

This system is designed around **on-demand context loading**: a module's rules are loaded only when the runtime reaches that module, not before.

- `SYSTEM.md` (this file) is the only file loaded at task start. It defines the flow skeleton and cross-module rules.
- Each module's `README.md` is the self-contained authority for that module. It is loaded when the runtime **enters** that module — not at task start, not in advance.
- `TEMPLATE.md` files are loaded when **producing** an artifact of that type — not when entering the module.
- Directory index READMEs (`mind/README.md`, `tasks/README.md`, `sources/README.md`, `capabilities/README.md`) are navigation aids for human readers — the runtime does not load them.
- Do not pre-load, pre-scan, or pre-summarize module contents. If you have not entered a module, you do not need its rules.

This principle minimizes context noise and ensures that each module's rules are read fresh when they are actually needed.

## Task Initialization

1. Read `SYSTEM.md` (this file)
2. Determine `task-id` (format: `YYYYMMDD-short-name`, see `CONTRIBUTING.md`)
3. Create `tasks/{task-id}/` with subdirectories `_output/` and `cache/`
4. Enter `Learning(Read)` — read `mind/learning/learning-read/README.md`, create `state.md` and `learning-read.md`
5. Follow the Required Main Flow below, loading each module's `README.md` on entry

## Required Main Flow

Every task must follow this exact flow:

`Task -> Learning(Read) -> Recognition -> Analysis -> Planning -> Plan -> Execution Control -> Reflection -> Learning`

### Task Type Variants

The main flow is the same for all task types (`delivery / learning / mixed`). The differences are in content expectations, not in flow structure:

- **delivery**: `_output/` must contain a concrete deliverable. `Learning Candidates` in `reflection-report.md` are expected but not mandatory.
- **learning**: `_output/` must contain a knowledge artifact (research summary, analysis document, etc.). `Learning(Acquire)` is expected. `reflection-report.md §Learning Candidates` must not be empty unless all acquisition events were exhausted.
- **mixed**: both a deliverable and learning output are expected. Evaluation criteria from both `delivery` and `learning` apply.

## Compact Mode

When `Recognition` determines `Complexity: low` and `Risk: low`, the task may use compact mode. Compact mode compresses artifacts — it does not skip phases. Must be declared in `task-profile.md` as `## Mode\n- compact`.

- `Analysis` and `Planning` merge into `tasks/{task-id}/analysis-plan.md` (see `mind/analysis/COMPACT-TEMPLATE.md`)
- Single `Step` only; `Reflection` may abbreviate optional sections
- All other rules (file handoff, Learning pipeline, state tracking) remain in full effect

Compact mode must not be used when: `Complexity` or `Risk` is `medium`/`high`, `Learning(Acquire)` is required, or more than one `Step` is needed.

**Exit**: if `Analysis` discovers compact mode is no longer appropriate, it must remove the compact declaration from `task-profile.md`, produce separate `analysis.md` and `plan.md`, and record the exit reason in `analysis.md §Notes`. This is the only exit point; once `analysis-plan.md` is written, compact mode is committed.

## Constraint Loading Rule

This rule operationalizes the Core Design Principle for module entry:

Before entering any module or any `Step`, the AI must read that module's `README.md` (and `TEMPLATE.md` when producing an artifact). The `Required Reads` declared in that `README.md` are mandatory inputs for that phase and must also be read. Do not recursively chase secondary references from within those input files — only the module's own `README.md` defines what must be read. `SYSTEM.md` is assumed loaded at task start.

## Runtime Roles

### `Mind`

`Mind` is the runtime base of the whole system.

It is responsible for:

- driving the task through all required stages
- producing required formal artifacts
- enforcing file-based handoff
- triggering task-end learning

### `Soul`

`Soul` is the highest constraint layer inside `Mind`.

- `Soul` is read as a constraint source via `mind/soul/core.md`
- `Soul` constrains `Learning(Read)`, `Recognition`, `Analysis`, `Reflection`, `Learning`, and `Inference`
- See `mind/soul/README.md` for full definition

### `Capability`

`Capability` is an action unit called by a `Step`.

Each `Step` declares exactly one `Capability` label. When a corresponding definition file exists in `capabilities/`, it must be read as part of constraint loading. See `capabilities/README.md`.

A `Capability` reads files, performs one core action, writes files. It does not own orchestration and does not bypass system learning rules.

### `Plan`

`Plan` is the only formal output of `Planning`.

- runtime executes according to `tasks/{task-id}/plan.md`
- scattered step notes are not authoritative
- runtime state is tracked in `tasks/{task-id}/state.md`

### `Step`

`Step` is the smallest execution unit inside `Plan`.

Every `Step` must declare its fields as defined in `mind/planning/TEMPLATE.md`. When `Dispatch Mode` is `sequential`, the parallel-related fields (`Parallel Group`, `Synchronization Point`, `Merge Owner`) may be omitted and default to `none`.

### `Execution Control`

`Execution Control` is the runtime control role that executes the formal `Plan`.

See `mind/execution-control/README.md` for full rules. Key invariants enforced at system level:

- it must not rewrite `plan.md` during execution
- it must not replace formal file handoff with implicit conversational memory

### `Learning`

`Learning` participates in three modes:

- `Learning(Read)`: reads formal knowledge before `Recognition` — see `mind/learning/learning-read/README.md`
- `Learning(Acquire)`: acquires and grounds external knowledge when a knowledge gap is identified — see `mind/learning/acquire/README.md`
- terminal `Learning`: absorbs candidate knowledge after `Reflection` — see `mind/learning/README.md`

### `Reflection`

`Reflection` reviews the completed task and produces the `Reflection Report`.

See `mind/reflection/README.md` for full rules.

### `Inference`

`Inference` is a conditional module, not always-on.

See `mind/inference/README.md` for full rules.

## Phase Transition Protocol

Every phase transition must update `tasks/{task-id}/state.md`. The complete transition sequence is:

1. `Learning(Read)` creates `state.md` with `Current Phase: learning-read`; before transitioning, verify `learning-read.md` exists and passes its validation rules
2. `Recognition` sets `Current Phase: recognition`; before transitioning, verify `task-profile.md` exists and passes its validation rules (see `mind/recognition/TEMPLATE.md §Validation Rules`)
3. `Analysis` sets `Current Phase: analysis`; before transitioning, verify `analysis.md` (or `analysis-plan.md` in compact mode) exists and passes its validation rules (see `mind/analysis/TEMPLATE.md §Validation Rules`)
4. `Planning` sets `Current Phase: planning`; after `plan.md` is written and passes its validation rules, sets `Current Phase: execution-control`, populates `Step Status Map`, sets `Current Step` to Step 1. **In compact mode**: `analysis-plan.md` satisfies both steps 3 and 4; the runtime transitions directly from `analysis` to `execution-control` (the `planning` phase marker is skipped); `state.md` updates (Step Status Map, Current Step) still apply
5. `Execution Control` maintains `Current Step` and `Step Status Map` throughout
6. Transition to `Reflection` occurs in three scenarios, each with a different `Overall Status`:
   - **all Steps completed normally**: set `Overall Status: completed`, `Ready For Reflection: yes`, `Current Phase: reflection`
   - **`stop` triggered**: set `Overall Status: failed`, mark Step as `failed`, set `Ready For Reflection: yes`, `Current Phase: reflection`
   - **`escalate-to-reflection` triggered**: set `Overall Status: blocked`, mark Step as `failed`, set `Ready For Reflection: yes`, `Current Phase: reflection`
7. `Reflection` runs; upon completion, check whether either `Requires External Acquisition` sub-heading in `reflection-report.md` is `yes` — if so, proceed to step 8 before terminal `Learning`; otherwise skip to step 9
8. When `Learning(Acquire)` is triggered:
   - **mid-step**: set `Current Phase: learning-acquire`, mark Step as `blocked`; upon completion, restore `Current Phase: execution-control`, mark Step as `running`
   - **post-reflection**: set `Current Phase: learning-acquire`; upon completion, set `Current Phase: terminal-learning`
9. Terminal `Learning` runs; upon completion, set final state based on `Overall Status` at entry: `running` → `completed/completed`; `cancelled` → `cancelled/cancelled`; `failed` → `completed/failed` (format: `Current Phase / Overall Status`)

### Inference State Rule

When `Inference` is triggered mid-phase (during `Analysis`, `Reflection`, or terminal `Learning`), `Current Phase` remains unchanged — `Inference` is a sub-operation within the triggering phase, not a separate phase. The inference output file path must be recorded in the triggering artifact's `Inference References` section.

Each module is responsible for setting its own phase upon entry. Failure to update `state.md` makes the task non-recoverable.

## Cross-Module Rules

The following rules span multiple modules and are therefore defined here rather than in any single module's README.

### Knowledge Source Prohibition

A search summary, snippet, or AI-generated overview is never a valid knowledge source. This applies across all modules: `Learning(Acquire)`, terminal `Learning`, `Recognition`, `Analysis`, and `Reflection`.

### Fixed Promotion Path

Knowledge must follow this path without shortcuts:

`task-learning/` → `drafts/` → `reviews/` → `knowledge-base/approved/`

Only approved knowledge may be reused by future `Learning(Read)`.

### Independent Subagent Review

Both `Learning(Acquire)` Stage 3 (verification) and terminal `Learning` step 4 (review) must be executed by an independent subagent that does not share execution context with the agent that produced the artifact being reviewed. This is a system-level integrity rule, not a module-level preference.

#### Subagent Unavailability Degradation

If the runtime environment does not support independent subagent dispatch, degraded verification modes apply. See `mind/learning/acquire/README.md §Subagent Unavailability` and `mind/learning/README.md §Subagent Unavailability`. The degradation must be recorded in `reflection-report.md §Issue Detection` so that a future task with subagent support can re-attempt the review. If subagent unavailability persists across multiple tasks, human review escalation is available — see `mind/learning/reviews/TEMPLATE.md §Human Review Escalation`.

### Capability Update Advancement

- `Learning(Read)` scans `mind/learning/capability-updates/` for files with `Status: proposed` or `Status: approved`
- If 3 or more pending capability updates are found, the current task's `Plan` must include a dedicated `Step` to review and advance them
- A capability update remaining `proposed` for more than two subsequent tasks must be flagged in `reflection-report.md §Issue Detection`
- Reflection-triggered capability updates must be created with `Status: proposed` and must not be advanced to `approved` or `applied` within the same task

### Deferred Review Advancement

- `Learning(Read)` scans `mind/learning/reviews/` for files with `Decision: deferred`
- If 2 or more deferred reviews are found, the current task's `Plan` must include a dedicated `Step` to re-evaluate them
- A deferred review remaining unresolved for more than two subsequent tasks must be flagged in `reflection-report.md §Issue Detection` and must be either re-opened or explicitly converted to `rejected`
- Re-evaluation produces a new `review-{new-task-id}-{slug}.md` that references and supersedes the deferred review

### Knowledge Gap Retry Advancement

- `Learning(Read)` scans `mind/learning/knowledge-gaps/` for files with `Status: open`
- If an open knowledge gap is relevant to the current task's goal (as determined by `Analysis`), the `Plan` should include a `Step` with `Learning: acquire-required` targeting that gap; the `Step` instructions must reference the gap file and note the previous exhaustion reason so a different search strategy can be used
- If the gap is not relevant to the current task, no action is required — the gap remains `open` for a future relevant task
- A knowledge gap remaining `open` for more than three subsequent tasks (regardless of relevance) must be flagged in `reflection-report.md §Issue Detection`
- When a future task successfully acquires the knowledge, terminal `Learning` must update the gap file to `Status: resolved` and fill the `Resolution` field

### Dispatch Field Consistency

The five canonical dispatch fields and their value domains:

- `Dispatch Mode`: `sequential / subagent / parallel-branch`
- `Parallel Group`: group label or `none` (default when sequential)
- `Synchronization Point`: Step reference or `none` (default when sequential)
- `Merge Owner`: Step reference or `none` (default when sequential)
- `Output Isolation`: description of output boundaries

These fields must remain structurally consistent across:

- `tasks/{task-id}/analysis.md`
- `tasks/{task-id}/plan.md`
- `tasks/{task-id}/reflection-report.md`

### Plan Output Rules

- Default formal result directory: `tasks/{task-id}/_output/`
- Intermediate handoff files go to: `tasks/{task-id}/cache/`
- At least one final-output `Step` must write to `_output/`
- Writing to `sources/` is optional and only allowed when explicitly declared in the relevant `Step`

### ACQ Label Consistency Rule

All `ACQ-{NNN}` labels must be consistent across `tasks/{task-id}/state.md §Learning(Acquire) Log`, `tasks/{task-id}/acquire/search-log.md`, `tasks/{task-id}/acquire/verification-report.md`, and `mind/learning/task-learning/tl-{task-id}.md`. If a mismatch is detected, the runtime must pause and resolve before proceeding.

## Failure Policies

Every `Step` must declare one of these policies: `retry`, `rework`, `stop`, `escalate-to-reflection`.

- `stop` and `escalate-to-reflection` trigger cross-module transitions: they hand control to `Reflection` (see §Phase Transition Protocol step 6). After `Reflection`, terminal `Learning` runs as normal.
- `stop` sets `Overall Status: failed`; the task is considered terminated and a new task must be created to retry the work.
- `escalate-to-reflection` sets `Overall Status: blocked`.

Full protocol details (retry limits, rework rules, state updates) are defined in `mind/execution-control/README.md §Failure Policy Protocols` and loaded when `Execution Control` is entered.

## Cancellation Protocol

When a task is cancelled by the user before completion:

1. Set `Overall Status: cancelled`, record reason
2. Preserve all files already produced
3. Run a lightweight `Reflection`: set `Current Phase: reflection`, produce `reflection-report.md` covering only `Result Evaluation` (what was completed so far), `Process Review` (where the task was when cancelled), and `Issue Detection` (any issues worth noting). `Learning Candidates`, `Capability Impact`, and `Inference Triggers` may be written as `none — task cancelled`
4. After lightweight `Reflection`, run terminal `Learning` as normal — if there are no learning candidates, `tl-{task-id}.md` is still written with `Candidate Knowledge: none`
5. After terminal `Learning` completes, `Current Phase` and `Overall Status` are set automatically per §Phase Transition Protocol step 9 (entry status is `cancelled`)
6. A cancelled task is a terminal state

## Recovery Protocol

When a session resumes after interruption:

1. Scan `tasks/` for directories containing `state.md` where `Overall Status` is not `completed` and not `cancelled`
2. Read the `state.md` of the unfinished task to determine `Current Phase` and `Current Step`
3. Resume execution from the recorded phase and step — do not restart from the beginning
4. Before resuming, read the `README.md` of the module corresponding to `Current Phase`
5. When `Current Phase: learning-acquire`, check `acquire/` directory to determine the sub-stage (search-log exists? raw-sources populated? verification-report exists?) and resume from the incomplete sub-stage
6. If `state.md` is missing or corrupted, treat the task as non-resumable and report the issue

## Task Directory Minimum

Every task directory must contain:

- `learning-read.md`
- `state.md`
- `task-profile.md`
- `analysis.md` and `plan.md` (or `analysis-plan.md` in compact mode)
- `reflection-report.md`
- `_output/`
- `cache/`

## Source Directory Rule

`sources/` is for project materials and optional publish-back outputs. See `sources/README.md`.

## Skill Rule

`Skill` is not a top-level runtime object.

A `Capability` may load a `Skill`, but:

- `Capability` is not `Skill`
- `Skill` is only an execution resource that provides tool-level functionality
- `Skill` selection is made at runtime by the executing agent; it is not declared in `Plan`

## Bootstrap Phase

During bootstrap, some subsystems may not yet be fully configured:

- **Capabilities**: see `capabilities/README.md §Bootstrap` for rules when no `cap-{name}.md` files exist yet
- **Soul**: see `mind/soul/README.md §Bootstrap` for rules when `core.md` fields are all "To be defined"

## Self-Check Points

At critical junctures, the runtime must pause and explicitly verify consistency before proceeding. If any check fails, **stop and resolve** — do not skip, defer, or work around a failed self-check.

Each check is defined in the module responsible for the artifact. The index below shows where to find each check:

1. **Before writing `plan.md`** — see `mind/planning/README.md §Pre-Write Verification`
2. **Before executing a Step with `Learning: acquire-required`** — see `mind/execution-control/README.md §Pre-Step Verification`
3. **Before writing `tl-{task-id}.md`** — see `mind/learning/README.md §ACQ Label Reconciliation`
4. **Before writing `draft-*.md`** — see `mind/learning/README.md §Excerpt Fidelity Check`
5. **Before writing `kb-*.md`** — see `mind/learning/README.md §Promotion Gate Check`
6. **Before marking task as `completed`** — see `mind/learning/README.md §Task Completion Check`
