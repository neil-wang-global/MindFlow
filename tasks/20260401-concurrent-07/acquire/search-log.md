# Acquire Search Log

## Task ID
- 20260401-concurrent-07

## ACQ-001: Health check endpoint patterns

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Need to understand health check endpoint patterns: liveness vs readiness probes, deep vs shallow health checks, dependency health aggregation strategies. Existing knowledge covers circuit breaker states but not health check endpoint design patterns specifically.

### Search Queries

#### Query 1
- **Query String**: kubernetes health check endpoint patterns liveness readiness probes deep shallow checks
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/ | Official Kubernetes documentation — canonical primary source for probe types and configuration |
| 2 | https://learn.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring | Microsoft Azure Architecture Center — authoritative pattern documentation for health endpoint monitoring |

#### Query 2
- **Query String**: microservice health check endpoint design liveness readiness dependency health aggregation best practices
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:01:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/ | Same canonical source — confirms relevance across queries |
| 2 | https://learn.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring | Same authoritative pattern source — confirms relevance across queries |

### Fetch Plan
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/ (src-001)
- https://learn.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring (src-002)

### Notes
- Both queries converged on the same two authoritative sources, which is a positive signal for source reliability
- Kubernetes docs provide the definitive specification for liveness/readiness/startup probes
- Microsoft Azure Architecture Center provides the broader health endpoint monitoring pattern including dependency health aggregation
