# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-003

## Source URL
- https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html

## Fetch Timestamp
- 2026-04-01T10:20:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Elastic documentation

## Fetch Status
- success

## Fetch Completeness
- partial — core field reference sections extracted

## Original Content

Elastic Common Schema (ECS) Reference

The Elastic Common Schema (ECS) is an open source specification, developed with support from the Elastic user community. ECS defines a common set of fields to be used when storing event data in Elasticsearch, such as logs and metrics.

ECS specifies field names and Elasticsearch datatypes for each field, and provides descriptions and example values. The goal of ECS is to enable and encourage users of Elasticsearch to normalize their event data, so that they can better analyze, visualize, and correlate the data represented in their events.

Core Fields:
- @timestamp: Date/time when the event originated. This is the date/time extracted from the event, typically representing when the source generated the event.
- message: For log events the message field contains the log message, optimized for viewing in a log viewer.
- log.level: Original log level of the log event. Some examples are warn, error, i.
- log.logger: The name of the logger inside an application.
- ecs.version: ECS version this event conforms to.

Event Fields:
- event.category: This is one of four ECS Categorization Fields, and indicates the second level in the ECS category hierarchy.
- event.kind: This is one of four ECS Categorization Fields, and indicates the highest level in the ECS category hierarchy. Values include alert, enrichment, event, metric, state, pipeline_error, signal.
- event.outcome: This field captures the outcome of the event. Values include success, failure, unknown.

Tracing Fields:
- trace.id: Unique identifier of the trace. A trace groups multiple events like transactions that belong together. How events are grouped in a trace is up to each implementation.
- span.id: Unique identifier of the span within the scope of its trace.
- transaction.id: Unique identifier of the transaction within the scope of its trace.

Host Fields:
- host.name: Name of the host.
- host.hostname: Hostname of the host.
- host.ip: Host ip addresses.

Service Fields:
- service.name: Name of the service data is collected from.
- service.version: Version of the service.

Error Fields:
- error.message: Error message.
- error.stack_trace: The stack trace of the error in plain text.
