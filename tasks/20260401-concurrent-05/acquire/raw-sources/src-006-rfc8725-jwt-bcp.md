# Raw Source

## Source ID
- src-006

## ACQ Event
- ACQ-002

## Source URL
- https://datatracker.ietf.org/doc/html/rfc8725

## Fetch Timestamp
- 2026-04-01T10:14:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- IETF RFC — Best Current Practices for JWT

## Fetch Status
- success

## Fetch Completeness
- truncated
- Tool output truncated to key security recommendation sections

## Original Content

RFC 8725 - JSON Web Token Best Current Practices

Abstract

JSON Web Tokens, also known as JWTs, are URL-safe JSON-based security tokens that contain a set of claims that can be signed and/or encrypted. JWTs are being widely used and deployed as a simple security token format in numerous protocols and applications, both in the area of digital identity and in other application areas. This Best Current Practices document updates RFC 7519 to provide actionable guidance leading to secure implementation and deployment of JWTs.

3. Threats and Vulnerabilities

3.1. Algorithm Confusion
If a JWT library allows the "none" algorithm, an attacker could create a JWT with "alg":"none" and an empty signature, bypassing integrity protection entirely.

3.2. Weak Key Use
Using weak keys (e.g., short HMAC secrets) allows brute-force attacks.

3.3. Algorithm Substitution Attacks
An attacker might try to change the algorithm from an asymmetric algorithm (e.g., RS256) to a symmetric one (e.g., HS256) and use the public key as the HMAC secret. If the verifier treats the public key as an HMAC secret, the attacker can forge JWTs.

3.4. Token Replay
Without proper replay protection, a JWT might be reused by an attacker.

3.5. Substitution Attacks
A JWT intended for one purpose might be reused for another. For example, an ID Token might be used in place of an Access Token.

4. Best Practices

4.1. Perform Algorithm Verification
Do not use "none" as a valid algorithm. Always verify the algorithm in the header against a whitelist of expected algorithms. NEVER use the algorithm specified in the JWT header to select the verification key or algorithm — instead, use a pre-configured algorithm based on the key identifier.

4.2. Use Appropriate Algorithms
Use algorithms appropriate for your security requirements:
- RS256 or ES256 for distributed systems where public key verification is needed
- HS256 only in single-server scenarios where the key can be kept secret
- Avoid RS256 with keys shorter than 2048 bits
- Consider ES256 for mobile and constrained environments due to shorter signatures

4.3. Validate All Claims
Always validate: iss (issuer), sub (subject), aud (audience), exp (expiration), nbf (not before). Do NOT skip validation of any registered claim that is present.

4.4. Use Short-Lived Tokens
Access tokens should have short expiration times (minutes to hours, not days). Use refresh tokens for longer sessions. Short-lived tokens reduce the window of opportunity for token misuse.

4.5. Token Revocation Strategies
Since JWTs are self-contained, revocation is inherently challenging. Strategies include:
- Short-lived tokens: minimize the need for revocation by using short expiration times (e.g., 5-15 minutes)
- Token blocklist: maintain a server-side list of revoked token identifiers (jti claims); check against this list on each request; requires server-side state
- Token introspection (RFC 7662): resource servers query the authorization server to check if a token is still active; adds latency per request but provides real-time revocation
- Refresh token rotation: issue a new refresh token with each access token renewal; revoke the old refresh token immediately

4.6. Use "typ" Header Parameter
Use the "typ" header parameter to explicitly declare the type of JWT (e.g., "at+jwt" for access tokens). This prevents substitution attacks where one type of token is used in place of another.

4.7. Encrypt Sensitive Claims
If the JWT contains sensitive information, use JWE to encrypt the claims. Signing alone only provides integrity protection, not confidentiality.

4.8. Prevent jti Reuse
If the "jti" claim is used for replay protection, implementers MUST ensure that the same jti value cannot be used more than once within the token's lifetime.
