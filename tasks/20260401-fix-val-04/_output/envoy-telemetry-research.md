# Envoy Telemetry Research Summary

## Task ID
- 20260401-fix-val-04

## Research Topic
- Service mesh observability patterns: how Envoy proxies collect and export telemetry data (access logs, metrics, and traces) in an Istio service mesh

## Sources
- src-001: Envoy Statistics Documentation (https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/statistics)
- src-002: Envoy Distributed Tracing Documentation (https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/tracing)
- src-003: Istio Observability Concepts (https://istio.io/latest/docs/concepts/observability/)

## Key Findings

### 1. Envoy Statistics/Metrics System

Envoy emits statistics in three types:
- **Counter**: monotonically increasing unsigned integers (e.g., total requests)
- **Gauge**: values that increase and decrease (e.g., active connections)
- **Histogram**: value distributions (e.g., request latency)

These are organized by Envoy resource categories (listeners, clusters, connection managers) and exported to configurable stats sinks (StatsD, Prometheus, others).

In Istio, metrics operate at two levels:
- **Proxy-level metrics**: raw Envoy statistics about resource-level activity (e.g., `envoy_cluster_upstream_rq_completed`, `envoy_cluster_upstream_cx_total`). Istio enables only a subset by default to reduce overhead.
- **Service-level metrics**: Istio-generated metrics based on the four golden signals — `istio_requests_total` (traffic), `istio_request_duration_milliseconds` (latency), `istio_request_bytes`/`istio_response_bytes` (saturation). Exported to Prometheus by default.
- **Control plane metrics**: self-monitoring of Istio components (istiod).

### 2. Envoy Distributed Tracing

Envoy supports distributed tracing through:
- **Request ID generation**: Envoy generates and propagates `x-request-id` headers with internal/external origin distinction
- **Trace context propagation**: handled by the tracing provider or Envoy's connection manager
- **Supported tracer backends**: Zipkin, OpenTelemetry (OTLP), Jaeger, Datadog, LightStep

In Istio, Envoy proxies automatically generate trace spans on behalf of proxied applications. Applications only need to forward request context headers. Sampling rate is configurable per mesh.

### 3. Access Logs

Istio generates access logs recording full request details including source/destination metadata. Log format is configurable. Example format includes timestamp, HTTP method, path, status code, response flags, request/response sizes, latency, user agent, request ID, upstream host, and routing metadata.

## Knowledge Candidates for Terminal Learning

1. **Envoy statistics architecture**: Three stat types (Counter, Gauge, Histogram), resource-based organization, configurable stats sinks; in Istio, two-tier metrics (proxy-level raw Envoy stats vs service-level golden signal metrics) with selective metric enablement
2. **Envoy distributed tracing in Istio**: Automatic trace span generation by sidecar proxies, x-request-id propagation, trace context handling, multi-backend support (Zipkin, OTel, Jaeger), configurable sampling rates
