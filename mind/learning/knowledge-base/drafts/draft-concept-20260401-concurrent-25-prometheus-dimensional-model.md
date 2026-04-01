# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-25

## Summary
- Prometheus implements a dimensional data model where labels (key-value pairs) create distinct time series per unique label combination, enabling flexible query-time filtering and aggregation

## From Task Learning
- `mind/learning/task-learning/tl-20260401-concurrent-25.md`
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- `tasks/20260401-concurrent-25/acquire/raw-sources/src-002-prometheus-data-model.md`
  - ACQ Event: ACQ-001
  - Verification Report: `tasks/20260401-concurrent-25/acquire/verification-report.md §ACQ-001`
  - Verification Status: passed (confirmed in Passed Sources for ACQ-001)

## Original Excerpt
> "Labels enable Prometheus's dimensional data model: any given combination of labels for the same metric name identifies a particular dimensional instantiation of that metric (for example: all HTTP requests that used the method POST to the /api/tracks handler). The query language allows filtering and aggregation based on these dimensions. Changing any label value, including adding or removing a label, will create a new time series."

## Candidate Conclusion
- Prometheus implements a dimensional data model where labels (key-value pairs) attached to a metric name create distinct time series for each unique label combination, enabling flexible query-time filtering and aggregation — in contrast to hierarchical naming where all dimensions are encoded in the metric name and must be pre-aggregated at collection time.

## Review Status
- pending

## Review Target
- `mind/learning/reviews/review-20260401-concurrent-25-prometheus-dimensional-model.md`

## Notes
- none
