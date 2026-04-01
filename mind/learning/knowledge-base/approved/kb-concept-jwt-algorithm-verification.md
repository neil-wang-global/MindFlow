# Knowledge Base Entry

## Type
- concept

## Summary
- JWT security requires pre-configured algorithm selection rather than trusting the JWT header's alg field; the "none" algorithm must be rejected; algorithm confusion attacks exploit implementations that use the JWT header to select verification keys

## Source Lineage
- Task ID: 20260401-concurrent-05
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-jwt-algorithm-verification.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-05-jwt-algorithm-verification.md`
- Original Source Anchor: `tasks/20260401-concurrent-05/acquire/raw-sources/src-006-rfc8725-jwt-bcp.md`
- Original Source URL: https://datatracker.ietf.org/doc/html/rfc8725

## Key Evidence
> "Do not use \"none\" as a valid algorithm. Always verify the algorithm in the header against a whitelist of expected algorithms. NEVER use the algorithm specified in the JWT header to select the verification key or algorithm — instead, use a pre-configured algorithm based on the key identifier."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-05-jwt-algorithm-verification.md`

## Applicability
- Applies to: any system that verifies JWT tokens, including API gateways, resource servers, authentication middleware, and custom JWT verification code
- Does not apply to: systems that only issue tokens (though issuers should also follow these practices for defense in depth)

## Notes
- RFC 8725 Best Current Practices; algorithm substitution attack (RS256 -> HS256 with public key as HMAC secret) is a well-documented vulnerability class
- Use the "typ" header parameter to prevent token substitution attacks between different token types
