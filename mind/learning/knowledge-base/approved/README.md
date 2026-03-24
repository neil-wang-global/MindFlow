# approved

This is the formal knowledge area.

Only knowledge files here may be read by `Learning(Read)`.

## File Naming Rule

Formal knowledge files must use the fixed naming pattern:

`kb-{type}-{slug}.md`

Where:

- `{type}` may only be `concept / method / domain / self`
- `{slug}` must be stable and reusable

Examples:

- `kb-concept-bounded-context.md`
- `kb-method-structured-review.md`
- `kb-domain-enterprise-ddd.md`

## Required Fields

Every formal knowledge file must contain:

- `Type`
- `Summary`
- `Source Lineage` (with all sub-fields filled: Task ID, Task Learning Record, Draft File, Review File, Original Source Anchor, Original Source URL for grounded-external)
- `Review Status`
- `Approved By Review`
- `Applicability`
- `Notes`

For entries that supersede a previous version, `Source Lineage` must also include a `Supersedes` field pointing to the archived copy.

## Admission Conditions

A knowledge file may enter `approved/` only when all of the following are true:

- the corresponding `review-*.md` already exists
- the corresponding review record has `Decision: accepted`
- `Review Status` is `accepted`
- `Approved By Review` contains the path to the corresponding review record
- `Source Lineage` is complete and all sub-fields are filled
- for `grounded-external` entries, `Original Source URL` must not be omitted
- the file name matches `kb-{type}-{slug}.md`

## Update Protocol

When an existing `kb-*.md` entry must be revised (new evidence, correction, scope change):

1. **Move the superseded file to `archived/`** before writing the new version:
   - rename: `mind/learning/knowledge-base/archived/kb-{type}-{slug}-superseded-by-{new-task-id}.md`
   - add a `Superseded By` field at the top of the archived copy pointing to the new entry
2. **Write the new entry** through the full promotion path:
   - produce a new `draft-{type}-{new-task-id}-{slug}.md`
   - produce a new `review-{new-task-id}-{slug}.md` via independent subagent
   - only after `Decision: accepted` may the new `kb-{type}-{slug}.md` be written to `approved/`
3. **The new entry must include a `Supersedes` field** in its `Source Lineage`:
   - `Supersedes: mind/learning/knowledge-base/archived/kb-{type}-{slug}-superseded-by-{new-task-id}.md`

Direct overwrite of an existing `kb-*.md` is forbidden. Overwriting destroys the original Source Lineage and bypasses the review gate.

## Prohibitions

- task-level temporary conclusions must not be placed here
- knowledge without a review record must not enter here
- knowledge with `Review Status: pending` or `rejected` must not enter here
- overwriting an existing `kb-*.md` without first moving it to `archived/` is forbidden
