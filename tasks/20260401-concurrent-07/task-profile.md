# Task Profile

## Task ID
- 20260401-concurrent-07

## Task Type
- mixed

## Goal
- Build a health check endpoint for a microservice and learn health check patterns through knowledge acquisition. The deliverable is a health check endpoint design document. The learning component covers liveness vs readiness probes, and deep vs shallow health checks via ACQ.

## Inputs
- tasks/20260401-concurrent-07/learning-read.md
- mind/soul/core.md
- mind/learning/knowledge-base/approved/kb-concept-circuit-breaker-states.md (relevant: failure state detection)

## Success Criteria
- A health check endpoint design document exists in _output/health-check-endpoint.md
- ACQ triggered and completed for health check patterns (liveness vs readiness, deep vs shallow)
- Knowledge promoted through terminal Learning pipeline
- Task reaches completed/completed state

## Complexity
- medium

## Risk
- low

## Capability Needs
- Distributed systems design (health check endpoint architecture)
- Resilience pattern knowledge (liveness/readiness probes, dependency health)
- API design (endpoint specification)

## Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; APPEND only to INDEX.md
- Soul constraints: explicit failure handling over silent degradation; operational simplicity over architectural elegance
- Health check design must account for both shallow (liveness) and deep (readiness) patterns

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — health check patterns are well-established and do not require cross-domain inference

## Notes
- Step 1 requires ACQ for health check patterns (liveness vs readiness probes, deep vs shallow checks)
- Step 2 produces the deliverable using acquired knowledge
