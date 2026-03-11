# sources

This directory is the unified location for project materials.

It is not a template directory, and it is not a task cache directory.

## Fixed Rules

- `sources/` stores project material files only
- `sources/` must not store task runtime cache
- `sources/` must not store `Plan`
- `sources/` must not store `Reflection Report`
- `sources/` is not the default task result directory
- files may be written into `sources/` only when `Plan` explicitly declares a publish-back path
- if any file in `sources/` is used by a task, that usage must be explicitly referenced in the corresponding `Task` artifact

## Allowed Content

- raw materials
- reference materials
- external input files
- final deliverables published back according to `Plan`
