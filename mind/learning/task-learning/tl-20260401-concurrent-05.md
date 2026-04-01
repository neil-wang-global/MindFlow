# Task Learning Record

## Task ID
- 20260401-concurrent-05

## Task Summary
- Acquired structured knowledge about API security best practices across three domains: OAuth 2.0/OIDC authorization flows and PKCE, JWT signing algorithms and token revocation, and rate limiting strategies with OWASP input validation
- Produced a consolidated API security summary in _output/ covering all three domains with primary source grounding (IETF RFCs, OpenID Foundation, OWASP)

## External Acquisition

### ACQ-001: OAuth 2.0 and OpenID Connect knowledge acquisition

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-05/acquire/verification-report.md` §ACQ-001
- **Passed Sources**: src-001, src-002, src-003

### ACQ-002: JWT security knowledge acquisition

- **Trigger**: step-triggered: Step 2
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-05/acquire/verification-report.md` §ACQ-002
- **Passed Sources**: src-004, src-005, src-006

### ACQ-003: Rate limiting and input validation knowledge acquisition

- **Trigger**: step-triggered: Step 3
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-05/acquire/verification-report.md` §ACQ-003
- **Passed Sources**: src-007, src-008, src-009

## Candidate Knowledge

### [KDC-001] OAuth 2.0 Authorization Code Flow with PKCE

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-05/acquire/raw-sources/src-002-rfc7636-pkce.md`
- **Verification Status**: passed
- **Original Excerpt**: > "To mitigate this attack, this extension utilizes a dynamically created cryptographically random key called \"code verifier\". A unique code verifier is created for every authorization request, and its transformed value, called \"code challenge\", is sent to the authorization server to obtain the authorization code. The authorization code obtained is then sent to the token endpoint with the \"code verifier\", and the server compares it with the previously received request code so it can perform the proof of possession of the \"code verifier\" by the client."
- **Derived Conclusion**: PKCE mitigates authorization code interception by binding each authorization request to a cryptographically random code_verifier; the authorization server verifies proof of possession by comparing the code_verifier submitted at token exchange against the code_challenge sent during authorization request

### [KDC-002] JWT Signing Algorithm Security Tradeoffs

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-05/acquire/raw-sources/src-005-rfc7515-jws.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Digital signatures provide non-repudiation (the signer cannot deny signing), while MACs do not. HMAC-based algorithms (HS256, HS384, HS512) use symmetric keys, meaning anyone who can verify the MAC can also create it. RSA and ECDSA-based algorithms use asymmetric keys, providing true non-repudiation."
- **Derived Conclusion**: HMAC-based JWT algorithms (HS256) use symmetric keys where any verifier can also forge tokens, while RSA/ECDSA algorithms (RS256, ES256) use asymmetric keys providing non-repudiation; this makes asymmetric algorithms mandatory for distributed systems where token verification occurs on multiple services

### [KDC-003] JWT Claim Validation and Token Revocation Strategies

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-05/acquire/raw-sources/src-006-rfc8725-jwt-bcp.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Do not use \"none\" as a valid algorithm. Always verify the algorithm in the header against a whitelist of expected algorithms. NEVER use the algorithm specified in the JWT header to select the verification key or algorithm — instead, use a pre-configured algorithm based on the key identifier."
- **Derived Conclusion**: JWT security requires pre-configured algorithm selection rather than trusting the JWT header's alg field; the "none" algorithm must be rejected; algorithm confusion attacks exploit implementations that use the JWT header to select verification keys

### [KDC-004] API Rate Limiting Algorithm Comparison

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-003
- **Source Anchor**: `tasks/20260401-concurrent-05/acquire/raw-sources/src-008-rate-limiting-strategies.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The token bucket algorithm uses a bucket that holds tokens. Tokens are added at a constant rate. Each request consumes one token. If the bucket is empty, the request is rejected or queued."
- **Derived Conclusion**: Five rate limiting algorithms serve different needs: token bucket allows controlled bursts with smooth long-term rate; leaky bucket enforces constant output rate; fixed window is simple but vulnerable to boundary bursts; sliding window log provides highest accuracy at higher memory cost; sliding window counter provides a practical hybrid used in production systems

### [KDC-005] OWASP Input Validation: Allowlist vs Denylist

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-003
- **Source Anchor**: `tasks/20260401-concurrent-05/acquire/raw-sources/src-007-owasp-input-validation.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Allowlist (Positive) Validation:\n- Define what IS allowed — reject everything else\n- More secure than denylist because new attack vectors are automatically blocked\n- Example: for a username field, allow only alphanumeric characters [a-zA-Z0-9]\n- RECOMMENDED approach per OWASP"
- **Derived Conclusion**: OWASP recommends allowlist (positive) validation as the primary input validation strategy because it automatically blocks new attack vectors; denylist validation is weaker and should only serve as secondary defense since new attack patterns may not be in the denylist

## Potential Capability Impact
- No capability upgrades required; web-research capability label was classification-only (no cap-*.md definition exists)

## Next Promotion Target
- KDC-001: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-oauth-pkce.md`
- KDC-002: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-jwt-signing-tradeoffs.md`
- KDC-003: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-jwt-algorithm-verification.md`
- KDC-004: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-rate-limiting-algorithms.md`
- KDC-005: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-05-owasp-allowlist-validation.md`

## Notes
- none
