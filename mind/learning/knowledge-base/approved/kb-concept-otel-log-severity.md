# Knowledge Base Entry

## Type
- concept

## Summary
- OpenTelemetry defines a 24-point numeric severity scale with 6 named levels (TRACE through FATAL), each spanning 4 numeric values for sub-level granularity. This maps to ECS log.level string values and provides interoperability between OTel-instrumented and ECS-formatted logs. The numeric scale enables machine-processable severity filtering while the text values maintain human readability.

## Source Lineage
- Task ID: 20260401-concurrent-08
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-08.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-08-otel-log-severity.md
- Review File: mind/learning/reviews/review-20260401-concurrent-08-otel-log-severity.md
- Original Source Anchor: tasks/20260401-concurrent-08/acquire/raw-sources/src-003-otel-log-semconv.md
- Original Source URL: https://opentelemetry.io/docs/specs/semconv/general/logs/

## Key Evidence
> "OpenTelemetry defines a numeric severity scale:\n\n| SeverityNumber | SeverityText | Description |\n|---|---|---|\n| 1-4 | TRACE | Fine-grained debugging events |\n| 5-8 | DEBUG | Debugging events |\n| 9-12 | INFO | Informational events |\n| 13-16 | WARN | Warning events |\n| 17-20 | ERROR | Error events |\n| 21-24 | FATAL | Fatal/critical events |\n\nThe numeric range allows finer granularity within each level (e.g., INFO=9 vs INFO2=10 vs INFO3=11 vs INFO4=12)."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-08-otel-log-severity.md

## Applicability
- Applies to: any logging system that needs interoperability between OpenTelemetry and ECS formats; log aggregation pipelines processing logs from multiple instrumentation libraries; severity-based log filtering and routing
- Does not apply to: systems using only one fixed severity model with no cross-format requirements; custom severity schemes that intentionally diverge from both OTel and ECS

## Notes
- The 4-value range per level enables sub-level distinctions (e.g., differentiating between "routine info" and "important info") without requiring additional severity names
