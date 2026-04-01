# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-08

## Summary
- ECS trace fields (trace.id, span.id, transaction.id) provide distributed log correlation aligned with W3C Trace Context and OpenTelemetry

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-08.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-08/acquire/raw-sources/src-002-ecs-github-readme.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-08/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "For distributed tracing and log correlation:\n- `trace.id`: Links logs across service boundaries. Same value propagated through entire request chain.\n- `span.id`: Identifies the specific operation within a trace.\n- `transaction.id`: Groups related operations into a business transaction.\n\nThese fields align with OpenTelemetry trace context (W3C Trace Context propagation)."

## Candidate Conclusion
- ECS trace fields (trace.id, span.id, transaction.id) provide the correlation mechanism for distributed log aggregation. The trace.id is propagated unchanged through the entire request chain while span.id varies per operation. Alignment with W3C Trace Context and OpenTelemetry means the same correlation IDs work across both logging and tracing systems.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-08-correlation-id-propagation.md

## Notes
- none
