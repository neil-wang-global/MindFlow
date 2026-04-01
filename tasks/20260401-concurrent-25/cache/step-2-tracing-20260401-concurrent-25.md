# Step 2: Distributed Tracing Research

## Task ID
- 20260401-concurrent-25

## Step
- Step 2: Distributed Tracing Research

## ACQ Event
- ACQ-002: completed — 2 sources passed (src-003, src-004)

## Findings

### W3C Trace Context
W3C Trace Context is a standardized specification (W3C Recommendation) for propagating distributed tracing context across services via HTTP headers. The traceparent header format is: version-trace-id-parent-id-trace-flags, where trace-id is 128-bit (32 hex chars), parent-id is 64-bit (16 hex chars), and trace-flags includes a sampled bit. The tracestate header carries vendor-specific data.

### Sampling Strategies
1. **Head-based sampling**: decision made at trace start (root span). Deterministic based on trace ID. OpenTelemetry provides TraceIdRatioBased and ParentBased built-in samplers. Simple but blind to outcomes.
2. **Tail-based sampling**: decision made after all spans collected. The OpenTelemetry Collector's tail sampling processor supports latency-based, error-based, probabilistic, status-code-based, and attribute-based policies. Context-aware but requires more resources.

## Source References
- src-003: W3C Trace Context specification
- src-004: OpenTelemetry sampling documentation
