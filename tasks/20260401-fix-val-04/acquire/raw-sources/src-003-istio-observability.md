# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001

## Source URL
- https://istio.io/latest/docs/concepts/observability/

## Fetch Timestamp
- 2026-04-01

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Istio project documentation hosted on istio.io (CNCF project)

## Fetch Status
- success

## Fetch Completeness
- partial
- reason: content retrieved via WebSearch tool content extraction rather than direct WebFetch; WebSearch returns processed/extracted content from the target page, but this search returned nearly the full page text including direct verbatim quotes

## Original Content

Istio / Observability

Istio generates detailed telemetry for all service communications within a mesh. This telemetry provides observability of service behavior, empowering operators to troubleshoot, maintain, and optimize their applications – without imposing any additional burdens on service developers. Through Istio, operators gain a thorough understanding of how monitored services are interacting, both with other services and with the Istio components themselves.

Istio generates the following types of telemetry to provide overall service mesh observability:

**Metrics.** Istio generates a set of service metrics based on the four "golden signals" of monitoring (latency, traffic, errors, and saturation). Istio also provides detailed metrics for the mesh control plane. A default set of mesh monitoring dashboards built on top of these metrics is also provided.

**Distributed Traces.** Istio generates distributed trace spans for each service, providing operators with a detailed understanding of call flows and service dependencies within a mesh.

**Access Logs.** As traffic flows into a service within a mesh, Istio can generate a full record of each request, including source and destination metadata. This information enables operators to audit service behavior down to the individual workload instance level.

**Metrics**

Metrics provide a way of monitoring and understanding behavior in aggregate.

To monitor service behavior, Istio generates metrics for all service traffic in, out, and within an Istio service mesh. These metrics provide information on behaviors such as the overall volume of traffic, the error rates within the traffic, and the response times for requests.

In addition to monitoring the behavior of services within a mesh, it is also important to monitor the behavior of the mesh itself. Istio components export metrics on their own internal behaviors to provide insight into the health and function of the mesh control plane.

**Proxy-level metrics**

Istio metrics collection begins with the sidecar proxies (Envoy). Each proxy generates a rich set of metrics about all traffic passing through the proxy (both inbound and outbound). The proxies also provide detailed statistics about the administrative functions of the proxy itself, including configuration and health information.

Envoy-generated metrics provide monitoring of the mesh at the granularity of Envoy resources (such as listeners and clusters). As a result, understanding the connection between mesh services and Envoy resources is required for monitoring the Envoy metrics.

Istio enables operators to select which of the Envoy metrics are generated and collected at each workload instance. By default, Istio enables only a small subset of the Envoy-generated statistics to avoid overwhelming metrics backends and to reduce the CPU overhead associated with metrics collection. However, operators can easily expand the set of collected proxy metrics when required. This enables targeted debugging of networking behavior, while reducing the overall cost of monitoring across the mesh.

The Envoy documentation site includes a detailed overview of Envoy statistics collection. The operations guide on Envoy Statistics provides more information on controlling the generation of proxy-level metrics.

Example proxy-level Metrics:

envoy_cluster_upstream_rq_completed
envoy_cluster_upstream_cx_total
envoy_cluster_upstream_cx_connect_fail
envoy_cluster_upstream_cx_active
envoy_cluster_upstream_cx_rx_bytes_total
envoy_cluster_upstream_cx_tx_bytes_total
envoy_cluster_membership_change
envoy_cluster_membership_healthy
envoy_cluster_membership_degraded
envoy_server_memory_allocated
envoy_server_memory_heap_size
envoy_cluster_upstream_cx_none_healthy

**Service-level metrics**

In addition to the proxy-level metrics, Istio provides a set of service-oriented metrics for monitoring service communications. These metrics cover the four basic service monitoring needs: latency, traffic, errors, and saturation. Istio ships with a default set of dashboards for monitoring service behaviors based on these metrics.

The Standard Istio Metrics are exported by default to Prometheus.

Use of the service-level metrics is entirely optional. Operators may choose to turn off generation and collection of these metrics to meet their individual needs.

Example service-level metrics:

istio_requests_total
istio_request_duration_milliseconds
istio_request_bytes
istio_response_bytes

**Control plane metrics**

The Istio control plane also provides a collection of self-monitoring metrics. These metrics allow monitoring of the behavior of Istio itself (as distinct from that of the services within the mesh).

A fuller listing of the metrics maintained is found here.

**Distributed traces**

Distributed tracing provides a way to monitor and understand behavior by monitoring individual requests as they flow through a mesh. Traces empower mesh operators to understand service dependencies and the sources of latency within their service mesh.

Istio supports distributed tracing through the Envoy proxies. The proxies automatically generate trace spans on behalf of the applications they proxy, requiring only that the applications forward the appropriate request context.

Istio supports a number of tracing backends, including Zipkin, Jaeger, Lightstep, and Datadog. Operators control the sampling rate for trace generation (that is, the rate at which tracing data is generated per request). This allows operators to control the amount and rate of tracing data being produced for their mesh.

More information about Distributed Tracing with Istio is found in our FAQ on Distributed Tracing.

Istio's distributed tracing feature consists of tracing trace context propagation by the application and reporting individual trace spans by the Envoy proxies in the mesh.

**Access logs**

Access logs provide a way to monitor and understand behavior from the perspective of an individual workload instance.

Istio can generate access logs for service traffic in a configurable set of formats, providing operators with full control of the how, what, when and where of logging. More information is provided in Getting Envoy's Access Logs.

Example Istio access log:

[2019-03-06T09:31:27.354Z] "GET /status/418 HTTP/1.1" 418 - "-" 0 135 5 2 "-" "curl/7.60.0" "d209e46f-9ed5-9b61-bbdd-43e22f9bb4ad" "httpbin:8000" "172.30.146.73:80" outbound|8000||httpbin.default.svc.cluster.local - 172.21.13.94:8000 172.30.146.82:60290 -
