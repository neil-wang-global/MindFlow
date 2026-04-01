# ACQ-003 Rate Limiting and Input Validation Summary

## Sources Used
- src-007 (OWASP Input Validation Cheat Sheet)
- src-008 (Google Cloud — Rate Limiting Strategies)
- src-009 (RFC 6585 — HTTP 429)

## Key Findings

### Rate Limiting Algorithms
- Token Bucket: allows bursts up to capacity; smooth long-term rate; memory efficient
- Leaky Bucket: constant output rate; no bursts; queue buildup risk
- Fixed Window Counter: simple but vulnerable to boundary burst attacks
- Sliding Window Log: most accurate; high memory usage (stores all timestamps)
- Sliding Window Counter: hybrid approach; good accuracy with lower memory; used in production systems

### Per-Client Rate Limiting Strategies
- Per API key, per user, per IP, per endpoint, or global
- HTTP 429 (RFC 6585) is the standard status code for rate-limited responses
- Include Retry-After header and X-RateLimit-* headers for transparency
- Layer rate limiting: API Gateway (coarse) + Application (fine-grained) + Database (connection limits)

### Input Validation Best Practices (OWASP)
- Allowlist (positive) validation: define what IS allowed; reject everything else; RECOMMENDED approach
- Denylist (negative) validation: weaker; only as secondary defense
- Server-side validation is mandatory; client-side is UX only
- Validate Content-Type, request body (schema), URL params, HTTP method, body size
- Use parameterized queries for SQL injection prevention
- Apply context-appropriate output encoding (HTML, JavaScript, URL, CSS contexts)
- Syntactic validation (correct format) + Semantic validation (correct value in context)
