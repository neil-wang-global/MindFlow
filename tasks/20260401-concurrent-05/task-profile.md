# Task Profile

## Task ID
- 20260401-concurrent-05

## Task Type
- learning

## Goal
- Learn API security best practices across three key domains: (1) OAuth 2.0 and OpenID Connect authorization flows, token types, and PKCE extension; (2) JWT security including signing algorithms, claim validation, and token revocation strategies; (3) Rate limiting and input validation including throttling strategies and OWASP input validation guidelines. The objective is to build foundational knowledge grounded in primary sources (RFCs, OWASP standards) that can inform secure API design decisions.

## Inputs
- Task statement: "Learn API security best practices"
- Soul constraints from `mind/soul/core.md`: evidence-based design, primary source preference, quantitative benchmark preference
- Existing approved knowledge: `kb-concept-token-bucket-mechanism.md` (tangentially relevant to rate limiting)

## Success Criteria
- Three distinct learning areas are covered with knowledge acquired from primary sources
- Each area produces at least one verified knowledge artifact
- Knowledge artifacts pass independent subagent review and are promoted to approved knowledge base
- API security concepts are grounded in specific standards (RFC 6749, RFC 7519, OWASP guidelines)

## Complexity
- high

## Risk
- medium

## Capability Needs
- Web research and source acquisition for RFC documents and OWASP guidelines
- Knowledge synthesis from technical specification documents
- Security domain expertise for evaluating authentication/authorization patterns

## Constraints
- Knowledge Source Prohibition: search summaries, snippets, and AI-generated overviews are not valid sources
- Must follow Fixed Promotion Path: task-learning -> drafts -> reviews -> knowledge-base/approved
- Independent subagent review required for all knowledge promotions
- Soul taboo: never skip validation (applies to token validation claims)
- Primary sources preferred over secondary commentary

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — the learning topics are well-defined and do not require cross-domain inference or hypothesis testing

## Notes
- Three-step learning plan maps naturally to the three knowledge domains: OAuth/OIDC, JWT, and rate limiting/input validation
- The existing token bucket KB entry provides a foundation for rate limiting but does not cover API-specific rate limiting patterns
