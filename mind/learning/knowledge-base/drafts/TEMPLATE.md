# Draft Knowledge Template

This file defines the fixed structure of `mind/learning/knowledge-base/drafts/`.

## File Naming Rule

- file path: `mind/learning/knowledge-base/drafts/draft-{type}-{task-id}-{slug}.md`
- `{type}` may only be `concept / method / domain / self`
- `{task-id}` must match the source task
- `{slug}` must match the candidate knowledge topic

## Fixed Structure

```md
# Draft Knowledge

## Type
- knowledge type

## Task ID
- source task ID

## Summary
- short summary of the candidate knowledge

## From Task Learning
- source task learning record path

## Candidate Conclusion
- candidate conclusion

## Review Status
- `pending`

## Review Target
- target review file path

## Notes
- supplementary notes
```

## Validation Rules

- `From Task Learning` must not be omitted
- `Review Status` must always be `pending`
- `Review Target` must not be omitted
- drafts without a corresponding review target must not enter `drafts/`
