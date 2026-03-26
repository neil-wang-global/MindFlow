# MindFlow System Protocol

This file defines the system protocol for AI running inside MindFlow.

It is the authoritative flow definition and cross-module rule set. Module-internal rules live in each module's own `README.md` and are loaded when the runtime enters that module.

## Required Main Flow

Every task must follow this exact flow:

`Task -> Learning(Read) -> Recognition -> Analysis -> Planning -> Plan -> Execution Control -> Reflection -> Learning`

No task may skip:

- `Learning(Read)`
- `Recognition`
- `Analysis`
- `Planning`
- `Execution Control`
- `Reflection`
- terminal `Learning`

## Compact Mode

When `Recognition` determines that a task has `Complexity: low` and `Risk: low`, the task may use compact mode. Compact mode does not skip any phase — it compresses their artifacts:

- `Analysis` and `Planning` may be written as a single combined file `tasks/{task-id}/analysis-plan.md`; the file must still contain the required sections from both `analysis/TEMPLATE.md` and `planning/TEMPLATE.md`, but sections with no meaningful content may be written as a single line (e.g., `## Risks\n- none`)
- The `Plan` may contain a single `Step`
- `Reflection` may be abbreviated: `Result Evaluation`, `Process Review`, and `Issue Detection` are still required; other sections may be written as `none` if genuinely empty
- All other rules (file handoff, Learning pipeline, state tracking) remain in full effect
- Compact mode must be declared in `task-profile.md` as `## Mode\n- compact` so that subsequent phases know the format

Compact mode must not be used when:
- `Complexity` is `medium` or `high`
- `Risk` is `medium` or `high`
- the task requires `Learning(Acquire)`
- the task has more than one `Step`

## Constraint Loading Rule

Before entering any module or any `Step`, the AI must read the `README.md` (and `TEMPLATE.md` when producing an artifact) of that module's directory. This is the only constraint loading required — do not recursively chase references from within those files. `SYSTEM.md` is assumed loaded at task start.

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

1. `Learning(Read)` creates `state.md` with `Current Phase: learning-read`
2. `Recognition` sets `Current Phase: recognition`
3. `Analysis` sets `Current Phase: analysis`
4. `Planning` sets `Current Phase: planning`; after `plan.md` is written, sets `Current Phase: execution-control`, populates `Step Status Map`, sets `Current Step` to Step 1
5. `Execution Control` maintains `Current Step` and `Step Status Map` throughout
6. When all Steps complete (or `escalate-to-reflection` / `stop` triggers): set `Current Phase: reflection`, `Ready For Reflection: yes`
7. `Reflection` runs; upon completion set `Current Phase: terminal-learning`
8. When `Learning(Acquire)` is triggered (mid-step or post-reflection): set `Current Phase: learning-acquire`; upon completion restore previous phase
9. Terminal `Learning` runs; upon completion set `Current Phase: completed`, `Overall Status: completed`

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

Both `Learning(Acquire)` Stage 3 (verification) and terminal `Learning` step 3 (review) must be executed by an independent subagent that does not share execution context with the agent that produced the artifact being reviewed. This is a system-level integrity rule, not a module-level preference.

#### Subagent Unavailability Degradation

If the runtime environment does not support independent subagent dispatch:

- `Learning(Acquire)` Stage 3: the verification report must be written with `Verification Mode: same-context` annotation; all sources are treated as `downgraded` and the event is marked `exhausted` with reason `independent verification unavailable`
- terminal `Learning` step 3: the review must be written with `Verification Mode: same-context`; per `reviews/TEMPLATE.md`, this forces `Decision: rejected` — the knowledge does not enter `approved/`
- the degradation must be recorded in `reflection-report.md §Issue Detection` so that a future task with subagent support can re-attempt the review

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

The five canonical dispatch fields (`Dispatch Mode`, `Parallel Group`, `Synchronization Point`, `Merge Owner`, `Output Isolation`) must remain structurally consistent across:

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

These are cross-cutting policies referenced by any `Step`.

### retry

1. Increment `Retry Count` in `state.md`
2. Re-read the `Step`'s `Constraints` and `Inputs` before retrying
3. Re-execute the `Step` from scratch
4. Maximum retries: 2. After 2 failures, escalate to `escalate-to-reflection` automatically
5. Each retry recorded in `state.md` under `Last Failure`

### rework

1. Preserve partial outputs
2. Re-read preceding `Step`'s outputs and current `Step`'s `Constraints`
3. Re-execute with adjusted approach
4. Maximum rework attempts: 1. After failure, escalate to `escalate-to-reflection` automatically
5. Record in `state.md` under `Last Failure`

### stop

1. Stop immediately. No retry or rework
2. Set `Overall Status: failed`, mark Step as `failed`, set `Ready For Reflection: yes`
3. Do not advance to next Step
4. Hand control to `Reflection` so that the failure is formally analyzed
5. After `Reflection`, terminal `Learning` runs as normal
6. The task is then considered terminated. A new task must be created to retry the work

### escalate-to-reflection

1. Stop immediately. Preserve all partial outputs
2. Set `Overall Status: blocked`, mark Step as `failed`, set `Ready For Reflection: yes`
3. Do not advance to next Step
4. Hand control to `Reflection`
5. After `Reflection`, terminal `Learning` runs as normal

## Cancellation Protocol

When a task is cancelled by the user before completion:

1. Set `Overall Status: cancelled`, record reason
2. Preserve all files already produced
3. Run a lightweight `Reflection`: set `Current Phase: reflection`, produce `reflection-report.md` covering only `Result Evaluation` (what was completed so far), `Process Review` (where the task was when cancelled), and `Issue Detection` (any issues worth noting). `Learning Candidates`, `Capability Impact`, and `Inference Triggers` may be written as `none — task cancelled`
4. After lightweight `Reflection`, run terminal `Learning` as normal — if there are no learning candidates, `tl-{task-id}.md` is still written with `Candidate Knowledge: none`
5. After terminal `Learning` completes, set `Current Phase: cancelled`, `Overall Status: cancelled`
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

During bootstrap (before any `cap-{name}.md` files exist in `capabilities/`):

- capability labels in `Step` declarations serve as classification identifiers only
- constraint loading from `capabilities/` is skipped for Steps whose label has no corresponding file
- `Capability Update` records (`cu-*.md`) may still be created with `Status: proposed`; they will be applied once the target `cap-{name}.md` is created
- the capability evolution mechanism fully activates once the first `cap-{name}.md` file is created via a `Capability Update` with `Status: applied`

Similarly, when `mind/soul/core.md` has all fields set to "To be defined", `Soul` constraints are not enforced. `Learning(Read)` must record this state explicitly.

## Self-Check Points

At these critical junctures, the runtime must pause and explicitly verify consistency before proceeding:

1. **Before writing `plan.md`**: verify that `analysis.md §Step-level Learning Need` values are carried forward consistently into each Step's `Learning` field
2. **Before executing a Step with `Learning: acquire-required`**: verify that `state.md §Learning(Acquire) Log` has a placeholder entry for this Step
3. **Before writing `tl-{task-id}.md`**: read `state.md §Learning(Acquire) Log` and verify all ACQ labels are consistent with `acquire/search-log.md` and `acquire/verification-report.md`
4. **Before writing `kb-*.md`**: verify the corresponding `review-*.md` has `Decision: accepted`, `Verification Mode: independent-subagent`, `Summary Verified: yes`, and `Source Anchor Verified: yes`
5. **Before marking task as `completed`**: verify `_output/` is not empty and all Steps in `Step Status Map` are `completed` (or `failed` with escalation handled)
