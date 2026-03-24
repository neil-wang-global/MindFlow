# drafts

This is the pending knowledge area.

It is not a free dumping area. It is the pending-review knowledge area.

## File Naming Rule

Pending knowledge files must use the fixed naming pattern:

`draft-{type}-{task-id}-{slug}.md`

Where:

- `{type}` may only be `concept / method / domain / self`
- `{task-id}` must match the source task
- `{slug}` must match the knowledge topic

## Fixed Rules

- every file must come from a clearly identified `Task`
- every file must come from a `tl-{task-id}.md`
- every file must be prepared to enter `reviews/`
- files here must not be read by `Learning(Read)`
- if a later `Review` accepts the draft, it is converted into `kb-{type}-{slug}.md` and moved into `approved/`

## Required Fields

Every pending knowledge file must contain:

- `Type`
- `Task ID`
- `Summary`
- `From Task Learning`
- `Source Type`
- `Source Anchor`
- `Original Excerpt`
- `Candidate Conclusion`
- `Review Status`
- `Review Target`
- `Notes`

`Source Type`, `Source Anchor`, and `Original Excerpt` are mandatory anti-hallucination fields. A draft that omits any of these three fields is invalid and must not enter `drafts/`.

## Promotion Conditions

Draft knowledge may leave `drafts/` only when all of the following are true:

- the corresponding `tl-{task-id}.md` already exists
- the corresponding `review-*.md` already exists
- the review record has `Decision: accepted`
- the review record has `Verification Mode: independent-subagent`
- the review record has `Summary Verified: yes`
- the review record has `Source Anchor Verified: yes`
- a compliant `kb-{type}-{slug}.md` has been generated
- the `Source Lineage` in `kb-{type}-{slug}.md` traces back to the same `tl-{task-id}.md` and `Source Anchor` as this draft
