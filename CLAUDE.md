# MindFlow Runtime Constraints

You are running inside MindFlow.

Your job is not to invent a workflow. Your job is to execute the MindFlow workflow correctly.

## Required Behavior

Always operate through this sequence:

1. `Learning(Read)`
2. `Recognition`
3. `Analysis`
4. `Execution`
5. generate `Plan`
6. `Execution Control`
7. execute `Step`s — if a `Step` identifies an external knowledge gap, trigger `Learning(Acquire)` before proceeding
8. `Reflection`
9. if `Reflection` identifies a problem requiring external information, trigger `Learning(Acquire)` before writing `tl-{task-id}.md`
10. terminal `Learning`

Do not skip required stages.

## What You Must Treat As Formal Artifacts

The system recognizes two formal artifact layers:

Task-layer formal artifacts:

- `tasks/{task-id}/learning-read.md`
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/task-profile.md`
- `tasks/{task-id}/analysis.md`
- `tasks/{task-id}/plan.md`
- `tasks/{task-id}/reflection-report.md`
- `tasks/{task-id}/_output/`
- `tasks/{task-id}/cache/`
- `tasks/{task-id}/acquire/search-log.md` (when `Learning(Acquire)` is triggered; contains one ACQ-{NNN} section per event)
- `tasks/{task-id}/acquire/raw-sources/src-{NNN}-{slug}.md` (when `Learning(Acquire)` is triggered; source IDs are unique across all events)
- `tasks/{task-id}/acquire/verification-report.md` (when `Learning(Acquire)` is triggered; contains one ACQ-{NNN} section per event)

Learning-layer formal artifacts:

- `mind/learning/task-learning/tl-{task-id}.md`
- `mind/learning/knowledge-base/drafts/draft-{type}-{task-id}-{slug}.md`
- `mind/learning/reviews/review-{task-id}-{slug}.md`
- `mind/learning/knowledge-base/approved/kb-{type}-{slug}.md`
- `mind/learning/capability-updates/cu-{task-id}-{capability-name}.md`

Do not treat informal notes as substitutes for these files.

## Learning(Acquire) Constraints

`Learning(Acquire)` is mandatory whenever a `Step` or `Reflection` identifies a knowledge gap that requires external information.

A single task may trigger `Learning(Acquire)` multiple times. Each trigger is a separate acquisition event labeled `ACQ-001`, `ACQ-002`, etc. All events share the same `acquire/` directory; `search-log.md` and `verification-report.md` each contain one section per event.

Each event must execute in exactly this order:

1. **Search**: issue queries using search tools; record candidate URLs only in the corresponding `ACQ-{NNN}` section of `tasks/{task-id}/acquire/search-log.md`
2. **Fetch and Preserve**: fetch each candidate URL; save complete original content verbatim to `tasks/{task-id}/acquire/raw-sources/src-{NNN}-{slug}.md`
3. **Verify**: dispatch an independent subagent — the subagent prompt must include the raw-sources path, the ACQ-{NNN} label, and the output target, and must NOT carry context from the fetch session; the subagent re-accesses each URL and produces the corresponding `ACQ-{NNN}` section in `tasks/{task-id}/acquire/verification-report.md`; the agent that ran Stage 2 must not run Stage 3

The following are absolute prohibitions — no exception is permitted:

- **Search summaries must never enter the knowledge pipeline.** They may only be used to identify URLs. Do not quote, cite, or use any search snippet, AI overview, or engine-generated summary as a source.
- **Content must be fetched before it can be recorded.** If a page cannot be fetched, that information does not exist in the pipeline. Do not fall back to its search summary.
- **Fetched content must be saved verbatim.** No summarization, paraphrasing, extraction, or interpretation may occur during the fetch stage.
- **Verification must use an independent subagent.** The agent that fetches must not also verify. Verification in the same context as collection is not valid.
- **Only passed sources may enter `tl-{task-id}.md`.** A source not listed as `passed` in the relevant `Passed Sources for ACQ-{NNN}` section of `verification-report.md` must not be cited anywhere in the learning pipeline.

`Learning(Acquire)` must complete before writing `tl-{task-id}.md` for any externally sourced knowledge item.

Before running `Learning(Acquire)`, read:

- `mind/learning/acquire/README.md`
- the triggering artifact (the `Step` definition or `tasks/{task-id}/reflection-report.md`)

## Learning(Read) Constraints

Before `Recognition`, you must run `Learning(Read)`.

You may read only:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`

You must not read:

- `mind/learning/knowledge-base/drafts/`
- `mind/learning/knowledge-base/archived/`
- `mind/learning/task-learning/`
- `mind/learning/reviews/`
- `mind/learning/capability-updates/`

During `Learning(Read)`, do not write any knowledge-layer file or any task artifact other than the required audit record.

You must produce:

- `tasks/{task-id}/learning-read.md`

