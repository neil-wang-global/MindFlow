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
  2. the `Original Excerpt` matches the source file content after whitespace normalization (collapse consecutive whitespace characters into a single space, trim leading/trailing whitespace); the normalized excerpt must appear as a substring of the normalized source file content; **the reviewing subagent should use a search tool (e.g. Grep with literal/fixed-string mode) to perform this substring check rather than relying on memory-based comparison**
  3. the excerpt is not taken out of context in a way that inverts or materially distorts the meaning of the surrounding passage
- `no` — any of the following is true:
  - `Source Anchor` field is missing or empty
  - the file at `Source Anchor` path does not exist
  - the `Original Excerpt` does not match the source file content even after whitespace normalization
  - the excerpt omits surrounding context in a way that inverts the original meaning
- if `no`, Decision must be `rejected`
- paraphrase or semantic similarity does not satisfy the match requirement; only normalized substring presence qualifies

## Conflict Check
- `no-conflict` — no existing `kb-*.md` in `approved/` contradicts or substantially overlaps with this candidate
- `conflict-found` — one or more existing approved knowledge entries conflict with this candidate; list the conflicting files and the nature of the conflict
- if `conflict-found`, the `Reason` must address how the conflict should be resolved (e.g. supersede the old entry, reject the new candidate, or defer for further investigation)

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
- `Conflict Check` must not be omitted; must be `no-conflict` or `conflict-found`
- `Decision: accepted` is only valid when all of the following hold: `Verification Mode` is `independent-subagent`, `Summary Verified` is `yes`, `Source Anchor Verified` is `yes`, and `Conflict Check` is either `no-conflict` or `conflict-found` with explicit resolution stated in `Reason`

## Deferred Decision Lifecycle

`Decision: deferred` is not a terminal state. It means the review could not reach a conclusion with currently available information. The following rules apply:

- `Reason` must state exactly what information is missing or what condition must be met before the review can be concluded
- `Promotion Target` must be written as `pending-reopen` — not `none`
- the corresponding `draft-*.md` must remain in `drafts/` and must not be deleted
- the deferred review must be re-opened in a subsequent task:
  - the re-opening task must write a new `review-{new-task-id}-{slug}.md` that references the original deferred review in its `Subject` field
  - the new review supersedes the deferred one; the deferred review file is then considered closed
- a `deferred` review that has not been re-opened within the scope of the project is considered **stale**; stale deferred reviews are surfaced by `Learning(Read)` in `learning-read.md §Pending Cross-Task Items` and must be listed in the next task's `reflection-report.md` under `Issue Detection` until resolved or explicitly rejected

## Rejected Decision Handling

`Decision: rejected` is a terminal state. The following rules apply:

- `Reason` must state the specific grounds for rejection
- `Promotion Target` must be written as `none`
- the corresponding `draft-*.md` must be moved from `drafts/` to `archived/` — it must not remain in `drafts/` indefinitely
- if the rejected knowledge may become relevant under different conditions, a note must be recorded in `Reason` stating those conditions; the knowledge may then re-enter the pipeline via a new draft in a future task
- a `rejected` review must not be re-opened or overridden; if the same knowledge is reconsidered, a new `draft-*.md` and `review-*.md` must be created in the context of a new task
