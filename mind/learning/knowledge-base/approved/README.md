# approved

This is the formal knowledge area. Only knowledge files here may be read by `Learning(Read)`.

## File Naming Rule

`kb-{type}-{slug}.md`

Where:

- `{type}` may only be `concept / method / domain / self`
- `{slug}` must be stable and reusable

Examples:

- `kb-concept-bounded-context.md`
- `kb-method-structured-review.md`

## Template and Rules

See `TEMPLATE.md` for the formal structure, required fields, admission conditions, and update protocol.

## Index

When `approved/` contains knowledge files, an `INDEX.md` file must be maintained listing each `kb-*.md` with its Type and one-line Summary. `Learning(Read)` reads `INDEX.md` first to select relevant files, rather than reading all files in the directory.

If `INDEX.md` does not exist or `approved/` is empty, `Learning(Read)` records `Approved Knowledge Reads: none`.

### INDEX.md Structure

```md
# Approved Knowledge Index

| File | Type | Summary |
|------|------|---------|
| kb-concept-xxx.md | concept | one-line summary |
| kb-method-yyy.md | method | one-line summary |
```

## Prohibitions

- task-level temporary conclusions must not be placed here
- knowledge without a review record must not enter here
- knowledge with `Review Status: pending` or `rejected` must not enter here
- overwriting an existing `kb-*.md` without first moving it to `archived/` is forbidden
