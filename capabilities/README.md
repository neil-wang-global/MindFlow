# capabilities

This file is a navigation aid for human readers. The runtime loads individual `cap-{name}.md` files on demand — it does not load this file for constraint purposes.

This directory stores `Capability` definitions used by `Plan` and `Step`.

## Directory Structure

- `TEMPLATE.md` — the formal template for capability definition files
- `cap-EXAMPLE-TEMPLATE.md` — a worked example (not loaded by runtime)
- `cap-{name}.md` — individual capability definitions (created as needed)

## Current Status

The definition structure is ready (see `TEMPLATE.md`), but no individual capability definition files have been instantiated yet. Capabilities are currently referenced by label name in `Step` declarations (e.g. `Capability: cap-research`).

When a `Step` references a capability label that has a corresponding `cap-{name}.md` file, the runtime must read that file as part of the `Step`'s constraint loading. When no file exists for the label, the `Step` proceeds with the label as a classification identifier only — constraint loading from `capabilities/` is skipped for that Step.

## Rules

- a `Step` must declare exactly one `Capability` label
- if a `Step` needs multiple capabilities, split it into multiple `Step`s
- `Capability` labels should be stable across tasks for traceability
- see `TEMPLATE.md` for the full authoring rules when creating a new capability definition

## Skill Rule

`Skill` is not a top-level runtime object. A `Capability` may load a `Skill`, but:

- `Capability` is not `Skill`
- `Skill` is only an execution resource that provides tool-level functionality
- `Skill` selection is made at runtime by the executing agent; it is not declared in `Plan`

## Bootstrap

During bootstrap (before any `cap-{name}.md` files exist):

- capability labels in `Step` declarations serve as classification identifiers only
- constraint loading from `capabilities/` is skipped for Steps whose label has no corresponding file
- `Capability Update` records (`cu-*.md`) may still be created with `Status: proposed`; they will be applied once the target `cap-{name}.md` is created
- the capability evolution mechanism fully activates once the first `cap-{name}.md` file is created via a `Capability Update` with `Status: applied`

Create the first `cap-{name}.md` file when:
- a `Capability Update` record (`cu-*.md`) reaches `Status: approved` and its `Target Capability File` does not yet exist
- or when you identify a recurring capability label across multiple tasks that would benefit from formal constraints
