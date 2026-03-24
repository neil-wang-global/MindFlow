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
- must be a direct condensation of `Candidate Conclusion` — no new claims, no rephrasing that introduces different meaning
- permitted: shortening, removing redundant words
- not permitted: adding qualifications, changing scope, substituting synonyms that shift meaning

## From Task Learning
- source task learning record path
- candidate knowledge item reference: KDC-{NNN}

## Source Type
- `grounded-external` or `task-output`

## Source Anchor
- for grounded-external: `tasks/{task-id}/acquire/raw-sources/src-{NNN}-{slug}.md`
  - ACQ Event: ACQ-{NNN} (the acquisition event this source belongs to; must match the `ACQ Event` field in the raw source file)
  - Verification Report: `tasks/{task-id}/acquire/verification-report.md §ACQ-{NNN}`
  - Verification Status: `passed` (confirmed in `Passed Sources for ACQ-{NNN}` of the above report section)
- for task-output: `tasks/{task-id}/_output/{filename}.md §{Section}` or `tasks/{task-id}/cache/{filename}.md §{Section}`

## Original Excerpt
- verbatim quote carried forward from `tl-{task-id}.md` — must not be paraphrased or modified

## Candidate Conclusion
- must be copied verbatim from the `Derived Conclusion` of the corresponding `KDC-{NNN}` item in `tl-{task-id}.md`
- no rephrasing, elaboration, or refinement is permitted at this stage
- if the conclusion in `tl-` is found to be inadequate, the correct action is to revise `tl-` first, then carry the revised conclusion forward — not to silently diverge in `draft-`

## Review Status
- `pending`

## Review Target
- target review file path

## Notes
- supplementary notes
```

## Validation Rules

- `Summary` must not introduce any claim not present in `Candidate Conclusion`; it must be a condensation only
- `From Task Learning` must not be omitted; must reference a specific `KDC-{NNN}` item
- `Source Type` must not be omitted; must be `grounded-external` or `task-output`
- `Source Anchor` must not be omitted; must point to an existing file
- for `grounded-external`: the cited `src-{NNN}` must appear as `passed` in the `Passed Sources for ACQ-{NNN}` section of the referenced verification report; the `ACQ Event` field must be present and must match the `ACQ Event` field in the raw source file
- `Original Excerpt` must not be omitted; must be a verbatim quote — no paraphrasing permitted
- `Candidate Conclusion` must not be omitted; must be copied verbatim from the corresponding `KDC-{NNN}.Derived Conclusion` in `tl-{task-id}.md` — divergence from the tl- record is not permitted; revise `tl-` first if the conclusion needs updating
- `Review Status` must always be `pending`
- `Review Target` must not be omitted
- drafts without a corresponding review target must not enter `drafts/`
- a draft that omits `Source Anchor` or `Original Excerpt` is invalid and must not enter `drafts/`
