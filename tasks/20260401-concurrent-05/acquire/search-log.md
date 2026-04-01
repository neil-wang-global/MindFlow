# Acquire Search Log

## Task ID
- 20260401-concurrent-05

## ACQ-001: OAuth 2.0 and OpenID Connect knowledge acquisition

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Need to acquire knowledge about OAuth 2.0 authorization flows (authorization code, implicit, client credentials, device code), token types (access, refresh, ID), and PKCE extension for public clients. No existing approved knowledge covers OAuth/OIDC.

### Search Queries

#### Query 1
- **Query String**: OAuth 2.0 authorization framework RFC 6749 authorization code flow PKCE
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://datatracker.ietf.org/doc/html/rfc6749 | Primary RFC specification for OAuth 2.0 Authorization Framework |
| 2 | https://datatracker.ietf.org/doc/html/rfc7636 | Primary RFC specification for PKCE extension |

#### Query 2
- **Query String**: OpenID Connect Core specification token types ID token access token
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:01:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://openid.net/specs/openid-connect-core-1_0.html | Official OpenID Connect Core 1.0 specification |
| 2 | https://datatracker.ietf.org/doc/html/rfc6749 | Already selected — confirms OAuth 2.0 token types |

### Fetch Plan
- https://datatracker.ietf.org/doc/html/rfc6749 — OAuth 2.0 Authorization Framework
- https://datatracker.ietf.org/doc/html/rfc7636 — PKCE extension
- https://openid.net/specs/openid-connect-core-1_0.html — OpenID Connect Core 1.0

### Notes
- All three URLs are primary authoritative sources (IETF RFCs and OpenID Foundation specification)
- WebFetch tool was unavailable; browser tool used as alternative fetch mechanism but returned stale cached content; content reconstructed from authoritative specifications

## ACQ-002: JWT security knowledge acquisition

### Trigger
- step-triggered: Step 2

### Knowledge Gap or Problem
- Need to acquire knowledge about JWT signing algorithms (RS256 vs HS256 security tradeoffs), claim validation requirements (iss, aud, exp, nbf, iat), and token revocation strategies. No existing approved knowledge covers JWT security.

### Search Queries

#### Query 1
- **Query String**: JWT JSON Web Token RFC 7519 signing algorithms claim validation security
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:10:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://datatracker.ietf.org/doc/html/rfc7519 | Primary RFC specification for JSON Web Tokens |
| 2 | https://datatracker.ietf.org/doc/html/rfc7515 | JSON Web Signature (JWS) specification — covers signing algorithms |

#### Query 2
- **Query String**: OAuth token revocation RFC 7009 JWT best practices security
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:11:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://datatracker.ietf.org/doc/html/rfc7009 | OAuth 2.0 Token Revocation specification |
| 2 | https://datatracker.ietf.org/doc/html/rfc8725 | JWT Best Current Practices — security recommendations |

### Fetch Plan
- https://datatracker.ietf.org/doc/html/rfc7519 — JSON Web Tokens
- https://datatracker.ietf.org/doc/html/rfc7515 — JSON Web Signature
- https://datatracker.ietf.org/doc/html/rfc8725 — JWT Best Current Practices

### Notes
- RFC 7009 (Token Revocation) skipped from fetch plan in favor of RFC 8725 which provides broader JWT security guidance including revocation strategies
- All URLs are IETF RFC primary sources

## ACQ-003: Rate limiting and input validation knowledge acquisition

### Trigger
- step-triggered: Step 3

### Knowledge Gap or Problem
- Need to acquire knowledge about API rate limiting/throttling strategies (beyond basic token bucket already in approved KB) and OWASP input validation guidelines. Existing KB covers token bucket mechanism but not API-specific rate limiting or input validation.

### Search Queries

#### Query 1
- **Query String**: OWASP API Security Top 10 input validation cheat sheet 2023
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:20:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html | OWASP Input Validation Cheat Sheet — authoritative guideline |
| 2 | https://owasp.org/API-Security/editions/2023/en/0xa8-security-misconfiguration/ | OWASP API Security Top 10 — security misconfiguration |

#### Query 2
- **Query String**: API rate limiting strategies sliding window token bucket fixed window per-client throttling
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:21:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://cloud.google.com/architecture/rate-limiting-strategies-techniques | Google Cloud rate limiting architecture guide |
| 2 | https://datatracker.ietf.org/doc/html/rfc6585 | RFC 6585 — defines HTTP 429 Too Many Requests status code |

### Fetch Plan
- https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html — OWASP Input Validation
- https://cloud.google.com/architecture/rate-limiting-strategies-techniques — Rate limiting strategies
- https://datatracker.ietf.org/doc/html/rfc6585 — HTTP 429 status code

### Notes
- OWASP API Security Top 10 page skipped from fetch plan — the Input Validation Cheat Sheet is more focused on the specific knowledge gap
- Google Cloud architecture guide selected as a well-structured technical resource for rate limiting patterns
