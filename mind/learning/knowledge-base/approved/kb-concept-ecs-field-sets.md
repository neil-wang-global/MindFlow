# Knowledge Base Entry

## Type
- concept

## Summary
- ECS provides a two-tier field system (core and extended) with typed field definitions grouped into logical field sets (Base, Log, Trace, Service, Error, Host, Event). Fields use dot notation for nesting and lowercase with underscores for multi-word names. This hierarchical schema enables consistent cross-source correlation.

## Source Lineage
- Task ID: 20260401-concurrent-08
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-08.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-08-ecs-field-sets.md
- Review File: mind/learning/reviews/review-20260401-concurrent-08-ecs-field-sets.md
- Original Source Anchor: tasks/20260401-concurrent-08/acquire/raw-sources/src-001-ecs-field-reference.md
- Original Source URL: https://www.elastic.co/guide/en/ecs/current/ecs-reference.html

## Key Evidence
> "ECS specifies field names and Elasticsearch datatypes for each field, and provides descriptions and example values. ECS also groups fields into ECS levels (core and extended) to indicate the level of adoption and stability."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-08-ecs-field-sets.md

## Applicability
- Applies to: any system using Elasticsearch for log storage; any structured logging implementation that needs a standardized field schema; cross-service log correlation scenarios
- Does not apply to: proprietary logging formats that intentionally deviate from ECS; systems not using Elasticsearch or OpenTelemetry-compatible tools

## Notes
- ECS is converging with OpenTelemetry Semantic Conventions; future field alignment may further simplify interoperability
