# archived

This is the historical knowledge area.

It stores knowledge files that have been replaced, retired, or kept only for traceability.

## File Naming Rule

When an `approved/` entry is superseded, it must be moved here using the pattern:

`kb-{type}-{slug}-superseded-by-{new-task-id}.md`

Example: `kb-concept-bounded-context-superseded-by-20260401.md`

## Required Field on Archived Copies

Before moving a file here, add the following field at the top of its `Source Lineage` section:

```
- Superseded By: mind/learning/knowledge-base/approved/kb-{type}-{slug}.md
- Superseded In Task: {new-task-id}
```

## Fixed Rules

- this area must not be read by `Learning(Read)` by default
- it may be inspected as historical reference only when explicitly requested by a human
- content in this area must not be treated as current active knowledge
- files in this area must not be deleted; they are permanent traceability records
- a file must not be moved here without first adding the `Superseded By` field
