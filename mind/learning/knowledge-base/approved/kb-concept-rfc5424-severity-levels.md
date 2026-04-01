# Knowledge Base Entry

## Type
- concept

## Summary
- RFC 5424 defines eight severity levels (0-7, lower is more severe) that form the canonical taxonomy for log levels adopted by most modern logging frameworks: Emergency, Alert, Critical, Error, Warning, Notice, Informational, Debug.

## Source Lineage
- Task ID: 20260401-concurrent-25
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-25.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-25-rfc5424-severity-levels.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-25-rfc5424-severity-levels.md`
- Original Source Anchor: `tasks/20260401-concurrent-25/acquire/raw-sources/src-006-rfc5424-syslog.md`
- Original Source URL: https://datatracker.ietf.org/doc/html/rfc5424

## Key Evidence
> "Table 2. Syslog Message Severities\n\nNumerical Code    Severity\n\n      0             Emergency: system is unusable\n      1             Alert: action must be taken immediately\n      2             Critical: critical conditions\n      3             Error: error conditions\n      4             Warning: warning conditions\n      5             Notice: normal but significant condition\n      6             Informational: informational messages\n      7             Debug: debug-level messages"

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-25-rfc5424-severity-levels.md`

## Applicability
- Applies to: log level design, structured logging implementation, syslog integration, observability log pipeline configuration
- Does not apply to: binary/metric-only telemetry systems without log output

## Notes
- none
