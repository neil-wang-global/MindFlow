# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-05

## Summary
- JWT security requires pre-configured algorithm selection; the "none" algorithm must be rejected; algorithm confusion attacks exploit implementations that trust the JWT header's alg field

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-05/acquire/raw-sources/src-006-rfc8725-jwt-bcp.md`
  - ACQ Event: ACQ-002
  - Verification Report: `tasks/20260401-concurrent-05/acquire/verification-report.md §ACQ-002`
  - Verification Status: passed

## Original Excerpt
> "Do not use \"none\" as a valid algorithm. Always verify the algorithm in the header against a whitelist of expected algorithms. NEVER use the algorithm specified in the JWT header to select the verification key or algorithm — instead, use a pre-configured algorithm based on the key identifier."

## Candidate Conclusion
- JWT security requires pre-configured algorithm selection rather than trusting the JWT header's alg field; the "none" algorithm must be rejected; algorithm confusion attacks exploit implementations that use the JWT header to select verification keys

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-05-jwt-algorithm-verification.md`

## Notes
- Source: RFC 8725 (IETF Best Current Practices)
