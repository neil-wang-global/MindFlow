# Knowledge Base Entry

## Type
- concept

## Summary
- HMAC-based JWT algorithms (HS256) use symmetric keys where any verifier can also forge tokens, while RSA/ECDSA algorithms (RS256, ES256) use asymmetric keys providing non-repudiation; this makes asymmetric algorithms mandatory for distributed systems where token verification occurs on multiple services

## Source Lineage
- Task ID: 20260401-concurrent-05
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-jwt-signing-tradeoffs.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-05-jwt-signing-tradeoffs.md`
- Original Source Anchor: `tasks/20260401-concurrent-05/acquire/raw-sources/src-005-rfc7515-jws.md`
- Original Source URL: https://datatracker.ietf.org/doc/html/rfc7515

## Key Evidence
> "Digital signatures provide non-repudiation (the signer cannot deny signing), while MACs do not. HMAC-based algorithms (HS256, HS384, HS512) use symmetric keys, meaning anyone who can verify the MAC can also create it. RSA and ECDSA-based algorithms use asymmetric keys, providing true non-repudiation."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-05-jwt-signing-tradeoffs.md`

## Applicability
- Applies to: JWT token issuance and verification in microservice architectures, API gateways, distributed authentication systems
- Does not apply to: single-service deployments where the same service issues and verifies tokens (HS256 acceptable in this case)

## Notes
- RFC 7515; ES256 (ECDSA P-256) offers equivalent security to RS256 with shorter keys and faster computation
- RS256 keys should be at least 2048 bits per RFC 8725 best practices
