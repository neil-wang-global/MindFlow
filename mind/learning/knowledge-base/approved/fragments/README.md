# Index Fragments

This directory holds per-task index fragment files that are pending merge into `approved/INDEX.md`.

## Purpose

When a task promotes knowledge to `approved/`, it writes `kb-*.md` files and records their index entries in a fragment file here — instead of directly editing `INDEX.md`. This eliminates concurrent write contention when multiple tasks run simultaneously.

## File Naming Rule

- file path: `mind/learning/knowledge-base/approved/fragments/index-fragment-{task-id}.md`
- `{task-id}` must match the source task

## File Format

The fragment file contains only table rows (no header), using the same column format as `INDEX.md`:

```md
| kb-{type}-{slug}.md | {type} | {one-line summary} |
```

Multiple rows may appear in a single fragment when a task promotes more than one knowledge entry.

## Lifecycle

1. **Created** by terminal Learning step 5 when `kb-*.md` files are promoted to `approved/`
2. **Merged** into `INDEX.md` by the §Index Merge Protocol (see `mind/learning/README.md`)
3. **Deleted** after successful merge

A fragment file that still exists after its task has completed indicates an interrupted merge — recovery should complete it.
