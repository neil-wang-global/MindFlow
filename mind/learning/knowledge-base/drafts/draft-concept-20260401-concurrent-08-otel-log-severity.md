# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-08

## Summary
- OpenTelemetry defines a 24-point numeric severity scale with 6 named levels, each spanning 4 values for sub-level granularity, mapping to ECS log.level

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-08.md
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-08/acquire/raw-sources/src-003-otel-log-semconv.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-08/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "OpenTelemetry defines a numeric severity scale:\n\n| SeverityNumber | SeverityText | Description |\n|---|---|---|\n| 1-4 | TRACE | Fine-grained debugging events |\n| 5-8 | DEBUG | Debugging events |\n| 9-12 | INFO | Informational events |\n| 13-16 | WARN | Warning events |\n| 17-20 | ERROR | Error events |\n| 21-24 | FATAL | Fatal/critical events |\n\nThe numeric range allows finer granularity within each level (e.g., INFO=9 vs INFO2=10 vs INFO3=11 vs INFO4=12)."

## Candidate Conclusion
- OpenTelemetry defines a 24-point numeric severity scale with 6 named levels (TRACE through FATAL), each spanning 4 numeric values for sub-level granularity. This maps to ECS log.level string values and provides interoperability between OTel-instrumented and ECS-formatted logs. The numeric scale enables machine-processable severity filtering while the text values maintain human readability.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-08-otel-log-severity.md

## Notes
- none
