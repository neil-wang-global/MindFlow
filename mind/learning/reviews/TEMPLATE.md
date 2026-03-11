# Learning Review Template

This file defines the fixed structure of learning review records.

## File Naming Rule

- file path: `mind/learning/reviews/review-{task-id}-{slug}.md`
- `{task-id}` must match the source task

## Fixed Structure

```md
# Learning Review

## Subject
- review subject

## Source Task
- source task ID

## Candidate File
- reviewed candidate file path

## Decision
- `accepted / rejected / deferred`

## Reason
- why this decision was made

## Promotion Target
- target approved knowledge path
- write `none` when not promoted

## Capability Impact
- whether any `Capability` may be affected
- write `none` if there is no impact
```

## Validation Rules

- `Decision` must be one of `accepted / rejected / deferred`
- `Reason` must not be omitted
- `Promotion Target` must not be omitted
- `Capability Impact` must not be omitted
