# API Security Best Practices — Consolidated Summary

## Task ID
- 20260401-concurrent-05

## Overview
This document consolidates findings from three knowledge acquisition events covering API security best practices across three domains: OAuth 2.0/OIDC authorization, JWT security, and rate limiting/input validation.

## Domain 1: OAuth 2.0 and OpenID Connect

### Authorization Flows
| Flow | Use Case | Security Level |
|------|----------|---------------|
| Authorization Code + PKCE | Web apps, mobile apps, SPAs | Highest — recommended for all clients |
| Client Credentials | Machine-to-machine | High — no user interaction |
| Resource Owner Password | Legacy, high-trust apps | Low — credentials exposed to client |
| Implicit | Deprecated | Not recommended — tokens in URL fragment |

### Token Types
- **Access Token**: short-lived credential for API access; scoped to specific permissions
- **Refresh Token**: long-lived credential for obtaining new access tokens; bound to issuing client
- **ID Token (OIDC)**: JWT containing identity claims (iss, sub, aud, exp, iat); authenticates the user

### PKCE (RFC 7636)
- Protects authorization code flow from interception attacks
- Client generates random `code_verifier`, sends SHA-256 hash as `code_challenge`
- Authorization server verifies the verifier matches the challenge at token exchange
- Now recommended for ALL OAuth clients (OAuth 2.1 makes it mandatory)

### Sources
- RFC 6749 (OAuth 2.0 Authorization Framework)
- RFC 7636 (PKCE)
- OpenID Connect Core 1.0

## Domain 2: JWT Security

### Signing Algorithm Selection
| Algorithm | Type | Use Case | Non-Repudiation |
|-----------|------|----------|----------------|
| HS256 | Symmetric | Single-service, shared secret | No |
| RS256 | Asymmetric | Distributed systems, microservices | Yes |
| ES256 | Asymmetric | Mobile/constrained environments | Yes |

### Mandatory Claim Validation
1. `iss` — must match expected issuer
2. `aud` — must contain the verifier's client ID
3. `exp` — must reject expired tokens (small clock skew leeway acceptable)
4. `nbf` — must reject tokens before their validity period
5. `iat` — used to determine token age

### Token Revocation Strategies
1. **Short-lived tokens** (5-15 min): reduces revocation need; simplest approach
2. **Token blocklist**: server-side list of revoked jti values; requires state management
3. **Token introspection** (RFC 7662): real-time active check; adds per-request latency
4. **Refresh token rotation**: issue new refresh token per renewal; revoke old immediately

### Critical Security Practices (RFC 8725)
- Never accept the "none" algorithm
- Use pre-configured algorithm based on key ID, not the JWT header's alg field
- Use "typ" header parameter to prevent token substitution attacks
- Encrypt sensitive claims with JWE
- Use jti claim with replay detection for sensitive operations

### Sources
- RFC 7519 (JSON Web Token)
- RFC 7515 (JSON Web Signature)
- RFC 8725 (JWT Best Current Practices)

## Domain 3: Rate Limiting and Input Validation

### Rate Limiting Algorithms
| Algorithm | Burst Tolerance | Accuracy | Memory | Boundary Issue |
|-----------|----------------|----------|--------|---------------|
| Token Bucket | Yes (up to capacity) | Good | Low | No |
| Leaky Bucket | No | Good | Low | No |
| Fixed Window | No | Low | Low | Yes — boundary burst |
| Sliding Window Log | No | Highest | High | No |
| Sliding Window Counter | Minimal | High | Medium | Minimal |

### Rate Limiting Implementation
- Use HTTP 429 (RFC 6585) for rate-limited responses
- Include `Retry-After`, `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset` headers
- Apply per API key, per user, per IP, or per endpoint granularity
- Layer: API Gateway (coarse) + Application (fine-grained) + Database (connection limits)

### Input Validation (OWASP)
- **Allowlist validation** (recommended): define what IS allowed; reject everything else
- **Denylist validation** (secondary only): define what is NOT allowed
- **Server-side validation is mandatory** — client-side is UX only, not security
- Validate: Content-Type, request body schema, URL params, HTTP method, body size, data types
- Use **parameterized queries** for SQL injection prevention
- Apply **context-appropriate output encoding** (HTML, JavaScript, URL, CSS)

### Sources
- OWASP Input Validation Cheat Sheet
- Google Cloud Architecture Center — Rate Limiting Strategies
- RFC 6585 (HTTP 429 Status Code)
