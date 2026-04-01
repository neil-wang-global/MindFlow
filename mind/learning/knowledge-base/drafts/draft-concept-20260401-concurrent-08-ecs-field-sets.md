# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-08

## Summary
- ECS provides a two-tier field system (core and extended) with typed field definitions grouped into logical field sets, using dot notation and lowercase naming

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-08.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-08/acquire/raw-sources/src-001-ecs-field-reference.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-08/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "ECS specifies field names and Elasticsearch datatypes for each field, and provides descriptions and example values. ECS also groups fields into ECS levels (core and extended) to indicate the level of adoption and stability."

## Candidate Conclusion
- ECS provides a two-tier field system (core and extended) with typed field definitions grouped into logical field sets (Base, Log, Trace, Service, Error, Host, Event). Fields use dot notation for nesting and lowercase with underscores for multi-word names. This hierarchical schema enables consistent cross-source correlation.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-08-ecs-field-sets.md

## Notes
- none
