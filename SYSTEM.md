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

When `Recognition` determines that a task has `Complexity: low` and `Risk: low`, the task may use compact mode. Compact mode does not skip any phase — it compresses their artifacts:

- `Analysis` and `Planning` may be written as a single combined file `tasks/{task-id}/analysis-plan.md` using `mind/analysis/COMPACT-TEMPLATE.md`; the file must still contain the required sections from both `analysis/TEMPLATE.md` and `planning/TEMPLATE.md`, but sections with no meaningful content may be written as a single line (e.g., `## Risks\n- none`)
- The `Plan` may contain a single `Step`
- `Reflection` may be abbreviated: `Result Evaluation`, `Process Review`, and `Issue Detection` are still required; other sections may be written as `none` if genuinely empty
- All other rules (file handoff, Learning pipeline, state tracking) remain in full effect
- Compact mode must be declared in `task-profile.md` as `## Mode\n- compact` so that subsequent phases know the format

Compact mode must not be used when:
- `Complexity` is `medium` or `high`
- `Risk` is `medium` or `high`
- the task requires `Learning(Acquire)`
- the task has more than one `Step`

### Compact Mode Exit

Compact mode is declared by `Recognition` before `Analysis` runs. If `Analysis` discovers that compact mode is no longer appropriate (e.g., the task requires multiple Steps or `Learning(Acquire)`), the runtime must:

1. Remove the `## Mode\n- compact` declaration from `task-profile.md`
2. Produce separate `analysis.md` and `plan.md` instead of `analysis-plan.md`
3. Record the exit reason in `analysis.md §Notes`

This is the only point where compact mode may be exited; once `analysis-plan.md` is written, compact mode is committed.

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
4. `Planning` sets `Current Phase: planning`; after `plan.md` is written and passes its validation rules, sets `Current Phase: execution-control`, populates `Step Status Map`, sets `Current Step` to Step 1. **In compact mode**: `analysis-plan.md` combines both Analysis and Planning artifacts; once written and validated, the runtime transitions directly from step 3 to `Current Phase: execution-control`, skipping the separate `planning` phase marker — step 3 and step 4 are satisfied by a single file. The runtime must still perform the same `state.md` updates as normal mode: populate `Step Status Map` from `analysis-plan.md` and set `Current Step` to Step 1
5. `Execution Control` maintains `Current Step` and `Step Status Map` throughout
6. Transition to `Reflection` occurs in three scenarios, each with a different `Overall Status`:
   - **all Steps completed normally**: set `Overall Status: completed`, `Ready For Reflection: yes`, `Current Phase: reflection`
   - **`stop` triggered**: set `Overall Status: failed`, mark Step as `failed`, set `Ready For Reflection: yes`, `Current Phase: reflection`
   - **`escalate-to-reflection` triggered**: set `Overall Status: blocked`, mark Step as `failed`, set `Ready For Reflection: yes`, `Current Phase: reflection`
7. `Reflection` runs; upon completion, check whether either `Requires External Acquisition` sub-heading in `reflection-report.md` is `yes` — if so, proceed to step 8 before terminal `Learning`; otherwise skip to step 9
8. When `Learning(Acquire)` is triggered:
   - **mid-step**: set `Current Phase: learning-acquire`, mark Step as `blocked`; upon completion, restore `Current Phase: execution-control`, mark Step as `running`
   - **post-reflection**: set `Current Phase: learning-acquire`; upon completion, set `Current Phase: terminal-learning`
9. Terminal `Learning` runs; upon completion, determine the final state from `Overall Status` at entry: if `running` → set `Current Phase: completed`, `Overall Status: completed`; if `cancelled` → set `Current Phase: cancelled`, `Overall Status: cancelled`; if `failed` → set `Current Phase: completed`, `Overall Status: failed`

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

If the runtime environment does not support independent subagent dispatch, degraded verification modes apply. See `mind/learning/acquire/README.md §Subagent Unavailability` and `mind/learning/README.md §Subagent Unavailability`. The degradation must be recorded in `reflection-report.md §Issue Detection` so that a future task with subagent support can re-attempt the review.

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

At these critical junctures, the runtime must pause and explicitly verify consistency before proceeding. If any check fails, the runtime must **stop and resolve** the inconsistency before continuing — do not skip, defer, or work around a failed self-check.

1. **Before writing `plan.md`**: verify that `analysis.md §Step-level Learning Need` values are carried forward consistently into each Step's `Learning` field. On failure: fix the inconsistency in `plan.md` before writing it.
2. **Before executing a Step with `Learning: acquire-required`**: verify that `state.md §Learning(Acquire) Log` has a placeholder entry for this Step. On failure: add the missing entry to `state.md` before proceeding.
3. **Before writing `tl-{task-id}.md`**: read `state.md §Learning(Acquire) Log` and verify all ACQ labels are consistent with `acquire/search-log.md` and `acquire/verification-report.md`. On failure: pause and resolve the label mismatch before writing.
4. **Before writing `draft-*.md`**: verify that each `Original Excerpt` in `tl-{task-id}.md` is a verbatim substring of the referenced source file content (read the source file, do not rely on memory). On failure: correct the excerpt in `tl-{task-id}.md` (only if still in step 2 of terminal Learning; if already frozen, the candidate must not be promoted).
5. **Before writing `kb-*.md`**: verify the corresponding `review-*.md` has `Decision: accepted`, `Verification Mode: independent-subagent`, `Summary Verified: yes`, and `Source Anchor Verified: yes`. On failure: do not write the `kb-*.md`; the candidate remains in `drafts/`.
6. **Before marking task as `completed`**: verify `_output/` is not empty and all Steps in `Step Status Map` are `completed` (or `failed` with escalation handled). On failure: do not mark the task as completed; investigate the missing output or unfinished Step.