That file must record:

- which `Soul` files were read
- which approved knowledge files were read (use `none` if no approved knowledge files exist yet)
- why those reads are relevant to the current task
- which areas were explicitly excluded: `mind/learning/knowledge-base/drafts/`, `mind/learning/knowledge-base/archived/`, `mind/learning/task-learning/`, `mind/learning/reviews/`, `mind/learning/capability-updates/`

## Recognition Constraints

`Recognition` must produce `tasks/{task-id}/task-profile.md`.

Before running `Recognition`, read the files declared in its `Required Reads`.

That must include:

- `tasks/{task-id}/learning-read.md`

Do not generate `Analysis` or `Plan` directly from the raw task without first producing `Task Profile`.

## Analysis Constraints

`Analysis` must produce `tasks/{task-id}/analysis.md`.

Before running `Analysis`, read:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`
- `tasks/{task-id}/learning-read.md`
- `tasks/{task-id}/task-profile.md`

`Analysis` must be concrete enough that `Execution` can generate `Plan` without guessing.

## Execution Constraints

`Execution` must produce `tasks/{task-id}/plan.md`.

`Execution` must also initialize `tasks/{task-id}/state.md`. The initialization order is fixed: write `plan.md` first, then initialize `state.md` based on the completed `plan.md`. `state.md` must not be written before `plan.md` is complete.

Before running `Execution`, read:

- `mind/soul/core.md`
- `tasks/{task-id}/analysis.md`
- the relevant `Capability` definition files referenced by the analysis

`Plan` is the only formal execution file.

Do not execute from:

- scattered notes
- rough drafts
- implied step lists

Execute only from the formal `Plan`.

`Execution` must explicitly decide how `Plan -> Step` execution will be dispatched.

Valid dispatch modes are:

- sequential
- subagent-parallel within one `Step`
- parallel sibling `Step`s or task branches

This choice must be based on declared dependencies, artifact isolation, coordination cost, and merge risk.

Prefer the highest safe parallelism level.

Do not use parallelism when hidden shared state, conflicting writes, or expensive synchronization would make execution less reliable.

The dispatch schema must be the same across `analysis.md`, `plan.md`, execution, and `reflection-report.md`.

Use these canonical fields:

- `Dispatch Mode`
- `Parallel Group`
- `Synchronization Point`
- `Merge Owner`
- `Output Isolation`

## Execution Control Constraints

After `Execution` has produced `plan.md`, you must run `Execution Control`.

Before running it, read:

- `mind/soul/core.md`
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/plan.md`
- the `Capability` definition files referenced by the `Plan`

`Execution Control` is responsible for:

- updating `tasks/{task-id}/state.md` as the canonical runtime state file
- advancing `Step`s in the declared order
- enforcing dispatch mode at runtime
- validating prerequisites before each `Step`
- enforcing synchronization and merge ownership
- deciding whether a failed `Step` should retry, rework, stop the chain, or escalate to `Reflection`

Do not improvise a second runtime controller outside `Execution Control`.

## Step Constraints

Before executing a `Step`, you must read:

- the files listed in that `Step`'s `Constraints`
- the files listed in that `Step`'s `Inputs`

Each `Step` must:

- call exactly one main `Capability`
- write declared outputs
- declare whether it publishes to `sources/` or `none`
- declare step-level `Learning` as exactly one of:
  - `acquire-required`: if a knowledge gap requiring external information is encountered during this Step, `Learning(Acquire)` must be triggered immediately; the Step is paused (`state.md` Step Status → `blocked`) until `Learning(Acquire)` completes all three stages; after completion the Step resumes by re-reading its `Constraints` and `Inputs`; if `Learning(Acquire)` is exhausted, apply the Step's `Failure Policy`; when the Step completes, record in `state.md` whether a gap was encountered, and if `Learning(Acquire)` was not triggered, the explicit reason why no gap was identified
  - `terminal-only`: learning is captured at terminal Learning from task-internal artifacts only
  - `optional`: learning may occur but is not mandatory
  - `not-needed`: this Step produces no learnable knowledge
- declare its dispatch mode and dependency shape
- declare `Completion Criteria`
- declare `Failure Policy`; when `Failure Policy: escalate-to-reflection` is triggered: stop the Step, preserve all partial outputs in `cache/` and `_output/`, update `state.md` to `Overall Status: blocked` and `Ready For Reflection: yes`, then hand control to `Reflection`; the failed task does not automatically retry the failed Step — any re-execution must be a new task

If more than one main action is needed, split the work into multiple `Step`s.

If a `Step` is executed through subagents, the parent `Step` remains the formal `Plan` unit and must additionally declare:

- why subagent execution is safe
- how work is partitioned
- where each subagent writes results
- how results are merged and validated

If multiple `Step`s run in parallel, they must not share undeclared mutable outputs and must declare the synchronization point that rejoins the branches.

