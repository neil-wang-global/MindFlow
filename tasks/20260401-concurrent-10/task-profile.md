# Task Profile

## Task ID
- 20260401-concurrent-10

## Task Type
- mixed

## Goal
- Design a dead letter queue (DLQ) handler for distributed message processing systems. The handler must address poison message handling, DLQ monitoring, automatic retry policies, and message forensics. Additionally, acquire DLQ best practices through external knowledge acquisition to inform the design.

## Inputs
- Soul constraints (mind/soul/core.md): distributed systems engineer focused on resilience patterns
- Approved knowledge: circuit breaker states pattern (kb-concept-circuit-breaker-states.md)
- Task statement specifying DLQ handler design with learning acquisition

## Success Criteria
- DLQ best practices acquired via Learning(Acquire) with verified sources
- Design document produced at _output/dlq-handler-design.md covering: poison message handling, DLQ monitoring, automatic retry policies, message forensics
- Knowledge promoted through terminal Learning pipeline
- Task reaches completed/completed state

## Complexity
- medium

## Risk
- medium

## Capability Needs
- distributed systems design
- message queue architecture
- resilience pattern design
- failure handling and recovery patterns

## Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Soul taboos: never ignore failure modes, never assume network reliability, never skip monitoring
- Design must follow evidence-based approach per Soul values
- DLQ handler must degrade gracefully under load or partial failure

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — the task domain (DLQ patterns) is well-established and does not require cross-domain reasoning

## Notes
- This is a mixed task combining delivery (DLQ handler design) with learning (DLQ best practices acquisition)
- Step 1 will require Learning(Acquire) for DLQ research
- Step 2 will produce the design deliverable
