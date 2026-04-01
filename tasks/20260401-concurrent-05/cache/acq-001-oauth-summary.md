# ACQ-001 OAuth 2.0/OIDC Summary

## Sources Used
- src-001 (RFC 6749 — OAuth 2.0 Authorization Framework)
- src-002 (RFC 7636 — PKCE)
- src-003 (OpenID Connect Core 1.0)

## Key Findings

### OAuth 2.0 Authorization Flows
- Authorization Code Grant: most secure flow; uses back-channel token exchange; optimized for confidential clients
- Implicit Grant: deprecated per Security BCP; tokens exposed in URL fragment
- Client Credentials Grant: for machine-to-machine; no user interaction
- Resource Owner Password Credentials: requires high trust; limited use cases

### Token Types
- Access Token: credential for accessing protected resources; scoped and time-limited
- Refresh Token: credential for obtaining new access tokens; bound to client
- ID Token (OIDC): JWT containing authentication claims (iss, sub, aud, exp, iat, nonce)

### PKCE Extension
- Mitigates authorization code interception attacks for public clients
- Uses code_verifier (random secret) and code_challenge (transformed value)
- S256 transformation (SHA-256) is mandatory to implement; plain only as fallback
- Now recommended for ALL OAuth clients, not just public clients
