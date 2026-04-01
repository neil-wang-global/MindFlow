# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-07

## Summary
- Kubernetes defines three probe types with distinct failure semantics: liveness (restart on failure), readiness (remove from endpoints without restart), and startup (gate liveness/readiness during initialization)

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-07.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-07/acquire/raw-sources/src-001-kubernetes-probes.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-07/acquire/verification-report.md §ACQ-001
  - Verification Status: passed (confirmed in Passed Sources for ACQ-001)

## Original Excerpt
> "Liveness probe: tells kubelet whether to restart a container. Use it to detect and recover from unrecoverable app failures (deadlocks, hung main thread). Readiness probe: tells kubelet (and Services) whether a container is ready to receive traffic. When not ready the Pod is removed from service endpoints. Startup probe: tells kubelet whether the application in the container has finished starting. If a startup probe is configured, the kubelet disables liveness and readiness probes until the startup probe succeeds — useful for slow-starting apps so they aren't killed early."

## Candidate Conclusion
- Kubernetes defines three distinct probe types with different failure semantics: liveness probes trigger container restart on failure (for deadlock/hang recovery), readiness probes remove pods from service endpoints without restart (for traffic routing control), and startup probes gate liveness/readiness activation during initialization (preventing premature kills of slow-starting containers). This three-probe model maps directly to shallow checks (liveness), deep checks (readiness), and initialization checks (startup).

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-07-health-probe-types.md

## Notes
- Source: official Kubernetes documentation (kubernetes.io)
