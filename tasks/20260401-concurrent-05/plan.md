# Plan

## Task ID
- 20260401-concurrent-05

## Goal
- Acquire verified knowledge about API security best practices across three domains (OAuth 2.0/OIDC, JWT security, rate limiting/input validation) and produce approved knowledge artifacts grounded in primary sources.

## Runtime State
- the fixed runtime state file is: `tasks/20260401-concurrent-05/state.md`

## Global Constraints
- Knowledge Source Prohibition: search summaries, snippets, and AI-generated overviews are not valid knowledge sources
- Fixed Promotion Path: task-learning/ -> drafts/ -> reviews/ -> knowledge-base/approved/
- Independent subagent review required for all knowledge promotions
- Soul constraints: evidence-based design, primary source preference, quantitative benchmarks
- Default final result directory: `tasks/20260401-concurrent-05/_output/`
- Publish-back to `sources/` is not needed for this learning task

### Step 1
- Name: OAuth 2.0 and OpenID Connect
- Goal: Acquire and verify knowledge about OAuth 2.0 authorization flows (authorization code, implicit, client credentials, device code), token types (access, refresh, ID), and PKCE extension for public clients
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-05/cache/` — ACQ artifacts (search-log, raw-sources, verification-report) scoped to Step 1 ACQ event
- Constraints: `mind/soul/core.md` (primary source preference, evidence-based design)
- Inputs: task goal, RFC 6749 (OAuth 2.0), RFC 7636 (PKCE), OpenID Connect Core specification
- Outputs: `tasks/20260401-concurrent-05/cache/acq-001-oauth-summary.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event triggered; search-log.md records at least 1 query; at least 1 source fetched and verified; summary artifact exists in cache/
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) to search for OAuth 2.0 authorization framework content. Target RFC 6749 or equivalent primary specification. Search for PKCE (RFC 7636) content. Verify fetched sources contain substantive technical content about authorization flows and token types. Record all ACQ events in state.md Learning(Acquire) Log.

### Step 2
- Name: JWT Security
- Goal: Acquire and verify knowledge about JWT signing algorithms (RS256 vs HS256 tradeoffs), claim validation requirements (iss, aud, exp, nbf, iat), and token revocation strategies (blocklist, short-lived tokens, token introspection RFC 7009)
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-05/cache/` — ACQ artifacts scoped to Step 2 ACQ event
- Constraints: `mind/soul/core.md` (primary source preference, evidence-based design)
- Inputs: Step 1 output (OAuth context), RFC 7519 (JWT), RFC 7009 (Token Revocation)
- Outputs: `tasks/20260401-concurrent-05/cache/acq-002-jwt-summary.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: ACQ event triggered; search-log.md records at least 1 query; at least 1 source fetched and verified; summary artifact exists in cache/
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) to search for JWT security best practices content. Target RFC 7519 or equivalent primary specification. Search for content on signing algorithm security tradeoffs and claim validation requirements. Verify fetched sources contain substantive technical content about JWT security. Record all ACQ events in state.md Learning(Acquire) Log.

### Step 3
- Name: Rate Limiting and Input Validation
- Goal: Acquire and verify knowledge about API rate limiting/throttling strategies (token bucket, sliding window, fixed window, per-client policies) and OWASP input validation guidelines (allowlist vs denylist, parameterized queries, encoding output)
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-05/cache/` — ACQ artifacts scoped to Step 3 ACQ event
- Constraints: `mind/soul/core.md` (primary source preference, evidence-based design); existing KB: `kb-concept-token-bucket-mechanism.md`
- Inputs: OWASP Input Validation Cheat Sheet, OWASP API Security Top 10
- Outputs: `tasks/20260401-concurrent-05/_output/api-security-summary.md` (final consolidated output), `tasks/20260401-concurrent-05/cache/acq-003-ratelimit-validation-summary.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 2
- Completion Criteria: ACQ event triggered; search-log.md records at least 1 query; at least 1 source fetched and verified; summary artifact exists in cache/; consolidated output exists in _output/
- Failure Policy: retry
- Instructions: Execute Learning(Acquire) to search for OWASP input validation and API rate limiting content. Target OWASP Input Validation Cheat Sheet or equivalent primary guideline. Search for content on rate limiting strategies beyond basic token bucket (sliding window, per-client policies). Build on existing token bucket knowledge from approved KB. Verify fetched sources contain substantive technical content. Record all ACQ events in state.md Learning(Acquire) Log. Produce a consolidated API security summary in _output/.

## Handoffs
- Step 1 -> Step 2: OAuth 2.0 context from Step 1 informs JWT understanding in Step 2 (JWT is the token format used in OAuth flows)
- Step 2 -> Step 3: Authentication/authorization context from Steps 1-2 informs rate limiting and input validation in Step 3 (security layers build on each other)
- Step 3 produces the consolidated output in `_output/` incorporating all three Steps

## Completion Check
- All 3 Steps completed
- At least 3 ACQ events triggered (one per Step)
- `tasks/20260401-concurrent-05/_output/api-security-summary.md` exists with content covering all three domains
- All ACQ events recorded in `state.md §Learning(Acquire) Log`
