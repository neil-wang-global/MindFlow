# Task Profile

## Task ID
- 20260401-concurrent-06

## Task Type
- mixed

## Goal
- Design a retry-with-backoff library API that supports multiple jitter strategies. The library must cover exponential backoff with configurable parameters and incorporate jitter techniques (decorrelated jitter, full jitter, equal jitter) to prevent thundering herd effects. Knowledge about jitter strategies must be acquired via Learning(Acquire) since this is not currently in the approved knowledge base.

## Inputs
- mind/soul/core.md — identity and design values
- tasks/20260401-concurrent-06/learning-read.md — audit record including approved knowledge on exponential backoff (from circuit breaker timeout kb entry)
- mind/learning/knowledge-base/approved/kb-concept-circuit-breaker-timeout.md — exponential backoff pattern evidence

## Success Criteria
- ACQ-001 triggered to acquire knowledge about decorrelated jitter, full jitter, and equal jitter strategies
- _output/ contains a complete retry-backoff library design document
- Knowledge promoted from task-learning through drafts, reviews, to approved knowledge base
- Final state: completed/completed

## Complexity
- medium

## Risk
- medium

## Capability Needs
- distributed systems design — retry patterns, backoff algorithms, jitter strategies
- API design — clean, composable interfaces for retry configuration
- resilience engineering — preventing thundering herd, correlated retry storms

## Constraints
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Soul constraints: resilience over raw performance; evidence-based design; explicit failure handling
- Knowledge source prohibition: search summaries and AI-generated overviews are not valid knowledge sources

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not needed — the task domain (retry patterns, jitter strategies) is well-defined and does not require abductive reasoning or gap-bridging inference

## Notes
- The approved knowledge base already contains an exponential backoff pattern (kb-concept-circuit-breaker-timeout.md) which provides foundational evidence; the ACQ event will focus specifically on jitter strategies which are not yet represented in approved knowledge
