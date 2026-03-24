# Research and Summarize (Example)

This file is an example showing how to fill in a Capability definition. It is not loaded by the runtime as an actual capability.

## Purpose
- Research a specified topic using available knowledge and external sources, then produce a structured summary

## Use When
- A Step requires gathering and organizing information on a defined topic before design or implementation begins

## Do Not Use When
- The required information is already available in `Learning(Read)` output or task cache
- The Step requires implementation, not research

## Inputs
- required: the topic description from the current Step's instructions
- required: `tasks/{task-id}/learning-read.md` (to avoid duplicating already-loaded knowledge)
- optional: `tasks/{task-id}/cache/` (prior Step outputs that narrow the research scope)
- input format: markdown text

## Constraints
- `mind/soul/core.md` — respect methodology preference and learning policy
- the current Step's declared constraints
- must not use search summaries as knowledge sources (see `Learning(Acquire)` rules)

## Outputs
- `tasks/{task-id}/cache/step-{N}-research-summary.md`
- output purpose: structured summary of findings, organized by sub-topic, with source references

## Step Contract
- the Step must provide: topic description, scope boundaries, and maximum number of sources to consult
- the Step can expect: a markdown file with organized findings and explicit source references

## Execution Rules
- must read all declared constraint files before starting
- must not fabricate sources or citations
- must not overwrite existing cache files from other Steps
- may append to existing research summaries if the Step declares incremental research

## Skill Loading
- skill loading is allowed
- may load web search or web fetch skills
- loaded skills must not bypass the constraint that search summaries are not valid knowledge sources

## Failure Handling
- failure: no relevant sources found after exhausting search queries
- on failure: write a partial output file documenting what was searched and why no results were found
- partial completion: allowed — a partial summary with fewer sources than requested is valid if documented

## Observability
- success: output file exists in `cache/` with at least one structured finding
- signals to record: number of sources consulted, number of findings produced, whether any search queries returned zero results

## Known Failure Patterns
- overly broad topics lead to unfocused summaries — mitigate by requiring scope boundaries in Step instructions
- paywalled or inaccessible sources — mitigate by recording failures and moving to next candidate

## Parallel Safety
- safe for parallel execution when each parallel instance targets a different sub-topic
- isolation required: each instance must write to a distinct output file (e.g. `step-{N}-research-{sub-topic}.md`)