One `Step` must explicitly own merge for each non-trivial parallel branch set.

## Output Constraints

The default formal result location is:

- `tasks/{task-id}/_output/`

Intermediate handoff files go to:

- `tasks/{task-id}/cache/`

At least one final-output `Step` must write into `_output/`.

Do not use `sources/` as the default task result directory.

Write to `sources/` only when the relevant `Step` explicitly declares publish-back behavior.

## Reflection Constraints

After step execution, you must produce:

- `tasks/{task-id}/reflection-report.md`

Before writing it, read:

- `mind/soul/core.md`
- `tasks/{task-id}/state.md` (for actual Step execution results, Parallel Branch Status, and failure records — needed to assess whether dispatch and merge behaved as declared)
- `tasks/{task-id}/plan.md` (for the declared dispatch schema to compare against actual execution)
- `tasks/{task-id}/cache/` (read all files present; if the directory is empty or does not exist, record that fact and continue)
- `tasks/{task-id}/_output/` (read all files present; if the directory is empty due to task failure, note the absence and reflect on why)
- declared `sources/` publish-back paths if present

Do not write vague reflection.

`Reflection Report` must identify:

- result evaluation
- process review
- issue detection
- learning candidates
- capability impact
- inference triggers

## Terminal Learning Constraints

After `Reflection`, you must run terminal `Learning`.

Before it, read:

- `mind/soul/core.md`
- `tasks/{task-id}/state.md` (to verify that ACQ-{NNN} labels in `Learning(Acquire) Log` are correct before writing `tl-{task-id}.md`)
- `tasks/{task-id}/reflection-report.md`
- if `Learning(Acquire)` was triggered during this task: `tasks/{task-id}/acquire/verification-report.md` (read all ACQ-{NNN} sections to identify all passed sources before writing `tl-{task-id}.md`)

Then follow this order exactly:

1. write `mind/learning/task-learning/tl-{task-id}.md`; always write this file — if there are no learning candidates, write `Candidate Knowledge: none` and `Next Promotion Target: none`
2. if `Candidate Knowledge` is `none`, skip steps 3 and 4 and go directly to step 5; otherwise write one or more `draft-{type}-{task-id}-{slug}.md`
3. dispatch an independent subagent to write each `review-{task-id}-{slug}.md`
   - subagent prompt must include: the `draft-*.md` path, the `Source Anchor` path, the output target, and an explicit instruction that the subagent must not carry any context from the drafting session
   - the agent that wrote a `draft-*.md` must not write its corresponding `review-*.md`
   - if the review is written in the same context as the draft, `Verification Mode` must be recorded as `same-context` and `Decision` must be `rejected`
4. only accepted reviews may produce `kb-{type}-{slug}.md`
5. if needed, write `cu-{task-id}-{capability-name}.md`

Do not bypass this promotion path.

Do not write directly into `approved/` without review.

If you write `cu-{task-id}-{capability-name}.md`, it must include:

- `Target Capability File`
- `Planned Changes`
- `Applied Changes`
- `Validation`

`Status: applied` is allowed only when:

- the target capability file has actually been updated
- `Applied Changes` is not `none`
- `Validation` is not `none`

## Inference Constraints

`Inference` is optional and conditional.

Use it only when:

- analysis is blocked by missing structure
- reflection identifies a reusable pattern
- learning requires abstraction
- the user explicitly asks for it

Treat inference output as provisional unless later formalized through the learning path.

## Skill Constraints

`Capability` may load `Skill`.

But:

- `Capability` is the formal runtime unit
- `Skill` is only a loadable execution resource
- do not replace the MindFlow protocol with a skill-specific workflow

## Commit Hook Requirement

Before making any commit, you must ensure the commit hooks are installed.

Run the following if `node_modules` or `.git/hooks/commit-msg` is missing:

```sh
npm install
```

Do not commit without the hooks active. A missing hook is treated as an incomplete environment — resolve it before proceeding.

## Task ID Naming Rule

Every task must use a `task-id` with the fixed format: `YYYYMMDD-short-name` (e.g. `20260324-refactor-learning`).

This format is required because `task-id` is used as a component in the names of all formal artifacts across both the task layer and the learning layer:
- `tasks/{task-id}/`
- `tl-{task-id}.md`
- `draft-{type}-{task-id}-{slug}.md`
- `review-{task-id}-{slug}.md`
- `cu-{task-id}-{capability-name}.md`

A malformed `task-id` breaks cross-artifact traceability. Do not use arbitrary strings.

## General Discipline

- prefer explicit file paths over vague references
- prefer formal artifacts over conversational summaries
- prefer deterministic output locations over ad hoc placement
- if a required file is missing, treat the chain as incomplete
- if a file does not match its required template, do not assume it is valid

MindFlow prioritizes stable execution over improvisation.
