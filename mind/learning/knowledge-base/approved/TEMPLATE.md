# Approved Knowledge Template

This file defines the fixed structure of `mind/learning/knowledge-base/approved/`.

## File Naming Rule

- file path: `mind/learning/knowledge-base/approved/kb-{type}-{slug}.md`
- `{type}` may only be `concept / method / domain / self`
- the file name must match the knowledge type

## Fixed Structure

```md
# Knowledge Base Entry

## Type
- knowledge type

## Summary
- core conclusion

## Source
- source task
- source file

## Review Status
- `accepted`

## Approved By Review
- corresponding review file path

## Applicability
- where it applies
- where it does not apply

## Notes
- supplementary notes
```

## Validation Rules

- `Review Status` must always be `accepted`
- `Approved By Review` must not be omitted
- `Applicability` must not be omitted
- a file without a corresponding review record must not enter `approved/`
