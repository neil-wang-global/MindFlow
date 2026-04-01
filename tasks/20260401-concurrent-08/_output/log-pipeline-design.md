# Log Aggregation Pipeline Design

## Task ID
- 20260401-concurrent-08

## Overview

This document defines a log aggregation pipeline architecture for distributed microservice environments. The design applies structured logging standards from ECS (Elastic Common Schema) and OpenTelemetry semantic conventions, incorporating correlation ID propagation, standardized log levels, and JSON-formatted log emission.

Design principles (from Soul constraints):
- **Resilience over raw performance**: pipeline components must handle failures gracefully with backpressure and dead-letter mechanisms
- **Explicit failure handling over silent degradation**: every pipeline stage has visible failure modes and monitoring
- **Operational simplicity over architectural elegance**: prefer well-understood components with clear operational models

---

## 1. Log Emission Layer (Application Services)

### Structured Log Format
All services emit logs as JSON objects using ECS field naming conventions:

```json
{
  "@timestamp": "2026-04-01T10:30:00.000Z",
  "message": "Order processed successfully",
  "log.level": "info",
  "log.logger": "order-service.handler",
  "service.name": "order-service",
  "service.version": "3.2.1",
  "service.environment": "production",
  "trace.id": "550e8400-e29b-41d4-a716-446655440000",
  "span.id": "789ghi012jkl",
  "event.category": ["process"],
  "event.outcome": "success",
  "event.duration": 245000000,
  "host.name": "order-pod-abc123",
  "labels": {
    "orderId": "ORD-12345",
    "customerId": "CUST-678"
  }
}
```

### Required Fields (Core)
| Field | Type | Description |
|-------|------|-------------|
| `@timestamp` | date (ISO 8601) | When the event occurred |
| `message` | text | Human-readable log message |
| `log.level` | keyword | Severity: trace, debug, info, warn, error, fatal |
| `service.name` | keyword | Logical name of the emitting service |
| `trace.id` | keyword | Distributed trace identifier (UUID v4) |

### Extended Fields (Recommended)
| Field | Type | Description |
|-------|------|-------------|
| `span.id` | keyword | Operation identifier within the trace |
| `service.version` | keyword | Service version string |
| `service.environment` | keyword | Deployment environment |
| `event.category` | keyword[] | Event classification |
| `event.outcome` | keyword | success / failure / unknown |
| `event.duration` | long | Duration in nanoseconds |
| `host.name` | keyword | Hostname or pod name |
| `error.message` | text | Error description (when log.level is error/fatal) |
| `error.stack_trace` | wildcard | Stack trace string |

### Log Level Conventions
Aligned with both ECS and OpenTelemetry severity mapping:

| Level | OTel Severity | Usage |
|-------|---------------|-------|
| trace | 1-4 | Fine-grained debugging; never in production |
| debug | 5-8 | Diagnostic information for development |
| info | 9-12 | Normal operational events |
| warn | 13-16 | Unexpected conditions; system continues |
| error | 17-20 | Operation failed; service continues |
| fatal | 21-24 | Service cannot continue; shutdown imminent |

Production default: `info`. Per-service override via environment variable `LOG_LEVEL`.

### Correlation ID Propagation
1. **Entry point**: API gateway generates UUID v4 as `trace.id`, sets HTTP header `traceparent` (W3C Trace Context format)
2. **Propagation**: Each service extracts `trace.id` from incoming `traceparent` header; attaches to logging context (MDC in Java, AsyncLocalStorage in Node.js, context.Context in Go)
3. **Sub-operations**: Generate new `span.id` per operation; retain same `trace.id`
4. **Async boundaries**: Propagate `trace.id` through message headers in queues/event buses
5. **Log emission**: Every log entry automatically includes `trace.id` and `span.id` from context

---

## 2. Collection Layer (Log Shipping)

### Architecture
```
[Service Pods] → [Sidecar/DaemonSet Agent] → [Buffer Queue] → [Processing Layer]
```

