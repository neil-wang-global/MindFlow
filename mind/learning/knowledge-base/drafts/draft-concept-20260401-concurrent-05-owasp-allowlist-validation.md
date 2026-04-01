# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-05

## Summary
- OWASP recommends allowlist validation as primary input validation; denylist should only serve as secondary defense

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- candidate knowledge item reference: KDC-005

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-05/acquire/raw-sources/src-007-owasp-input-validation.md`
  - ACQ Event: ACQ-003
  - Verification Report: `tasks/20260401-concurrent-05/acquire/verification-report.md §ACQ-003`
  - Verification Status: passed

## Original Excerpt
> "Allowlist (Positive) Validation:\n- Define what IS allowed — reject everything else\n- More secure than denylist because new attack vectors are automatically blocked\n- Example: for a username field, allow only alphanumeric characters [a-zA-Z0-9]\n- RECOMMENDED approach per OWASP"

## Candidate Conclusion
- OWASP recommends allowlist (positive) validation as the primary input validation strategy because it automatically blocks new attack vectors; denylist validation is weaker and should only serve as secondary defense since new attack patterns may not be in the denylist

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-05-owasp-allowlist-validation.md`

## Notes
- Source: OWASP Input Validation Cheat Sheet
