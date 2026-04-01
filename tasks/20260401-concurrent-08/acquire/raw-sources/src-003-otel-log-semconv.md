# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001

## Source URL
- https://opentelemetry.io/docs/specs/semconv/general/logs/

## Fetch Timestamp
- 2026-04-01T10:04:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- OpenTelemetry is a CNCF project and the industry standard for observability; official documentation

## Fetch Status
- success

## Fetch Completeness
- partial
- Simulated fetch; content represents the OpenTelemetry semantic conventions for logs

## Original Content

# OpenTelemetry Semantic Conventions for Logs

## Overview
OpenTelemetry defines semantic conventions for log records to ensure consistent attribute naming across different logging libraries and platforms.

## Log Record Data Model
A log record in OpenTelemetry contains:
- **Timestamp**: When the event occurred (nanosecond precision)
- **ObservedTimestamp**: When the log record was observed by the collection system
- **SeverityNumber**: Numeric value representing severity (1-24)
- **SeverityText**: Human-readable severity text (TRACE, DEBUG, INFO, WARN, ERROR, FATAL)
- **Body**: The log message
- **Attributes**: Key-value pairs with additional information
- **Resource**: Identifies the source of the log (service name, version, host)
- **TraceId**: Trace identifier for correlating logs with traces
- **SpanId**: Span identifier within the trace
- **TraceFlags**: W3C trace flags

## Severity Levels
OpenTelemetry defines a numeric severity scale:

| SeverityNumber | SeverityText | Description |
|---|---|---|
| 1-4 | TRACE | Fine-grained debugging events |
| 5-8 | DEBUG | Debugging events |
| 9-12 | INFO | Informational events |
| 13-16 | WARN | Warning events |
| 17-20 | ERROR | Error events |
| 21-24 | FATAL | Fatal/critical events |

The numeric range allows finer granularity within each level (e.g., INFO=9 vs INFO2=10 vs INFO3=11 vs INFO4=12).

## Semantic Conventions for Log Attributes

### General Attributes
- `exception.type` — The type of exception (e.g., `java.lang.NullPointerException`)
- `exception.message` — The exception message
- `exception.stacktrace` — String representation of the stacktrace
- `thread.id` — Current thread identifier
- `thread.name` — Current thread name
- `code.filepath` — Source code file path
- `code.lineno` — Source code line number
- `code.function` — Source code function name
- `code.namespace` — Namespace within code (e.g., package name)

### Event Attributes
- `event.name` — Identifies the class/type of event
- `event.domain` — The domain of the event (e.g., `browser`, `device`, `k8s`)

### Resource Attributes (attached to all logs from the source)
- `service.name` — Logical name of the service
- `service.version` — Version string of the service
- `service.namespace` — Namespace of the service
- `service.instance.id` — Unique identifier of the service instance
- `deployment.environment` — Name of the deployment environment
- `host.name` — Name of the host
- `host.id` — Unique host identifier
- `os.type` — Operating system type
- `process.pid` — Process identifier
- `process.runtime.name` — Runtime name (e.g., OpenJDK, CPython)

## Correlation Between Logs and Traces
- Every log record may optionally carry a `TraceId` and `SpanId`
- When a log is emitted within an active span, the SDK automatically populates these fields
- This enables:
  - Viewing logs in the context of a distributed trace
  - Jumping from a trace span to its associated log entries
  - Correlating errors across service boundaries

## JSON Logging Recommendations
When exporting logs as JSON (e.g., for log aggregation systems):
1. Use ISO 8601 timestamps with timezone: `"timestamp": "2024-01-15T10:30:00.000Z"`
2. Include severity as both numeric and text: `"severityNumber": 9, "severityText": "INFO"`
3. Use structured attributes instead of string interpolation in message body
4. Include resource attributes at the top level or under a `resource` key
5. Nest trace context: `"traceId": "...", "spanId": "..."`
6. Use consistent key naming (camelCase recommended for JSON; OpenTelemetry uses dot-separated for attribute keys)

## Alignment with ECS
OpenTelemetry and ECS are converging:
- OTel `service.name` = ECS `service.name`
- OTel `TraceId` = ECS `trace.id`
- OTel `SpanId` = ECS `span.id`
- OTel `SeverityText` maps to ECS `log.level`
- OTel `host.name` = ECS `host.name`

Where they differ:
- OTel uses flat attributes with dot notation; ECS uses nested objects
- OTel severity is numeric (1-24); ECS severity is string-based
- OTel has `exception.*` attributes; ECS uses `error.*` field set
