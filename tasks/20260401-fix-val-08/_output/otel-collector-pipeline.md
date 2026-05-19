# OpenTelemetry Collector Pipeline Architecture

## Task ID
- 20260401-fix-val-08

## Summary
This document describes the OpenTelemetry Collector's receiver/processor/exporter pipeline architecture and how it enables vendor-agnostic telemetry collection. Due to fetch tool unavailability during acquisition, this document is based on existing approved knowledge base entries and cannot include content from the primary official documentation sources.

## Known Context from Approved Knowledge Base

### OTel Log Severity Model (kb-concept-otel-log-severity.md)
OpenTelemetry defines a 24-point numeric severity scale with 6 named levels (TRACE through FATAL), each spanning 4 numeric values for sub-level granularity. This model demonstrates OTel's approach to structured, interoperable data formats that bridge multiple systems (OTel-instrumented and ECS-formatted logs).

### W3C Trace Context (kb-concept-w3c-traceparent-format.md)
The W3C Trace Context specification defines a standardized traceparent HTTP header enabling vendor-neutral distributed trace propagation across service boundaries. The OTel Collector implements this standard as part of its trace processing pipeline.

## Knowledge Gap: OTel Collector Pipeline Architecture

The following knowledge remains unacquired due to fetch tool unavailability:

- **Receiver component model**: How receivers act as the entry point for telemetry data, supporting both push-based (OTLP) and pull-based (Prometheus scrape) ingestion patterns
- **Processor pipeline**: How processors transform, filter, enrich, and batch data between receivers and exporters, applied in configuration-defined order
- **Exporter component model**: How exporters send processed data to one or more backend destinations
- **Pipeline composition**: How pipelines connect receivers, processors, and exporters per signal type (traces, metrics, logs)
- **Connector component**: How connectors bridge pipelines by acting as both exporter and receiver
- **Extension model**: How extensions provide non-pipeline capabilities (health checks, profiling)
- **Vendor-agnostic design**: How the component-based architecture decouples instrumentation from backend choice

## Planned Sources (Not Fetched)
- https://opentelemetry.io/docs/collector/ — official Collector overview
- https://opentelemetry.io/docs/collector/architecture/ — official architecture documentation

## Status
- Knowledge gap documented; requires retry with fetch tool access
- ACQ-001 exhausted: required fetch tools unavailable
