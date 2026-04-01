# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-12

## Summary
- Envoy's sidecar proxy pattern deploys one Envoy instance alongside each application server, forming a transparent communication mesh where applications interact only with localhost, unaware of network topology.

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-12.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-12/acquire/raw-sources/src-001-envoy-what-is-envoy.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-12/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Out of process architecture: Envoy is a self contained process that is designed to run alongside every application server. All of the Envoys form a transparent communication mesh in which each application sends and receives messages to and from localhost and is unaware of the network topology."

## Candidate Conclusion
- Envoy's sidecar proxy pattern deploys one Envoy instance alongside each application server, forming a transparent communication mesh. Applications interact only with localhost, remaining unaware of network topology. This out-of-process architecture decouples network concerns from application code, enabling language-agnostic service mesh deployment and independent proxy upgrades.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-12-envoy-sidecar-architecture.md

## Notes
- none
