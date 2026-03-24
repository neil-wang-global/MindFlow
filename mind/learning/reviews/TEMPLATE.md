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

## Verification Mode
- `independent-subagent` — this review was conducted by a subagent with no shared context with the drafting agent
- `same-context` — this review was conducted in the same execution context as drafting (not valid; must result in Decision: rejected)

## Summary Verified
- `yes` — the `Summary` field in the candidate file introduces no claim not present in `Candidate Conclusion`; it is a condensation only
- `no` — the `Summary` adds scope, qualifications, or meaning not found in `Candidate Conclusion`
- if `no`, Decision must be `rejected`

## Source Anchor Verified
- `yes` — all of the following are confirmed:
  1. the `Source Anchor` path exists as an actual file
  2. the `Original Excerpt` string appears in that file character-for-character (exact substring match, not paraphrase, not semantic equivalence)
  3. the excerpt is not taken out of context in a way that inverts or materially distorts the meaning of the surrounding passage
- `no` — any of the following is true:
  - `Source Anchor` field is missing or empty
  - the file at `Source Anchor` path does not exist
  - the `Original Excerpt` string is not found verbatim in the source file
  - the excerpt omits surrounding context in a way that inverts the original meaning
- if `no`, Decision must be `rejected`
- semantic similarity or paraphrase does not satisfy the match requirement; only exact substring presence qualifies

## Decision
- `accepted / rejected / deferred`

## Reason
- why this decision was made
- if rejected due to Source Anchor failure, state which check failed

## Promotion Target
- target approved knowledge path
- write `none` when `Decision` is `rejected`
- write `pending-reopen` when `Decision` is `deferred` (must not write `none`; the deferred review must be re-opened in a subsequent task)
- write `none` when `Decision` is `accepted` but no promotion is needed (rare; must state reason)

## Capability Impact
- whether any `Capability` may be affected
- write `none` if there is no impact
```

## Validation Rules

- `Summary Verified` must not be omitted
- if `Summary Verified` is `no`, `Decision` must be `rejected`
- `Verification Mode` must not be omitted
- if `Verification Mode` is `same-context`, `Decision` must be `rejected`
- `Source Anchor Verified` must not be omitted
- if `Source Anchor Verified` is `no`, `Decision` must be `rejected`
- `Decision` must be one of `accepted / rejected / deferred`
- `Reason` must not be omitted
- `Promotion Target` must not be omitted
- `Capability Impact` must not be omitted
- `Decision: accepted` is only valid when all three hold: `Verification Mode` is `independent-subagent`, `Summary Verified` is `yes`, and `Source Anchor Verified` is `yes`
