# Task Profile

## Task ID
- 20260401-concurrent-02

## Task Type
- learning

## Goal
- Systematically learn three microservice design patterns: Saga (choreography vs orchestration, compensating transactions), CQRS (command-query separation, event sourcing integration), and Strangler Fig (incremental migration, anti-corruption layer). Each pattern requires external knowledge acquisition from primary sources followed by synthesis into reusable knowledge artifacts.

## Inputs
- `tasks/20260401-concurrent-02/learning-read.md` — audit of existing knowledge reads
- `mind/soul/core.md` — soul constraints (evidence-based, primary sources, quantitative benchmarks)
- Existing approved KB: `kb-concept-cap-impossibility.md`, `kb-concept-pacelc-extension.md`, `kb-concept-circuit-breaker-states.md` — foundational context for consistency trade-offs and state machine patterns

## Success Criteria
- Three distinct knowledge acquisition events completed, each covering one pattern
- Each ACQ event produces verified artifacts (search-log, raw-sources, verification-report)
- Knowledge promoted through the full pipeline: task-learning -> drafts -> reviews -> kb-*.md
- At least 3 kb-*.md files promoted to approved knowledge base
- INDEX.md updated with new entries

## Complexity
- high

## Risk
- medium

## Capability Needs
- web-search: locating primary sources on microservice patterns
- source-verification: validating content against claims
- knowledge-synthesis: distilling verified sources into structured knowledge artifacts

## Constraints
- Must use primary sources (academic papers, official documentation, production case studies) per Soul learning policy
- No search summaries or AI-generated overviews as knowledge sources (Knowledge Source Prohibition)
- Each pattern must be acquired independently with separate ACQ events
- Knowledge must follow the fixed promotion path: task-learning -> drafts -> reviews -> knowledge-base/approved

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — this is a straightforward learning task with well-defined pattern targets; no ambiguous decisions requiring formal inference

## Notes
- The three patterns cover complementary aspects of microservice architecture: Saga addresses distributed transaction coordination, CQRS addresses read/write optimization, and Strangler Fig addresses legacy system migration. Existing CAP/PACELC knowledge provides theoretical grounding for CQRS consistency decisions.
