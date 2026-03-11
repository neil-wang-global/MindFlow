# MindFlow System Protocol

This file defines the system protocol for AI running inside MindFlow.

## Required Main Flow

Every task must follow this exact flow:

`Task -> Learning(Read) -> Recognition -> Analysis -> Execution -> Plan -> Execution Control -> Reflection -> Learning`

No task may skip:

- `Learning(Read)`
- `Recognition`
- `Analysis`
- `Execution`
- `Execution Control`
- `Reflection`
- terminal `Learning`

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

Runtime rule:

- `Soul` is read as a constraint source
- `Soul` is not auto-filled by the framework
- `Soul` constrains `Learning(Read)`, `Recognition`, `Analysis`, `Reflection`, `Learning`, and `Inference`

### `Capability`

`Capability` is an action unit called by a `Step`.

Runtime rule:

- a `Capability` reads files
- performs one core action
- writes files
- does not own orchestration
- does not bypass system learning rules

### `Plan`

`Plan` is the only formal output of `Execution`.

Runtime rule:

- runtime executes according to `tasks/{task-id}/plan.md`
- scattered step notes are not authoritative
- runtime state is tracked in `tasks/{task-id}/state.md`

### `Execution Control`

`Execution Control` is the runtime control role that executes the formal `Plan`.

Runtime rule:

- it runs after `Execution` has produced `plan.md`
- it advances `Step`s according to the declared dispatch fields
- it checks prerequisites before each `Step`
- it manages branch synchronization and merge ownership
- it validates whether each `Step` is complete enough to move forward
- it hands stable task results to `Reflection`

### `Step`

`Step` is the smallest execution unit inside `Plan`.

Every `Step` must declare:

- goal
- capability
- dispatch mode
- parallel group
- synchronization point
- merge owner
- output isolation
- constraints to read before execution
- inputs
- outputs
- publish-back target for `sources/` or `none`
- learning flag
- dependencies
- completion criteria
- failure policy
- instructions

## Learning(Read) Protocol

`Learning(Read)` always runs before `Recognition`.

It may only read:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`

It must not read:

- `mind/learning/knowledge-base/drafts/`
- `mind/learning/knowledge-base/archived/`
- `mind/learning/task-learning/`
- `mind/learning/reviews/`
- `mind/learning/capability-updates/`

It is read-only with respect to formal knowledge sources.

It may write only one task-layer artifact during this stage:

- `tasks/{task-id}/learning-read.md`

Its purpose is to provide reviewed, formal constraints and knowledge to downstream stages.

`Learning(Read)` must produce:

- `tasks/{task-id}/learning-read.md`

That file is the formal audit record of what `Learning(Read)` actually loaded for the current task.

It must record at least:

- the `Soul` files read
- the approved knowledge files read
- why those reads are relevant to the current task

## Recognition Protocol

`Recognition` must produce:

- `tasks/{task-id}/task-profile.md`

`Recognition` must run after `Learning(Read)` and must use its formal inputs.

`Recognition` must read:

- `tasks/{task-id}/learning-read.md`

`Recognition` identifies at least:

- task type
- goal
- complexity
- risk
- capability needs
- whether step-level learning may be required
- whether `Inference` may be needed

## Analysis Protocol

`Analysis` must produce:

- `tasks/{task-id}/analysis.md`

`Analysis` must read:

- `mind/soul/core.md`
- `mind/learning/knowledge-base/approved/`
- `tasks/{task-id}/learning-read.md`
- `tasks/{task-id}/task-profile.md`

`Analysis` must provide enough structure for `Execution` to generate `Plan` without ambiguity.

## Execution Protocol

`Execution` must produce:

- `tasks/{task-id}/plan.md`
- initial `tasks/{task-id}/state.md`

`Execution` must not reuse:

- old `Plan`
- old `Step`

Each task gets a new `Plan`.

`Execution` must also initialize `tasks/{task-id}/state.md` so that `Execution Control` never starts from an undefined runtime state.

`Execution` is also responsible for deciding the execution mode of `Plan -> Step` execution.

That decision must be explicit, not implicit.

The dispatch model must stay structurally consistent across:

- `tasks/{task-id}/analysis.md`
- `tasks/{task-id}/plan.md`
- step execution
- `tasks/{task-id}/reflection-report.md`

### Plan Output Rules

The default formal result directory is:

- `tasks/{task-id}/_output/`

Intermediate handoff files go to:

- `tasks/{task-id}/cache/`

At least one final-output `Step` must write to:

- `tasks/{task-id}/_output/`

Writing to `sources/` is optional and only allowed when explicitly declared in the relevant `Step`.

### Parallelism and Dispatch Rules

When generating a `Plan`, `Execution` must evaluate whether work should run in:

- sequential mode
- subagent-parallel mode inside one `Step`
- multi-task parallel mode across multiple `Step`s or task branches

`Execution` must make this choice based on dependency shape, context coupling, artifact isolation, and merge risk.

Use sequential mode when:

- the next action depends on the previous action's output
- multiple actions compete for the same mutable artifact
- correctness depends on tight shared context

Use subagent-parallel mode when:

- the parent `Step` has one clear goal
- that goal can be decomposed into independent sub-problems
- each subagent can work with isolated inputs and produce isolated outputs
- the parent `Step` can deterministically merge the results

Use multi-task parallel mode when:

- the task naturally splits into multiple independent work branches
- each branch can be represented as its own `Step` or task-line
- branches do not require hidden conversational coordination
- branch outputs can be validated and integrated through files

`Execution` must prefer the highest safe parallelism level, but must not force parallelism when coordination cost, conflict risk, or validation cost would outweigh the gain.

The canonical dispatch fields are:

- dispatch mode
- parallel group
- synchronization point
- merge owner
- output isolation rule

`Execution` must not invent a second dispatch schema that differs from what `Analysis` produced.

## Step Execution Protocol

`Step` execution follows these rules:

- read declared constraints before running
- read declared input files
- call the declared `Capability`
- write declared output files
- hand off through files, never implicit context

If a `Step` needs multiple capabilities, split it into multiple `Step`s.

Before executing a `Step`, the runtime must check whether the `Plan` declares:

- sequential execution
- subagent decomposition
- parallel sibling `Step`s

Those checks must be derived from the canonical dispatch fields declared in the `Plan`.

If a `Step` is marked for subagent execution, the parent `Step` remains the formal unit, but it must additionally declare:

- decomposition rule
- subagent boundaries
- per-subagent output targets
- merge method
- completion condition

If multiple `Step`s are marked runnable in parallel, they must:

- not write to the same output path
- not rely on undeclared shared mutable state
- declare the synchronization point that rejoins the branches
- declare which `Step` owns merge and branch completion

## Execution Control Protocol

`Execution Control` must read:

- `mind/soul/core.md`
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/plan.md`
- the `Capability` definition files referenced by the `Plan`

