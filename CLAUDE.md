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
7. execute `Step`s
8. `Reflection`
9. terminal `Learning`

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

Learning-layer formal artifacts:

- `mind/learning/task-learning/tl-{task-id}.md`
- `mind/learning/knowledge-base/drafts/draft-{type}-{task-id}-{slug}.md`
- `mind/learning/reviews/review-{task-id}-{slug}.md`
- `mind/learning/knowledge-base/approved/kb-{type}-{slug}.md`
- `mind/learning/capability-updates/cu-{task-id}-{capability-name}.md`

Do not treat informal notes as substitutes for these files.

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
- which approved knowledge files were read
- why those reads are relevant to the current task

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

`Execution` must also initialize `tasks/{task-id}/state.md`.

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
- declare whether step-level `Learning` is `required`, `optional`, or `not-needed`
- declare its dispatch mode and dependency shape
- declare `Completion Criteria`
- declare `Failure Policy`

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
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/plan.md`
- `tasks/{task-id}/cache/`
- `tasks/{task-id}/_output/`
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
- `tasks/{task-id}/reflection-report.md`

Then follow this order exactly:

1. write `mind/learning/task-learning/tl-{task-id}.md`
2. write one or more `draft-{type}-{task-id}-{slug}.md`
3. write corresponding `review-{task-id}-{slug}.md`
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

## General Discipline

- prefer explicit file paths over vague references
- prefer formal artifacts over conversational summaries
- prefer deterministic output locations over ad hoc placement
- if a required file is missing, treat the chain as incomplete
- if a file does not match its required template, do not assume it is valid

MindFlow prioritizes stable execution over improvisation.
