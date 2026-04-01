# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-25

## Summary
- W3C Trace Context defines a standardized traceparent HTTP header with four fields (version, trace-id, parent-id, trace-flags) for vendor-neutral distributed trace propagation

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-25.md`
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-25/acquire/raw-sources/src-003-w3c-trace-context.md`
  - ACQ Event: ACQ-002
  - Verification Report: `tasks/20260401-concurrent-25/acquire/verification-report.md §ACQ-002`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-002)

## Original Excerpt
> "The traceparent header field identifies the incoming request in a tracing system. It has four fields: version, trace-id, parent-id, and trace-flags."

## Candidate Conclusion
- The W3C Trace Context specification defines a standardized traceparent HTTP header with four fields (version, trace-id, parent-id, trace-flags) that enables vendor-neutral distributed trace propagation across service boundaries, replacing proprietary tracing headers.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-25-w3c-traceparent-format.md`

## Notes
- none