`Execution Control` must:

- execute only from the formal `Plan`
- update `tasks/{task-id}/state.md` as the canonical runtime state file
- advance `Step`s according to declared dependencies
- enforce the canonical dispatch fields during runtime
- enforce output isolation
- ensure branch merge happens only at declared synchronization points
- ensure at least one final-output `Step` produces files in `tasks/{task-id}/_output/`
- enforce each `Step`'s completion criteria
- enforce each `Step`'s failure policy

`Execution Control` must not:

- rewrite `plan.md` during execution
- replace formal file handoff with implicit conversational memory
- skip failed `Step` validation and continue silently

## Reflection Protocol

After task execution, `Reflection` must produce:

- `tasks/{task-id}/reflection-report.md`

`Reflection` must read:

- `mind/soul/core.md`
- `tasks/{task-id}/state.md`
- `tasks/{task-id}/plan.md`
- `tasks/{task-id}/cache/`
- `tasks/{task-id}/_output/`
- declared `sources/` publish-back paths if they exist

`Reflection` identifies at least:

- result quality
- process issues
- learning candidates
- capability impact
- inference triggers

## Terminal Learning Protocol

Terminal `Learning` runs after `Reflection`.

It must read:

- `mind/soul/core.md`
- `tasks/{task-id}/reflection-report.md`

Its input sources may vary, but its output path is fixed.

It must execute in this order:

1. create `mind/learning/task-learning/tl-{task-id}.md`
2. create one or more `mind/learning/knowledge-base/drafts/draft-{type}-{task-id}-{slug}.md`
3. create corresponding `mind/learning/reviews/review-{task-id}-{slug}.md`
4. only accepted reviews may produce `mind/learning/knowledge-base/approved/kb-{type}-{slug}.md`
5. if needed, create `mind/learning/capability-updates/cu-{task-id}-{capability-name}.md`

Only approved knowledge may be reused by future `Learning(Read)`.

## Inference Protocol

`Inference` is conditional, not always-on.

It may be triggered when:

- `Analysis` lacks enough information
- `Reflection` surfaces a reusable pattern
- terminal `Learning` requires abstraction
- the user explicitly requests inference

`Inference` output is provisional by default.

It must not directly become:

- approved knowledge
- formal capability change

## Constraint Loading Rule

Before entering any module or any `Step`, the AI must first read the constraint files declared at that location.

If required constraint files are missing from the formal artifact, the artifact is incomplete and should not be treated as runnable.

## Task Directory Minimum

Every task directory must contain:

- `learning-read.md`
- `state.md`
- `task-profile.md`
- `analysis.md`
- `plan.md`
- `reflection-report.md`
- `_output/`
- `cache/`

## Source Directory Rule

`sources/` is for project materials and optional publish-back outputs.

It is not:

- the default task result directory
- a cache directory
- a plan directory
- a reflection directory

## Skill Rule

`Skill` is not a top-level runtime object.

A `Capability` may load a `Skill`, but:

- `Capability` is not `Skill`
- `Skill` is only an execution resource
- only compatible skills may be loaded
