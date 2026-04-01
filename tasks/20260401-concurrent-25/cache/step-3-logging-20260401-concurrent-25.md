# Step 3: Structured Logging Research

## Task ID
- 20260401-concurrent-25

## Step
- Step 3: Structured Logging Research

## ACQ Event
- ACQ-003: completed — 2 sources passed (src-005, src-006)

## Findings

### Elastic Common Schema (ECS)
ECS is an open source specification defining a common set of fields for event data in Elasticsearch. Uses dot-notated hierarchical field naming (snake_case): @timestamp, message, log.level, log.logger, ecs.version, event.category, event.kind, host.name, service.name, error.message, error.stack_trace. Includes tracing correlation fields: trace.id, span.id, transaction.id.

### RFC 5424 Syslog Severity Levels
Eight severity levels (0 = most severe): Emergency (0), Alert (1), Critical (2), Error (3), Warning (4), Notice (5), Informational (6), Debug (7). Priority calculated as Facility * 8 + Severity. RFC 5424 also supports STRUCTURED-DATA elements for machine-parseable key-value metadata.

### Log Levels Taxonomy
Modern frameworks map to RFC 5424: FATAL -> Emergency/Alert, ERROR -> Error, WARN -> Warning, INFO -> Informational, DEBUG -> Debug, TRACE -> Debug.

## Source References
- src-005: ECS field reference documentation
- src-006: RFC 5424 syslog protocol
