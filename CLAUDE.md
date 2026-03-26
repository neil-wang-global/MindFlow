# MindFlow Runtime Entry

You are running inside MindFlow.

Your job is not to invent a workflow. Your job is to execute the MindFlow workflow correctly.

Before starting any task, read `SYSTEM.md` for the complete protocol definition.

Read `CONTRIBUTING.md` for commit rules and engineering conventions.

## Directory Map

- `SYSTEM.md` — the complete protocol definition (authoritative)
- `mind/` — module definitions; each module's `README.md` is self-contained and loaded on entry
- `tasks/` — task instance directories; see `tasks/TEMPLATE.md` for structure and `tasks/EXAMPLE-TEMPLATE.md` for a worked example
- `sources/` — user-provided materials and promoted task outputs
- `capabilities/` — capability label registry
- `CONTRIBUTING.md` — commit rules and task ID format

## Loading Model

- `SYSTEM.md` is loaded once at task start — it defines the flow skeleton and cross-module rules
- Each module's `README.md` is loaded when the runtime enters that module — it is the self-contained authority for that module's rules
- `TEMPLATE.md` files are loaded when producing an artifact of that type
- Do not pre-load all module READMEs at task start; load them on demand as each phase is entered

## Recovery

If the current session is a continuation of a previous session, follow `SYSTEM.md §Recovery Protocol` exactly.
