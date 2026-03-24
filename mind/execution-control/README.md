# execution-control

This directory defines the `Execution Control` module.

`Execution Control` is not a new top-level center, and it is not an independent persona.

It is the runtime control responsibility inside `Mind`. Its job is to advance the generated `Plan` into actual task execution.

## Responsibilities

- advance `Step`s according to `Plan`
- check whether each `Step`'s prerequisites are satisfied before execution
- manage sequential execution, `subagent` parallelism, and branch parallelism according to `Dispatch Mode`
- manage branch merge and synchronization points
- check whether each `Step` has reached its completion criteria
- decide whether failure should trigger retry, rework, termination, or return to an upstream module
- hand stable runtime results to `Reflection`

## Inputs

- the current `Task`'s `state.md`
- the current `Task`'s `plan.md`
- the current `Task`'s `cache/`
- the current `Task`'s `_output/`
- the `Capability` definition files referenced by the current `Plan`

## Required Constraint Loading Before Execution

Before running `Execution Control`, the agent must read:

- `mind/soul/core.md`
- the current `Task`'s `state.md`
- the current `Task`'s `plan.md`
- the `Capability` definition files referenced by the current `Plan`

## Outputs

`Execution Control` does not create a new standalone formal artifact.

Its responsibility is to ensure:

- `state.md` accurately reflects the current phase, current step, branch state, and failure state
- `Plan` is executed under its declared constraints
- `cache/` contains the correct intermediate handoff files
- `_output/` contains the correct final result files
- parallel branches are merged exactly as declared in `Plan`

## Failure Policy: escalate-to-reflection

When a `Step` declares `Failure Policy: escalate-to-reflection` and that policy is triggered:

1. **Stop the Step immediately.** Do not retry or rework.
2. **Preserve all partial outputs.** Any files already written to `cache/` or `_output/` must not be deleted; they are inputs to Reflection.
3. **Update `state.md`**:
   - `Overall Status: blocked`
   - `Step Status Map`: mark the failed Step as `failed`
   - `Last Failure`: record the Step number, the failure reason, and which outputs were partially produced
   - `Ready For Reflection: yes`
4. **Do not advance to the next Step.** Do not attempt remaining Steps.
5. **Hand control to `Reflection`**, which reads `state.md`, `plan.md`, partial `cache/`, and partial `_output/` to produce `reflection-report.md`.
6. **After Reflection**, terminal `Learning` runs as normal. The failed task does **not** automatically re-execute the failed Step — any re-execution must be declared in a new task.

## Learning(Acquire) Mid-Step State Management

When a Step with `Learning: acquire-required` encounters a knowledge gap and triggers `Learning(Acquire)`:

1. **Pause the Step.** Record in `state.md`:
   - `Current Step`: the paused Step number
   - `Step Status Map`: mark the Step as `blocked`
   - `Learning(Acquire) Log`: add the entry `Step {N}: gap-encountered → ACQ-{NNN} triggered`
2. **Execute `Learning(Acquire)` to completion** (all three stages: Search, Fetch and Preserve, Verify).
3. **After `Learning(Acquire)` completes**, resume the Step:
   - re-read the Step's `Constraints` and `Inputs` before resuming (the Step must not rely on context from before the pause)
   - update `state.md`: `Step Status Map` → `running`
4. **If `Learning(Acquire)` is exhausted** (zero passed sources):
   - record in `state.md` `Learning(Acquire) Log`: `Step {N}: gap-encountered → ACQ-{NNN} exhausted`
   - apply the Step's declared `Failure Policy`; `escalate-to-reflection` is the recommended policy for exhausted acquisition

## Key Principles

- do not rewrite `Plan`
- do not replace `Execution`
- do not replace `Reflection`
- do not bypass `Step`
- do not bypass `Capability`
- do not replace file-based handoff with implicit context
- do not leave parallel decisions to ad hoc runtime judgment
