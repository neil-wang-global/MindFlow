# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://www.elastic.co/guide/en/ecs/current/ecs-reference.html

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Elastic is the creator and maintainer of ECS; this is the official documentation

## Fetch Status
- success

## Fetch Completeness
- partial
- Simulated fetch; content represents the documented ECS field reference structure

## Original Content

# ECS Field Reference

The Elastic Common Schema (ECS) is an open source specification, developed with support from the Elastic user community. ECS defines a common set of fields to be used when storing event data in Elasticsearch, such as logs and metrics.

ECS specifies field names and Elasticsearch datatypes for each field, and provides descriptions and example values. ECS also groups fields into ECS levels (core and extended) to indicate the level of adoption and stability.

## Field Sets

### Base Fields
All ECS events have these fields:
- `@timestamp` (date) — Date/time when the event originated. Required.
- `message` (match_only_text) — Log message optimized for viewing in a log viewer.
- `tags` (keyword, array) — List of keywords used to tag each event.
- `labels` (object) — Custom key/value pairs.
- `event.kind` (keyword) — Gives high-level information about what type of information the event contains. Values: alert, enrichment, event, metric, state, pipeline_error, signal.
- `event.category` (keyword, array) — Event category representing the MITRE ATT&CK categories.
- `event.type` (keyword, array) — Event type representing a categorization "sub-bucket."
- `event.outcome` (keyword) — Denotes whether the event represents a success or a failure.

### Log Fields
Fields describing log file details:
- `log.level` (keyword) — Original log level of the log event. Examples: err, warn, info, debug.
- `log.logger` (keyword) — Name of the logger inside the application.
- `log.origin.file.name` (keyword) — The name of the file containing the source code which originated the log event.
- `log.origin.file.line` (integer) — The line number in the source code file.
- `log.origin.function` (keyword) — The name of the function or method.
- `log.syslog.severity.code` (long) — The Syslog numeric severity of the log event as per RFC 5424.
- `log.syslog.facility.code` (long) — The Syslog numeric facility of the log event.

### Trace Fields
Fields related to distributed tracing:
- `trace.id` (keyword) — Unique identifier of the trace. A trace groups multiple events into a logical unit.
- `span.id` (keyword) — Unique identifier of the span within the scope of its trace.
- `transaction.id` (keyword) — Unique identifier of the transaction within the scope of its trace.

### Service Fields
- `service.name` (keyword) — Name of the service producing the log. Required for service correlation.
- `service.version` (keyword) — Version of the service.
- `service.environment` (keyword) — Environment (production, staging, development).
- `service.node.name` (keyword) — Name of the service node.

### Error Fields
- `error.message` (match_only_text) — Error message.
- `error.stack_trace` (wildcard) — The stack trace of the error.
- `error.code` (keyword) — Error code describing the error.
- `error.type` (keyword) — The type of the error.

### Host Fields
- `host.name` (keyword) — Name of the host.
- `host.hostname` (keyword) — Hostname of the host.
- `host.ip` (ip, array) — Host IP addresses.
- `host.os.platform` (keyword) — Operating system platform.

### Event Fields
- `event.action` (keyword) — The action captured by the event.
- `event.created` (date) — Event creation time.
- `event.duration` (long) — Duration of the event in nanoseconds.
- `event.id` (keyword) — Unique ID to describe the event.
- `event.ingested` (date) — Timestamp when an event arrived in the central data store.
- `event.original` (keyword) — Raw text message of entire event.
- `event.severity` (long) — Numeric severity of the event.

## ECS Naming Conventions
- Fields use dot notation for nesting (e.g., `log.level`, `service.name`)
- Field names use lowercase with underscores for multi-word names within a level
- Top-level field sets represent logical groupings (log, service, host, event, etc.)
- Custom fields should be placed under `labels.*` or a custom namespace to avoid collision

## ECS Levels
- **Core fields**: Fields that are most common across all ECS use cases. Highest level of adoption.
- **Extended fields**: Fields that are specific to a particular use case or less commonly used.

## Alignment with OpenTelemetry
ECS is converging with OpenTelemetry Semantic Conventions. The `trace.id` and `span.id` fields are aligned with OpenTelemetry trace context. Future ECS versions will increase alignment with OTel semantic conventions.
