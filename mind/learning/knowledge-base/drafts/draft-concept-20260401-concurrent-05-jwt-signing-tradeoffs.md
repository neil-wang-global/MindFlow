# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-05

## Summary
- HMAC-based JWT algorithms use symmetric keys allowing any verifier to forge tokens; RSA/ECDSA use asymmetric keys providing non-repudiation required for distributed systems

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-05/acquire/raw-sources/src-005-rfc7515-jws.md`
  - ACQ Event: ACQ-002
  - Verification Report: `tasks/20260401-concurrent-05/acquire/verification-report.md §ACQ-002`
  - Verification Status: passed

## Original Excerpt
> "Digital signatures provide non-repudiation (the signer cannot deny signing), while MACs do not. HMAC-based algorithms (HS256, HS384, HS512) use symmetric keys, meaning anyone who can verify the MAC can also create it. RSA and ECDSA-based algorithms use asymmetric keys, providing true non-repudiation."

## Candidate Conclusion
- HMAC-based JWT algorithms (HS256) use symmetric keys where any verifier can also forge tokens, while RSA/ECDSA algorithms (RS256, ES256) use asymmetric keys providing non-repudiation; this makes asymmetric algorithms mandatory for distributed systems where token verification occurs on multiple services

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-05-jwt-signing-tradeoffs.md`

## Notes
- Source: RFC 7515 (IETF)
