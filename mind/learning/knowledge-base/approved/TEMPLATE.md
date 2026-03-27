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
- must preserve the meaning of the `Candidate Conclusion` from the corresponding `draft-*.md`
- purely editorial changes are permitted (formatting, punctuation, grammar fixes) but must not alter meaning, scope, or claims
- substantive rephrasing or elaboration is not permitted
- if the conclusion is found inadequate at this stage, the correct action is to reject the review and revise the draft — not to silently rewrite the summary here

## Source Lineage
- Task ID: source task ID
- Task Learning Record: `mind/learning/task-learning/tl-{task-id}.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-{type}-{task-id}-{slug}.md`
- Review File: `mind/learning/reviews/review-{task-id}-{slug}.md`
- Original Source Anchor:
  - for grounded-external: `tasks/{task-id}/acquire/raw-sources/src-{NNN}-{slug}.md`
  - for task-output: `tasks/{task-id}/_output/{filename}.md §{Section}`
- Original Source URL (grounded-external only):
  - the URL recorded in the raw source file above; preserved here so the lineage remains verifiable even if the task directory is cleaned up
- Supersedes (update entries only):
  - `mind/learning/knowledge-base/archived/kb-{type}-{slug}-superseded-by-{task-id}.md`
  - omit this field if this is a new entry, not a revision of an existing one

## Key Evidence
- the `Original Excerpt` carried forward from `draft-*.md`, preserved here to maintain traceability even if the task directory and raw sources are later cleaned up
- must be a verbatim copy of the `Original Excerpt` from the draft file — no modification permitted
- this field ensures the source anchor chain remains verifiable at the approved knowledge level without requiring access to task-level files

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
- `Summary` must preserve the meaning of `Candidate Conclusion` in the corresponding `draft-*.md`; purely editorial changes (formatting, punctuation, grammar) are permitted but substantive divergence is a protocol violation
- `Source Lineage` must not be omitted; every field must be filled
- `Original Source Anchor` must point to an existing file at the time of promotion
- for `grounded-external` entries, `Original Source URL` must not be omitted; it is the permanent fallback reference if the task directory is later cleaned up
- `Key Evidence` must not be omitted; must be a verbatim copy of the `Original Excerpt` from the corresponding `draft-*.md`
- `Applicability` must not be omitted
- a file without a corresponding review record must not enter `approved/`
