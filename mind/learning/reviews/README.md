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
- `Decision`
- `Reason`
- `Promotion Target`
- `Capability Impact`

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
- `Promotion Target` explicitly points to the target file under `mind/learning/knowledge-base/approved/`
- the source `Task` is explicitly stated in the review record
- the promotion reason is explicitly stated in the review record

## Prohibitions

- writing directly into `approved/` without a review record is forbidden
- `Decision: deferred` must not be treated as approval
- `Decision: rejected` must not be promoted
