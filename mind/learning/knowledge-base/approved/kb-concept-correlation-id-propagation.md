# Knowledge Base Entry

## Type
- concept

## Summary
- ECS trace fields (trace.id, span.id, transaction.id) provide the correlation mechanism for distributed log aggregation. The trace.id is propagated unchanged through the entire request chain while span.id varies per operation. Alignment with W3C Trace Context and OpenTelemetry means the same correlation IDs work across both logging and tracing systems.

## Source Lineage
- Task ID: 20260401-concurrent-08
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-08.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-08-correlation-id-propagation.md
- Review File: mind/learning/reviews/review-20260401-concurrent-08-correlation-id-propagation.md
- Original Source Anchor: tasks/20260401-concurrent-08/acquire/raw-sources/src-002-ecs-github-readme.md
- Original Source URL: https://github.com/elastic/ecs

## Key Evidence
> "For distributed tracing and log correlation:\n- `trace.id`: Links logs across service boundaries. Same value propagated through entire request chain.\n- `span.id`: Identifies the specific operation within a trace.\n- `transaction.id`: Groups related operations into a business transaction.\n\nThese fields align with OpenTelemetry trace context (W3C Trace Context propagation)."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-08-correlation-id-propagation.md

## Applicability
- Applies to: distributed microservice architectures requiring end-to-end request tracing through logs; systems using ECS or OpenTelemetry for log format standardization; log aggregation pipelines that need to correlate logs across service boundaries
- Does not apply to: single-service applications with no distributed tracing needs; systems using proprietary correlation mechanisms incompatible with W3C Trace Context

## Notes
- trace.id maps directly to W3C Trace Context traceparent header, enabling seamless integration between logging and tracing systems