### Collection Agent
- **Deployment model**: DaemonSet (one agent per node) for Kubernetes environments; sidecar for non-Kubernetes
- **Agent options**: Fluent Bit (lightweight, preferred) or Filebeat (ECS-native)
- **Input**: Read from stdout/stderr (container log driver) or log files
- **Pre-processing**: Parse JSON, validate required fields present, add node-level metadata (`host.name`, `host.ip`)

### Reliability Guarantees
- **At-least-once delivery**: agents use persistent file-based buffer with position tracking
- **Backpressure handling**: when downstream is unavailable, buffer to local disk (configurable limit: 1GB default)
- **Retry**: exponential backoff with jitter on failed sends (initial: 1s, max: 60s)
- **Health check**: agent exposes /healthz endpoint; monitored by orchestrator liveness probe

### State Machine: Collection Agent
```
[Tailing] → (log line received) → [Parsing]
[Parsing] → (valid JSON) → [Buffering]
[Parsing] → (invalid format) → [Dead Letter] → [Buffering with error envelope]
[Buffering] → (downstream available) → [Sending]
[Buffering] → (downstream unavailable) → [Disk Buffer]
[Disk Buffer] → (downstream recovers) → [Draining] → [Sending]
[Sending] → (ACK received) → [Tailing] (advance position)
[Sending] → (NACK/timeout) → [Retry Queue] → [Sending]
```

---

## 3. Processing Layer (Enrichment and Normalization)

### Architecture
```
[Buffer Queue] → [Stream Processor] → [Routing/Filtering] → [Storage Layer]
```

### Stream Processor
- **Technology**: Apache Kafka (buffer) + stream processing (Kafka Streams or dedicated processing pipeline)
- **Partitioning**: By `service.name` to maintain ordering per service; `trace.id` for trace-correlated processing

### Processing Pipeline Stages
1. **Schema validation**: Verify required ECS fields present; reject malformed entries to dead-letter topic
2. **Field normalization**: Normalize log levels to lowercase; ensure `@timestamp` is ISO 8601 with timezone; map non-ECS field names to ECS equivalents
3. **Enrichment**: 
   - Add `event.ingested` timestamp
   - Resolve `host.ip` from service discovery if not present
   - Attach deployment labels from Kubernetes API (namespace, deployment, replica set)
4. **Filtering**: Drop `trace` and `debug` level logs in production (configurable per service); rate-limit high-volume repetitive error logs
5. **Sampling**: For high-throughput services (>10K logs/sec), apply tail-based sampling: keep all error/fatal, sample info at configured rate, drop trace/debug
6. **Routing**: Route to appropriate storage tier based on `log.level` and `service.environment`

### Dead Letter Queue
- Logs that fail schema validation or processing are routed to a dead-letter topic
- Dead-letter entries include: original log content, failure reason, processing stage, timestamp
- Dead-letter topic has separate retention (30 days) and alerting (>100 entries/minute triggers alert)

---

## 4. Storage Layer (Indexing and Retention)

### Tiered Storage Architecture
| Tier | Content | Storage | Retention | Query Speed |
|------|---------|---------|-----------|-------------|
| Hot | Last 3 days, all levels | SSD-backed indices | 3 days | <100ms |
| Warm | 3-30 days, info and above | HDD-backed indices | 30 days | <1s |
| Cold | 30-90 days, warn and above | Object storage (S3) | 90 days | <10s |
| Frozen | 90-365 days, error/fatal only | Archive (S3 Glacier) | 365 days | Minutes |

### Index Strategy
- Index pattern: `logs-{service.name}-{YYYY.MM.dd}`
- ILM (Index Lifecycle Management) policy automates tier transitions
- Rollover: new index when size > 50GB or age > 1 day

### Query Optimization
- Mandatory filter fields indexed as `keyword`: `service.name`, `log.level`, `trace.id`, `@timestamp`
- `message` field indexed as `text` for full-text search
- `labels.*` fields indexed as `keyword` for custom attribute filtering

