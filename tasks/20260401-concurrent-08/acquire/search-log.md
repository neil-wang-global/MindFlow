# Acquire Search Log

## Task ID
- 20260401-concurrent-08

## ACQ-001: Structured logging standards (ECS, JSON logging, correlation IDs, log levels)

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- No approved knowledge exists about structured logging standards. Need to acquire knowledge covering: (1) Elastic Common Schema (ECS) field naming conventions and structure, (2) JSON structured logging format best practices, (3) correlation ID propagation patterns for distributed tracing, (4) log level definitions and usage conventions.

### Search Queries

#### Query 1
- **Query String**: Elastic Common Schema ECS structured logging fields specification 2024
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://www.elastic.co/guide/en/ecs/current/ecs-reference.html | Official Elastic documentation for ECS field reference — primary authoritative source |
| 2 | https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html | Official ECS field reference page listing all field sets |
| 3 | https://github.com/elastic/ecs | ECS GitHub repository — canonical source for schema definitions |

#### Query 2
- **Query String**: JSON structured logging best practices correlation ID log levels standards
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:01:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://opentelemetry.io/docs/specs/semconv/general/logs/ | OpenTelemetry semantic conventions for logs — industry standard for log field naming |
| 2 | https://www.rfc-editor.org/rfc/rfc5424 | RFC 5424 (Syslog Protocol) — defines standard severity levels used across logging frameworks |

### Fetch Plan
- https://www.elastic.co/guide/en/ecs/current/ecs-reference.html (src-001)
- https://github.com/elastic/ecs (src-002)
- https://opentelemetry.io/docs/specs/semconv/general/logs/ (src-003)

### Notes
- Query 1 identified ECS as the primary authoritative schema; Query 2 broadened to correlation ID patterns and log level standards
- RFC 5424 skipped from fetch plan as the syslog severity levels are well-known and can be referenced without full fetch
