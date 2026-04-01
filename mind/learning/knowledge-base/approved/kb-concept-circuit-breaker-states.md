# Knowledge Base Entry

## Type
- concept

## Summary
- The circuit breaker pattern implements a three-state proxy (Closed, Open, Half-Open) that monitors failure counts within a time window and transitions between states based on configurable thresholds. In Closed state, failures are counted; when the threshold is exceeded, the circuit opens and starts a timeout timer; when the timer expires, a limited number of trial requests are permitted in Half-Open state to test recovery.

## Source Lineage
- Task ID: 20260401-midstep-acq-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-midstep-acq-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-midstep-acq-test-circuit-breaker-states.md
- Review File: mind/learning/reviews/review-20260401-midstep-acq-test-circuit-breaker-states.md
- Original Source Anchor: tasks/20260401-midstep-acq-test/acquire/raw-sources/src-001-microsoft-circuit-breaker.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker

## Key Evidence
> "You can implement the proxy as a state machine that includes the following states. These states mimic the functionality of an electrical circuit breaker: Closed: The request from the application is routed to the operation. The proxy maintains a count of the number of recent failures. If the call to the operation is unsuccessful, the proxy increments this count. If the number of recent failures exceeds a specified threshold within a given time period, the proxy is placed into the Open state and starts a time-out timer. When the timer expires, the proxy is placed into the Half-Open state."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-midstep-acq-test-circuit-breaker-states.md

## Applicability
- Applies to: microservice architectures requiring fault tolerance against downstream service failures; any distributed system using synchronous remote procedure calls between services
- Does not apply to: in-process function calls; message-driven/event-driven architectures where built-in failure isolation is sufficient; local resource access patterns

## Notes
- Grounded in Microsoft Azure Architecture Center documentation; independently verified via ACQ-001
- Pattern originally popularized by Michael Nygard in "Release It!" (2018)
