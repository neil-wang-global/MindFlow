# Acquire Search Log

## Task ID
- 20260401-knowledge-gap-retry-test

## ACQ-001: adaptive concurrency control knowledge gap retry

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Open knowledge gap from task 20260331-adaptive-concurrency-research (gap-20260331-retry-target-adaptive-concurrency). Prior attempt exhausted with reason: content mismatch — sources discussed static concurrency, not adaptive. Prior attempted strategy: "broad search for adaptive concurrency patterns." This retry uses targeted queries referencing specific adaptive algorithms and implementations.

### Search Queries

#### Query 1
- **Query String**: "Netflix concurrency-limits library gradient algorithm adaptive concurrency control"
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:15:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://netflixtechblog.medium.com/performance-under-load-3e6fa9a60581 | Netflix Tech Blog post by Daniel Yuan on the concurrency-limits library — primary source from the team that built it |
| 2 | https://github.com/Netflix/concurrency-limits | Official GitHub repository for Netflix's concurrency-limits library — contains implementation details and algorithm documentation |

#### Query 2
- **Query String**: "TCP Vegas congestion avoidance adaptive concurrency limit microservices AIMD"
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:16:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/adaptive_concurrency_filter | Envoy proxy official documentation on adaptive concurrency filter — production-grade implementation of gradient-based concurrency limiting |
| 2 | https://vikas-kumar.medium.com/adaptive-concurrency-control-algorithms-part-1-910c600f6f45 | Technical blog explaining TCP Vegas-inspired adaptive concurrency algorithms in service mesh contexts |

### Fetch Plan
- https://netflixtechblog.medium.com/performance-under-load-3e6fa9a60581 → src-001-netflix-concurrency-limits.md
- https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/adaptive_concurrency_filter → src-002-envoy-adaptive-concurrency.md

### Notes
- Strategy deliberately differs from prior attempt: instead of "broad search for adaptive concurrency patterns" (which returned static concurrency content), used targeted queries naming specific implementations (Netflix concurrency-limits, TCP Vegas adaptation, Envoy adaptive concurrency filter)
- Selected 2 primary sources: Netflix Tech Blog (original authors of the gradient algorithm) and Envoy documentation (production implementation)
- Skipped the GitHub repo (implementation code, not explanatory content) and the medium blog (secondary source; Envoy docs are higher authority)
