# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://github.com/elastic/ecs

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Elastic GitHub repository; canonical source for ECS schema definitions

## Fetch Status
- success

## Fetch Completeness
- partial
- Simulated fetch; content represents the ECS README and schema overview from the repository

## Original Content

# Elastic Common Schema (ECS)

The Elastic Common Schema (ECS) defines a common set of fields for ingesting data into Elasticsearch. A common schema helps you correlate data from sources like logs and metrics or IT operations analytics and security analytics.

## What is ECS?

ECS is a specification that provides a consistent and customizable schema for common types of data, including:
- Log events
- Metrics
- Traces
- Security events
- Network events

## Goals

1. **Correlation across sources**: Use the same field names when storing similar data from different sources
2. **Predictability**: Know where to find specific data across all sources
3. **Interoperability**: Make data from different sources work together seamlessly
4. **Extensibility**: Allow custom fields without breaking the schema

## Key Design Principles

### Naming Conventions
- Field names are lower-case with underscores
- Use dot notation to represent nested objects: `source.ip`, `destination.port`
- Keep names short but descriptive
- Avoid abbreviations unless universally understood (e.g., `ip`, `os`)

### Field Reuse
- The same field set can appear in different contexts
- Example: `source.ip` and `destination.ip` both use the same IP field definition
- Nested reuse: `server.geo.country_name` reuses the `geo` field set

### Data Types
ECS defines these Elasticsearch data types for fields:
- `keyword` — Structured content for exact matching
- `text` / `match_only_text` — Full-text content
- `long` — 64-bit integer
- `integer` — 32-bit integer
- `float` — Single-precision floating point
- `date` — Date/time in ISO 8601
- `boolean` — True/false
- `ip` — IPv4 or IPv6 address
- `geo_point` — Latitude/longitude point
- `object` — JSON object
- `nested` — Array of JSON objects
- `wildcard` — Like keyword but for grep-like queries
- `flattened` — Entire JSON object as a single field value

### Core vs Extended Fields
- **Core**: Most common fields, expected in most events. High adoption.
- **Extended**: Less common, more specialized. Adoption varies.

## Log-Specific Guidance

### Structured Logging with ECS
When emitting logs from applications, use ECS field names directly:

```json
{
  "@timestamp": "2024-01-15T10:30:00.000Z",
  "message": "User authentication successful",
  "log.level": "info",
  "log.logger": "auth-service",
  "service.name": "auth-service",
  "service.version": "2.1.0",
  "service.environment": "production",
  "trace.id": "abc123def456",
  "span.id": "789ghi",
  "user.name": "jdoe",
  "event.category": ["authentication"],
  "event.type": ["info"],
  "event.outcome": "success",
  "host.name": "server-01"
}
```

### Correlation Fields
For distributed tracing and log correlation:
- `trace.id`: Links logs across service boundaries. Same value propagated through entire request chain.
- `span.id`: Identifies the specific operation within a trace.
- `transaction.id`: Groups related operations into a business transaction.

These fields align with OpenTelemetry trace context (W3C Trace Context propagation).

### Log Levels
ECS `log.level` accepts any string value but recommends alignment with common frameworks:
- `trace` — Most verbose, fine-grained debugging
- `debug` — Diagnostic information useful during development
- `info` — General operational events confirming things are working as expected
- `warn` — Indication that something unexpected happened or indicative of some problem in the near future
- `error` — Due to a more serious problem, the software has not been able to perform some function
- `fatal` / `critical` — Severe error that causes premature termination

### Correlation ID Best Practices
1. Generate a UUID v4 as the correlation ID at the system entry point (API gateway, load balancer, or first service)
2. Propagate via HTTP header: `X-Correlation-ID` or W3C `traceparent`
3. Extract the correlation ID in each service and attach to the logging context (e.g., MDC in Java, AsyncLocalStorage in Node.js, context.Context in Go)
4. Map the correlation ID to ECS `trace.id` field
5. Every log entry within the request chain must include the same `trace.id`
6. For sub-operations, generate new `span.id` values while keeping the same `trace.id`

## ECS and OpenTelemetry Convergence
ECS and OpenTelemetry Semantic Conventions are converging. The elastic/ecs repository tracks alignment status. Key convergence areas:
- Trace context fields (trace.id, span.id)
- Service identity fields (service.name, service.version)
- Resource attributes
- Log severity mapping
