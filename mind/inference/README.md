# inference

This directory defines the `Inference` module.

`Inference` is conditional, not always-on. Its output is provisional by default and does not directly become a formal capability.

## Trigger Conditions

`Inference` may be triggered when:

- `Analysis` identifies a question that cannot be answered from available inputs alone
- `Reflection` surfaces a reusable pattern that requires generalization
- terminal `Learning` requires abstraction beyond what the source materials directly state
- the user explicitly requests inference

## Trigger Decision

The decision to trigger `Inference` is made by the module that encounters the gap:

- during `Analysis`: `Analysis` triggers `Inference` before completing `analysis.md`
- during `Reflection`: `Reflection` triggers `Inference` before completing `reflection-report.md`
- during terminal `Learning`: terminal `Learning` triggers `Inference` before finalizing `tl-{task-id}.md`
- `user-request`: the user may explicitly request inference during any of the three phases above; if the request occurs outside these phases (e.g., during `Execution Control`), the inference must be deferred to the next eligible phase (`Reflection`) — `Current Phase` must not change for the deferral; the runtime must acknowledge the request and inform the user that inference will be addressed during `Reflection`

## Required Reads

Before running `Inference`, the agent must read:

- `mind/soul/core.md`
- `mind/inference/TEMPLATE.md`
- the upstream artifact that triggered it

## Output

`Inference` output is written to `tasks/{task-id}/cache/inference-{slug}.md` using `TEMPLATE.md`.

`Inference` output is provisional by default (`Status: provisional`).

## Acceptance Criteria

The triggering module decides whether to accept or reject the inference output. The decision must be recorded by updating the `Status` field in the inference output file. Acceptance requires all of the following:

- the `Provisional Conclusion` directly addresses the `Question` that triggered the inference
- the `Reasoning` chain is internally consistent and does not rely on unsupported premises
- the `Confidence` level is `medium` or `high`
- the conclusion does not contradict `Soul` constraints or approved knowledge

If any criterion is not met, the inference output must be set to `Status: rejected`. The triggering module must then proceed without the inference result — it must not retry or modify the inference.

## Promotion Rules

Provisional `Inference` output must not directly become:

- approved knowledge
- formal capability change

If an inference conclusion is later validated by task results or external sources, it may enter the learning pipeline through the normal `tl-{task-id}.md` → `draft-*.md` → `review-*.md` path. The `Source Type` in `tl-{task-id}.md` must be `task-output` with `Source Anchor` pointing to the inference output file.
