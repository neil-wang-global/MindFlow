# Knowledge Base Entry

## Type
- concept

## Summary
- OWASP recommends allowlist (positive) validation as the primary input validation strategy because it automatically blocks new attack vectors; denylist validation is weaker and should only serve as secondary defense since new attack patterns may not be in the denylist

## Source Lineage
- Task ID: 20260401-concurrent-05
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-owasp-allowlist-validation.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-05-owasp-allowlist-validation.md`
- Original Source Anchor: `tasks/20260401-concurrent-05/acquire/raw-sources/src-007-owasp-input-validation.md`
- Original Source URL: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html

## Key Evidence
> "Allowlist (Positive) Validation:\n- Define what IS allowed — reject everything else\n- More secure than denylist because new attack vectors are automatically blocked\n- Example: for a username field, allow only alphanumeric characters [a-zA-Z0-9]\n- RECOMMENDED approach per OWASP"

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-05-owasp-allowlist-validation.md`

## Applicability
- Applies to: API input validation, web form validation, REST endpoint parameter validation, any system accepting external input
- Does not apply to: internal service-to-service communication where inputs are already validated at the boundary (though defense in depth recommends validation at all layers)

## Notes
- Server-side validation is mandatory; client-side validation is UX only
- Complement with output encoding appropriate to context (HTML, JavaScript, URL, CSS, SQL parameterization)
- Validate Content-Type, request body schema, URL params, HTTP method, and body size for API endpoints
