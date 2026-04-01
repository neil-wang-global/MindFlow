# Knowledge Base Entry

## Type
- concept

## Summary
- PKCE mitigates authorization code interception by binding each authorization request to a cryptographically random code_verifier; the authorization server verifies proof of possession by comparing the code_verifier submitted at token exchange against the code_challenge sent during authorization request

## Source Lineage
- Task ID: 20260401-concurrent-05
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-05.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-oauth-pkce.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-05-oauth-pkce.md`
- Original Source Anchor: `tasks/20260401-concurrent-05/acquire/raw-sources/src-002-rfc7636-pkce.md`
- Original Source URL: https://datatracker.ietf.org/doc/html/rfc7636

## Key Evidence
> "To mitigate this attack, this extension utilizes a dynamically created cryptographically random key called \"code verifier\". A unique code verifier is created for every authorization request, and its transformed value, called \"code challenge\", is sent to the authorization server to obtain the authorization code. The authorization code obtained is then sent to the token endpoint with the \"code verifier\", and the server compares it with the previously received request code so it can perform the proof of possession of the \"code verifier\" by the client."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-05-oauth-pkce.md`

## Applicability
- Applies to: any OAuth 2.0 implementation using the authorization code flow, especially public clients (mobile apps, SPAs, desktop apps) that cannot securely store client secrets; also recommended for confidential clients per OAuth 2.1
- Does not apply to: client credentials flow (no user-facing authorization), direct token issuance patterns without authorization codes

## Notes
- RFC 7636; S256 (SHA-256) transformation is mandatory to implement; plain transformation only as fallback
- OAuth 2.1 draft makes PKCE mandatory for all authorization code flows
