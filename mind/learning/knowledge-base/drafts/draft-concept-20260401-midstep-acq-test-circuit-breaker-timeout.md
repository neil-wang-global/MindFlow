# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-midstep-acq-test

## Summary
- Circuit breaker timeout for the Open-to-Half-Open transition should use an increasing (exponential backoff) strategy rather than a static timeout

## From Task Learning
- mind/learning/task-learning/tl-20260401-midstep-acq-test.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-midstep-acq-test/acquire/raw-sources/src-003-microsoft-half-open-timeout.md
  - ACQ Event: ACQ-002
  - Verification Report: tasks/20260401-midstep-acq-test/acquire/verification-report.md §ACQ-002
  - Verification Status: passed

## Original Excerpt
> "You can customize and adapt this pattern to different types of failures. For example, you can apply an increasing time-out timer to a circuit breaker. You can place the circuit breaker in the Open state for a few seconds initially. If the failure isn't resolved, increase the time-out to a few minutes and adjust accordingly."

## Candidate Conclusion
- The circuit breaker timeout for the Open-to-Half-Open transition should not be static. An increasing (exponential backoff) timeout strategy is recommended: start with a short timeout (seconds), and if recovery is not detected after the Half-Open trial, increase the timeout progressively up to a configurable maximum. This prevents both premature probing of unrecovered services and unnecessarily long waits after recovery.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-midstep-acq-test-circuit-breaker-timeout.md

## Notes
- Grounded in Microsoft Azure Architecture Center technical documentation (src-003), verified via ACQ-002
