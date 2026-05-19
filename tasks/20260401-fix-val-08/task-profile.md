# Task Profile

## Task ID
- 20260401-fix-val-08

## Task Type
- learning

## Goal
- Learn about the OpenTelemetry Collector architecture, specifically the receiver/processor/exporter pipeline model and how it enables vendor-agnostic telemetry collection. Produce a knowledge artifact documenting the pipeline architecture, component roles, and the design principles that enable vendor neutrality.

## Inputs
- Approved KB: `kb-concept-otel-log-severity.md` (OTel severity model)
- Approved KB: `kb-concept-w3c-traceparent-format.md` (W3C trace propagation)
- Soul constraints: `mind/soul/core.md`

## Success Criteria
- Knowledge Outcome = `fully-acquired`
- Overall Status = `completed`
- A knowledge artifact describing the OTel Collector receiver/processor/exporter pipeline is produced in `_output/`
- ACQ verification subagent and terminal Learning review subagent both dispatched with `mind/soul/core.md` included in their prompts
- `cache/subagent-dispatch-log.md` records soul inclusion for each subagent dispatch

## Complexity
- low

## Risk
- low

## Capability Needs
- Web research for official OpenTelemetry documentation
- Technical writing for knowledge artifact production

## Constraints
- Soul Learning Policy: prioritize primary sources (official opentelemetry.io documentation)
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid knowledge sources
- All subagent dispatches must include `mind/soul/core.md` content per Subagent Soul Constraint
- No git commits

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected

## Notes
- This task validates the Subagent Soul Constraint by requiring soul/core.md inclusion in every subagent dispatch
