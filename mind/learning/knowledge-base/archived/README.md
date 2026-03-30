# archived

This is the historical knowledge area. It stores knowledge files that have been replaced, retired, or kept only for traceability.

## File Naming Rule

When an `approved/` entry is superseded, it must be moved here using the pattern:

`kb-{type}-{slug}-superseded-by-{new-task-id}.md`

## Required Field on Archived Copies

Before moving a file here, add the following field at the top of its `Source Lineage` section:

```
- Superseded By: mind/learning/knowledge-base/approved/kb-{type}-{slug}.md
- Superseded In Task: {new-task-id}
```

## Fixed Rules

- not readable by `Learning(Read)` (see `mind/learning/learning-read/README.md §Read Scope`)
- may be inspected as historical reference only when explicitly requested by a human
- content must not be treated as current active knowledge
- files must not be deleted; they are permanent traceability records
- a file must not be moved here without first adding the `Superseded By` field
- when moving a `kb-*.md` to `archived/`, the corresponding entry must be removed from `approved/INDEX.md`
