# reviews

This directory stores learning review records.

It is not a free-comment area. It is the formal review area.

## File Naming Rule

Review record files must use the fixed naming pattern:

`review-{task-id}-{slug}.md`

Example:

- `review-20260311-ddd-bounded-context.md`

## Required Fields

Every review record must contain:

- `Subject`
- `Source Task`
- `Candidate File`
- `Verification Mode`
- `Summary Verified`
- `Source Anchor Verified`
- `Decision`
- `Reason`
- `Promotion Target`
- `Capability Impact`

`Verification Mode`, `Summary Verified`, and `Source Anchor Verified` are mandatory gate fields. A review record that omits any of these three fields is invalid. `Decision: accepted` is only valid when all three pass: `Verification Mode` is `independent-subagent`, `Summary Verified` is `yes`, and `Source Anchor Verified` is `yes`.

## Allowed Decision Values

`Decision` may only be:

- `accepted`
- `rejected`
- `deferred`

## Promotion Conditions

Candidate knowledge may be promoted through `reviews/` only when all of the following are true:

- the corresponding `draft-*.md` already exists
- the corresponding `review-*.md` already exists
- `Decision` is `accepted`
- `Verification Mode` is `independent-subagent`
- `Summary Verified` is `yes`
- `Source Anchor Verified` is `yes`
- `Promotion Target` explicitly points to the target file under `mind/learning/knowledge-base/approved/`
- the source `Task` is explicitly stated in the review record
- the promotion reason is explicitly stated in the review record

## Deferred Decision Lifecycle

`Decision: deferred` is not a terminal state. It means the review could not reach a conclusion with currently available information. The following rules apply:

- `Reason` must state exactly what information is missing or what condition must be met before the review can be concluded
- `Promotion Target` must be written as `pending-reopen` — not `none`
- the corresponding `draft-*.md` must remain in `drafts/` and must not be deleted
- the deferred review must be re-opened in a subsequent task:
  - the re-opening task must write a new `review-{new-task-id}-{slug}.md` that references the original deferred review in its `Subject` field
  - the new review supersedes the deferred one; the deferred review file is then considered closed
- a `deferred` review that has not been re-opened within the scope of the project is considered **stale**; stale deferred reviews must be listed in the next task's `reflection-report.md` under `Issue Detection` until resolved or explicitly rejected

## Rejected Decision Handling

`Decision: rejected` is a terminal state. The following rules apply:

- `Reason` must state the specific grounds for rejection
- `Promotion Target` must be written as `none`
- the corresponding `draft-*.md` must be moved from `drafts/` to `archived/` — it must not remain in `drafts/` indefinitely
- if the rejected knowledge may become relevant under different conditions, a note must be recorded in `Reason` stating those conditions; the knowledge may then re-enter the pipeline via a new draft in a future task
- a `rejected` review must not be re-opened or overridden; if the same knowledge is reconsidered, a new `draft-*.md` and `review-*.md` must be created in the context of a new task

## Prohibitions

- writing directly into `approved/` without a review record is forbidden
- `Decision: deferred` must not be treated as approval
- `Decision: rejected` must not be promoted
- a `deferred` review must not be left permanently unresolved; it must either be re-opened or explicitly converted to `rejected` in a subsequent review
