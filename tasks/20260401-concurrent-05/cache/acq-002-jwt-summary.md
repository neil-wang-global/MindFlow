# ACQ-002 JWT Security Summary

## Sources Used
- src-004 (RFC 7519 — JSON Web Token)
- src-005 (RFC 7515 — JSON Web Signature)
- src-006 (RFC 8725 — JWT Best Current Practices)

## Key Findings

### Signing Algorithms
- HS256 (HMAC-SHA256): symmetric; same key for signing and verification; suitable for single-service; faster but no non-repudiation
- RS256 (RSA-SHA256): asymmetric; private key signs, public key verifies; suitable for distributed systems; provides non-repudiation
- ES256 (ECDSA-P256-SHA256): asymmetric; shorter keys, faster computation; recommended for constrained environments

### Claim Validation Requirements
- iss (issuer): MUST match expected issuer identifier
- sub (subject): identifies the principal
- aud (audience): MUST contain the client's identifier; reject if not present
- exp (expiration): MUST reject tokens past expiration; small clock skew leeway acceptable
- nbf (not before): MUST reject tokens before this time
- iat (issued at): determines token age
- jti (JWT ID): unique identifier for replay protection

### Token Revocation Strategies
- Short-lived tokens (5-15 minutes): minimizes revocation need
- Token blocklist: server-side revoked jti list; requires state
- Token introspection (RFC 7662): real-time active check; adds latency
- Refresh token rotation: new refresh token per renewal; immediate old token revocation

### Critical Security Practices (RFC 8725)
- Never accept "none" algorithm; always whitelist acceptable algorithms
- Prevent algorithm confusion: never use JWT header alg to select verification method
- Use "typ" header to prevent token substitution attacks
- Validate all registered claims present in the token
