# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/tracing

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Envoy project documentation hosted on envoyproxy.io (CNCF project)

## Fetch Status
- success

## Fetch Completeness
- partial
- reason: content retrieved via WebSearch tool content extraction rather than direct WebFetch; WebSearch returns processed/extracted content from the target page rather than the complete raw page

## Original Content

Distributed Tracing — envoy 1.14.0-dev-570e3d documentation

Envoy proxy supports distributed tracing through integration with tracing providers. The distributed tracing system has the following key components:

**Trace Context Propagation**

The tracing provider or the connection manager in Envoy can be responsible for propagating the trace context. Envoy handles trace context propagation to enable end-to-end request tracking across service boundaries.

**Request ID Generation/Propagation**

Envoy has the concept of an internal and external origin. The concept of internal/external origin is important in terms of requirements for the `x-request-id` header. Envoy generates request IDs and propagates them through the service mesh to correlate requests.

**Supported Tracers**

The following tracers are supported:
- Zipkin
- OpenTelemetry
- Jaeger (via Zipkin-compatible API or OpenTelemetry)
- Datadog
- LightStep

**OpenTelemetry Tracer Configuration**

Configuration for the OpenTelemetry tracer: The OpenTelemetry project provides an open standard for traces and metrics, with an SDK for several programming languages and OTLP protocol for transmitting telemetry data.

The tracing configuration specifies settings for an HTTP tracer provider used by Envoy. The `config.trace.v3.Tracing` and `config.trace.v3.Tracing.Http` configuration objects define the tracer settings.

**Integration with Istio**

When used in Istio service mesh, Envoy proxies automatically generate trace spans on behalf of the applications they proxy, requiring only that the applications forward the appropriate request context headers. Istio supports configurable sampling rates for trace generation, allowing operators to control the amount and rate of tracing data produced for their mesh.

Istio supports a number of tracing backends, including Zipkin, Jaeger, Lightstep, and Datadog.

Source URLs:
- Main tracing docs: https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/tracing
- Tracing API v3: https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/trace/trace
- OpenTelemetry tracer config: https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/trace/v3/opentelemetry.proto