---

## 5. Pipeline Resilience

### Failure Modes and Handling
| Component | Failure Mode | Detection | Response |
|-----------|-------------|-----------|----------|
| Collection Agent | Crash/OOM | DaemonSet restart, liveness probe | Auto-restart; resume from last committed position |
| Buffer Queue (Kafka) | Broker down | Kafka broker health check | Replica takeover; producer retries |
| Stream Processor | Processing error | Exception handler per record | Route to dead-letter; continue processing |
| Storage (Elasticsearch) | Cluster red | Cluster health API | Buffer in Kafka; alert ops team; retry on recovery |
| Network partition | Agent cannot reach Kafka | Connection timeout | Local disk buffer; exponential backoff retry |

### Monitoring the Pipeline Itself
- **Collection lag**: difference between log emission time and ingestion time; alert if >5 minutes
- **Processing throughput**: events/second through each processing stage; alert on >20% drop
- **Dead-letter rate**: entries/minute to dead-letter topic; alert on >100/minute
- **Storage health**: index shard health, disk usage; alert on >80% disk
- **End-to-end latency**: p50, p95, p99 from `@timestamp` to `event.ingested`; alert if p99 >10 minutes

### Circuit Breaker Pattern
Apply circuit breaker between processing layer and storage layer:
- **Closed**: normal operation; forward all processed logs
- **Open**: storage unhealthy; buffer in Kafka with extended retention; stop forwarding
- **Half-Open**: probe storage health every 30 seconds; if healthy, transition to Closed

---

## 6. Architecture Diagram

```
                              ┌─────────────────┐
                              │   API Gateway    │
                              │ (trace.id gen)   │
                              └────────┬─────────┘
                                       │ traceparent header
                    ┌──────────────────┼──────────────────┐
                    │                  │                   │
              ┌─────▼─────┐    ┌──────▼──────┐    ┌──────▼──────┐
              │ Service A  │    │ Service B   │    │ Service C   │
              │ (JSON/ECS) │    │ (JSON/ECS)  │    │ (JSON/ECS)  │
              └─────┬──────┘    └──────┬──────┘    └──────┬──────┘
                    │ stdout           │ stdout           │ stdout
              ┌─────▼──────┐    ┌──────▼──────┐    ┌──────▼──────┐
              │ Fluent Bit  │    │ Fluent Bit  │    │ Fluent Bit  │
              │ (DaemonSet) │    │ (DaemonSet) │    │ (DaemonSet) │
              └─────┬──────┘    └──────┬──────┘    └──────┬──────┘
                    │                  │                   │
                    └──────────────────┼───────────────────┘
                                       │
                              ┌────────▼─────────┐
                              │   Apache Kafka   │
                              │  (Buffer Queue)  │
                              └────────┬─────────┘
                                       │
                              ┌────────▼─────────┐
                              │ Stream Processor  │
                              │ (Validate/Enrich/ │
                              │  Filter/Route)    │
                              └──┬─────┬─────┬───┘
                                 │     │     │
                        ┌────────┘     │     └────────┐
                   ┌────▼────┐  ┌──────▼──────┐  ┌───▼──────┐
                   │  Hot    │  │   Warm      │  │  Cold/   │
                   │ (SSD)   │  │   (HDD)     │  │  Frozen  │
                   │ 3 days  │  │   30 days   │  │  90-365d │
                   └─────────┘  └─────────────┘  └──────────┘

                              ┌─────────────────┐
                              │  Dead Letter Q   │
                              │ (30 day retain)  │
                              └─────────────────┘
```

---

## References
- ECS Field Reference (src-001): https://www.elastic.co/guide/en/ecs/current/ecs-reference.html
- ECS GitHub Repository (src-002): https://github.com/elastic/ecs
- OpenTelemetry Log Semantic Conventions (src-003): https://opentelemetry.io/docs/specs/semconv/general/logs/
