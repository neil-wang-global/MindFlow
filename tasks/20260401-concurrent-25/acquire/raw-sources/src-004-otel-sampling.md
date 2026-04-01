# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-002

## Source URL
- https://opentelemetry.io/docs/concepts/sampling/

## Fetch Timestamp
- 2026-04-01T10:11:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official OpenTelemetry project documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Sampling in OpenTelemetry

Sampling is a mechanism to control the noise and overhead introduced by OpenTelemetry by reducing the number of samples of traces collected and sent to a backend.

Head Sampling: Head sampling is a sampling technique used to make a sampling decision as early as possible. A decision to sample or drop a span or trace is not made by inspecting the trace as a whole. Head sampling with OpenTelemetry can be achieved using the TraceIdRatioBased or ParentBased built-in samplers.

With TraceIdRatioBased sampler, you can set a sampling rate, e.g. 0.5 means roughly 50% of traces will be sampled. The decision is deterministic based on the trace ID, which means consistent across services.

With ParentBased sampler, the sampling decision follows the parent span. If the parent is sampled, children spans are also sampled. This ensures trace completeness.

Tail Sampling: Tail sampling is where the decision to sample a trace takes place by considering all or most of the spans within the trace. Tail Sampling gives you the option to sample your traces based on specific criteria derived from different parts of a trace, which isn't an option with Head Sampling.

The OpenTelemetry Collector offers a tail sampling processor that lets you define policies to make sampling decisions. Supported policies include: latency-based, error-based, probabilistic, status-code-based, string-attribute-based, and rate-limiting.

The downside of tail sampling is that it requires all spans of a trace to be sent to a single collector instance for the decision to be made, which adds complexity and resource overhead.
