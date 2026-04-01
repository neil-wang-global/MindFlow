# Knowledge Base Entry

## Type
- concept

## Summary
- The W3C Trace Context specification defines a standardized traceparent HTTP header with four fields (version, trace-id, parent-id, trace-flags) that enables vendor-neutral distributed trace propagation across service boundaries, replacing proprietary tracing headers.

## Source Lineage
- Task ID: 20260401-concurrent-25
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-25.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-25-w3c-traceparent-format.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-25-w3c-traceparent-format.md`
- Original Source Anchor: `tasks/20260401-concurrent-25/acquire/raw-sources/src-003-w3c-trace-context.md`
- Original Source URL: https://www.w3.org/TR/trace-context/

## Key Evidence
> "The traceparent header field identifies the incoming request in a tracing system. It has four fields: version, trace-id, parent-id, and trace-flags."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-25-w3c-traceparent-format.md`

## Applicability
- Applies to: distributed tracing implementation, service mesh tracing, cross-service request correlation, OpenTelemetry integration
- Does not apply to: single-process tracing, systems that do not use HTTP for inter-service communication

## Notes
- none
