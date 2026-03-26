# sources

This directory is the unified location for user-provided materials and promoted task outputs.

## Purpose

`sources/` holds both:

- **user-provided input materials**: raw materials, reference documents, external inputs, requirements, design specifications
- **promoted task outputs**: final deliverables published back from a task's `_output/` according to `Plan`

## Relationship to `_output/`

- `tasks/{task-id}/_output/` is the **task-level** result directory — every completed task must produce output here
- `sources/` is the **project-level** material directory — content here persists across tasks

A task output must earn its place in `sources/` through explicit `Plan` declaration. The default destination is always `_output/`.

## Fixed Rules

- `sources/` must not store task runtime cache, `Plan`, or `Reflection Report`
- files may be written into `sources/` only when `Plan` explicitly declares a publish-back path
- if any file in `sources/` is used by a task, that usage must be referenced in the corresponding task artifact

## Allowed Content

- raw materials (requirements, specifications, briefs)
- reference materials (external documents, research papers)
- external input files (data, configurations)
- final deliverables published back according to `Plan`
