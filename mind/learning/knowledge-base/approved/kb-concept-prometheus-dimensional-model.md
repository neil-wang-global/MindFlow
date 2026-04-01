# Knowledge Base Entry

## Type
- concept

## Summary
- Prometheus implements a dimensional data model where labels (key-value pairs) attached to a metric name create distinct time series for each unique label combination, enabling flexible query-time filtering and aggregation — in contrast to hierarchical naming where all dimensions are encoded in the metric name and must be pre-aggregated at collection time.

## Source Lineage
- Task ID: 20260401-concurrent-25
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-25.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-25-prometheus-dimensional-model.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-25-prometheus-dimensional-model.md`
- Original Source Anchor: `tasks/20260401-concurrent-25/acquire/raw-sources/src-002-prometheus-data-model.md`
- Original Source URL: https://prometheus.io/docs/concepts/data_model/

## Key Evidence
> "Labels enable Prometheus's dimensional data model: any given combination of labels for the same metric name identifies a particular dimensional instantiation of that metric (for example: all HTTP requests that used the method POST to the /api/tracks handler). The query language allows filtering and aggregation based on these dimensions. Changing any label value, including adding or removing a label, will create a new time series."

## Review Status
- accepted

## Approved By Review
- `mind/learning/reviews/review-20260401-concurrent-25-prometheus-dimensional-model.md`

## Applicability
- Applies to: metric system design, observability architecture, Prometheus deployment, dimensional metric naming conventions
- Does not apply to: hierarchical-only metric systems (legacy StatsD/Graphite without dimensional extensions)

## Notes
- none
