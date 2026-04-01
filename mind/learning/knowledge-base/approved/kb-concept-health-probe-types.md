# Knowledge Base Entry

## Type
- concept

## Summary
- Kubernetes defines three distinct probe types with different failure semantics: liveness probes trigger container restart on failure (for deadlock/hang recovery), readiness probes remove pods from service endpoints without restart (for traffic routing control), and startup probes gate liveness/readiness activation during initialization (preventing premature kills of slow-starting containers). This three-probe model maps directly to shallow checks (liveness), deep checks (readiness), and initialization checks (startup).

## Source Lineage
- Task ID: 20260401-concurrent-07
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-07.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-07-health-probe-types.md
- Review File: mind/learning/reviews/review-20260401-concurrent-07-health-probe-types.md
- Original Source Anchor: tasks/20260401-concurrent-07/acquire/raw-sources/src-001-kubernetes-probes.md
- Original Source URL: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

## Key Evidence
> "Liveness probe: tells kubelet whether to restart a container. Use it to detect and recover from unrecoverable app failures (deadlocks, hung main thread). Readiness probe: tells kubelet (and Services) whether a container is ready to receive traffic. When not ready the Pod is removed from service endpoints. Startup probe: tells kubelet whether the application in the container has finished starting. If a startup probe is configured, the kubelet disables liveness and readiness probes until the startup probe succeeds — useful for slow-starting apps so they aren't killed early."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-07-health-probe-types.md

## Applicability
- Applies to: any Kubernetes-deployed microservice requiring health monitoring; container orchestration environments supporting probe-based health detection; service mesh configurations that use probe endpoints for traffic routing decisions
- Does not apply to: non-containerized deployments without orchestration-level health detection; monolithic applications with single-process health where restart is not a viable recovery strategy; serverless/function-as-a-service environments where the platform manages lifecycle entirely

## Notes
- Grounded in official Kubernetes documentation; independently verified via ACQ-001
- The shallow/deep/initialization mapping is a derived classification that aligns probe types with health check depth categories
