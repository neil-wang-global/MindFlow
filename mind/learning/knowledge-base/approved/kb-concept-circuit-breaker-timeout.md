# Knowledge Base Entry

## Type
- concept

## Summary
- The circuit breaker timeout for the Open-to-Half-Open transition should not be static. An increasing (exponential backoff) timeout strategy is recommended: start with a short timeout (seconds), and if recovery is not detected after the Half-Open trial, increase the timeout progressively up to a configurable maximum. This prevents both premature probing of unrecovered services and unnecessarily long waits after recovery.

## Source Lineage
- Task ID: 20260401-midstep-acq-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-midstep-acq-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-midstep-acq-test-circuit-breaker-timeout.md
- Review File: mind/learning/reviews/review-20260401-midstep-acq-test-circuit-breaker-timeout.md
- Original Source Anchor: tasks/20260401-midstep-acq-test/acquire/raw-sources/src-003-microsoft-half-open-timeout.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker

## Key Evidence
> "You can customize and adapt this pattern to different types of failures. For example, you can apply an increasing time-out timer to a circuit breaker. You can place the circuit breaker in the Open state for a few seconds initially. If the failure isn't resolved, increase the time-out to a few minutes and adjust accordingly."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-midstep-acq-test-circuit-breaker-timeout.md

## Applicability
- Applies to: circuit breaker implementations where downstream service recovery time is unpredictable or variable; systems where repeated probing of unrecovered services would cause additional load
- Does not apply to: circuit breakers with health-check-based transitions (where the probe is active rather than timer-based); systems where the downstream service has a well-known, fixed recovery time

## Notes
- Grounded in Microsoft Azure Architecture Center documentation; independently verified via ACQ-002
- Three timeout strategies exist (fixed, exponential backoff, health-check based); this entry covers the exponential backoff approach specifically
