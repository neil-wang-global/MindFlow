# Knowledge Base Entry

## Type
- concept

## Summary
- Envoy's statistics system categorizes all emitted metrics into three fundamental types — Counter (monotonically increasing), Gauge (current state), and Histogram (value distributions) — and exports them through a configurable stats sink infrastructure supporting multiple backends including StatsD and Prometheus. This three-type taxonomy with pluggable export aligns with the Prometheus data model and enables Envoy to serve as a universal metrics source in service mesh deployments.

## Source Lineage
- Task ID: 20260401-fix-val-04
- Task Learning Record: mind/learning/task-learning/tl-20260401-fix-val-04.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-04-envoy-stats-system.md
- Review File: mind/learning/reviews/review-20260401-fix-val-04-envoy-stats-system.md
- Original Source Anchor: tasks/20260401-fix-val-04/acquire/raw-sources/src-001-envoy-statistics.md
- Original Source URL: https://www.envoyproxy.io/docs/envoy/latest/intro/arch_overview/observability/statistics

## Key Evidence
> "Envoy emits a large number of statistics depending on how the server is configured. Statistics fall into three categories:\n\n- **Counter** — Unsigned integers that only increase (e.g., total requests). Counters represent monotonically increasing values.\n- **Gauge** — Unsigned integers that both increase and decrease (e.g., currently active requests). Gauges represent current state values.\n- **Histogram** — Unsigned integers that track value distributions (e.g., request latencies). Histograms capture the distribution of data over time.\n\nThese can be exported to stats sinks including:\n- StatsD\n- Prometheus\n- Others (configurable stats sink infrastructure)"

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-fix-val-04-envoy-stats-system.md

## Applicability
- Applies to: any Envoy proxy deployment requiring metrics collection and export; service mesh observability architectures using Envoy as the data plane proxy; monitoring system design where Envoy is the metrics source
- Does not apply to: non-Envoy proxy deployments; environments using in-process metrics libraries without Envoy; metrics systems that bypass the stats sink infrastructure (e.g., direct application-level metric emission)

## Notes
- Grounded in official Envoy project documentation (envoyproxy.io)
- Complements kb-concept-prometheus-dimensional-model.md for a complete picture of the Envoy-to-Prometheus metrics pipeline
