# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://prometheus.io/docs/concepts/data_model/

## Fetch Timestamp
- 2026-04-01T10:01:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Prometheus project documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Prometheus fundamentally stores all data as time series: streams of timestamped values belonging to the same metric and the same set of labeled dimensions. Besides stored time series, Prometheus may generate temporary derived time series as the result of queries.

Every time series is uniquely identified by its metric name and optional key-value pairs called labels. The metric name specifies the general feature of a system that is measured (e.g. http_requests_total - the total number of HTTP requests received). It may contain ASCII letters and digits, as well as underscores and colons. It must match the regex [a-zA-Z_:][a-zA-Z0-9_:]*.

Labels enable Prometheus's dimensional data model: any given combination of labels for the same metric name identifies a particular dimensional instantiation of that metric (for example: all HTTP requests that used the method POST to the /api/tracks handler). The query language allows filtering and aggregation based on these dimensions. Changing any label value, including adding or removing a label, will create a new time series.

Samples form the actual time series data. Each sample consists of a float64 value and a millisecond-precision timestamp.

Given a metric name and a set of labels, time series are frequently identified using this notation: <metric name>{<label name>=<label value>, ...}. For example, the time series with the metric name api_http_requests_total and the labels method="POST" and handler="/messages" could be written like this: api_http_requests_total{method="POST", handler="/messages"}.
