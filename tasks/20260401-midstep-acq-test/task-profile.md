# Task Profile

## Task ID
- 20260401-midstep-acq-test

## Task Type
- mixed

## Goal
- Design a circuit breaker pattern for microservice communication that handles failure detection, state transitions (closed, open, half-open), and recovery. Produce a formal design document backed by external research acquired during the task. The task delivers both a concrete design artifact and reusable knowledge entries.

## Inputs
- Task statement: "Design a circuit breaker pattern for microservice communication and document the design with external research backing"
- Soul constraints: resilience-focused distributed systems engineer; values evidence-based design, explicit failure handling, primary sources
- Approved knowledge: no relevant entries (existing entries cover token bucket/leaky bucket rate limiting, not circuit breaker patterns)

## Success Criteria
- A complete circuit breaker design document exists in _output/ covering states, transitions, timeouts, and failure thresholds
- External research was acquired and verified for circuit breaker fundamentals and half-open state timeout best practices
- Knowledge candidates are generated from acquired research and promoted through the learning pipeline
- Design decisions are traceable to verified external sources

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Distributed systems design (circuit breaker state machine, failure detection, recovery)
- External research acquisition (web search, source fetching, verification)
- Technical documentation (design document production)

## Constraints
- Must use external sources for circuit breaker pattern knowledge (no relevant approved knowledge exists)
- Design must cover all three circuit breaker states: closed, open, half-open
- All acquired knowledge must pass independent verification before use
- Mixed task: both _output/ deliverable and learning candidates required

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — task scope is well-defined and does not require disambiguation or hypothesis testing

## Notes
- This is a mixed task requiring both a concrete deliverable (design document) and knowledge acquisition (circuit breaker pattern research). Multiple mid-step ACQ events are anticipated: one for fundamental circuit breaker concepts and potentially one for specific half-open state timeout best practices.
