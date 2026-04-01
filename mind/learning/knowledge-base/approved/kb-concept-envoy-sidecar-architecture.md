# Knowledge Base Entry

## Type
- concept

## Summary
- Envoy's sidecar proxy pattern deploys one Envoy instance alongside each application server, forming a transparent communication mesh. Applications interact only with localhost, remaining unaware of network topology. This out-of-process architecture decouples network concerns from application code, enabling language-agnostic service mesh deployment and independent proxy upgrades.

## Source Lineage
- Task ID: 20260401-concurrent-12
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-12.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-12-envoy-sidecar-architecture.md
- Review File: mind/learning/reviews/review-20260401-concurrent-12-envoy-sidecar-architecture.md
- Original Source Anchor: tasks/20260401-concurrent-12/acquire/raw-sources/src-001-envoy-what-is-envoy.md
- Original Source URL: https://www.envoyproxy.io/docs/envoy/latest/intro/what_is_envoy

## Key Evidence
> "Out of process architecture: Envoy is a self contained process that is designed to run alongside every application server. All of the Envoys form a transparent communication mesh in which each application sends and receives messages to and from localhost and is unaware of the network topology."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-12-envoy-sidecar-architecture.md

## Applicability
- Applies to: any service mesh deployment using Envoy proxies; microservice architectures requiring language-agnostic service-to-service communication; environments where independent proxy upgrades are needed without application code changes
- Does not apply to: monolithic applications without service-to-service communication; in-process library-based service mesh implementations (e.g., Linkerd's Rust-based ultralight proxy runs differently); environments where the overhead of a sidecar process per service instance is unacceptable

## Notes
- Grounded in official Envoy project documentation (envoyproxy.io)
