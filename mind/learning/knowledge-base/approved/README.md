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
- `Source`
- `Review Status`
- `Approved By Review`
- `Applicability`
- `Notes`

## Admission Conditions

A knowledge file may enter `approved/` only when all of the following are true:

- the corresponding `review-*.md` already exists
- the corresponding review record has `Decision: accepted`
- `Review Status` is `accepted`
- `Approved By Review` contains the path to the corresponding review record
- `Source` is not omitted
- the file name matches `kb-{type}-{slug}.md`

## Prohibitions

- task-level temporary conclusions must not be placed here
- knowledge without a review record must not enter here
- knowledge with `Review Status: pending` or `rejected` must not enter here
