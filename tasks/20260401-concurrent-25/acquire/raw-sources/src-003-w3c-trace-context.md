# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-002

## Source URL
- https://www.w3.org/TR/trace-context/

## Fetch Timestamp
- 2026-04-01T10:10:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — W3C Recommendation (highest maturity level)

## Fetch Status
- success

## Fetch Completeness
- partial — extracted specification core sections

## Original Content

Trace Context - W3C Recommendation

This specification defines standard HTTP headers and a value format to propagate context information that enables distributed tracing scenarios. The specification standardizes how context information is sent and modified between services. Context information uniquely identifies individual requests in a distributed system and also defines a means to add and propagate provider-specific context information.

The traceparent header represents the incoming request in a tracing system in a common format, understood by all vendors. Here is an example of a traceparent header: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01

The traceparent header field identifies the incoming request in a tracing system. It has four fields: version, trace-id, parent-id, and trace-flags.

version (8-bit): trace context version that the system has adopted. The current version is 00.

trace-id (128-bit): the ID of the whole trace. It is used to uniquely identify a distributed trace through a system. It is represented as a 32 lowercase hex character string. All bytes as zero (00000000000000000000000000000000) is considered an invalid value.

parent-id (64-bit): the ID of this request as known by the caller. It is represented as a 16 lowercase hex character string. All bytes as zero (0000000000000000) is considered an invalid value.

trace-flags (8-bit): an 8-bit field that controls tracing flags such as sampling, trace level, etc. The current version of this specification (00) only supports a single flag called sampled.

The tracestate header field provides additional vendor-specific trace identification information across different distributed tracing systems. If a system does not understand tracestate but needs to propagate it, it must pass the header through unmodified.
