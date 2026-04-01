# Plan

## Task ID
- 20260401-pure-learning-test

## Goal
- Research the CAP theorem and produce a comprehensive knowledge artifact documenting its theoretical foundations, formal proof, and practical implications for distributed database design

## Runtime State
- tasks/20260401-pure-learning-test/state.md

## Global Constraints
- Knowledge Source Prohibition: search summaries and AI-generated overviews are not valid knowledge sources
- Default final result directory: tasks/20260401-pure-learning-test/_output/
- Soul constraints: evidence-based design, primary sources preferred, validate claims against known constraints

### Step 1
- Name: Research CAP Theorem via External Sources
- Goal: Acquire authoritative knowledge about the CAP theorem, its formal proof (Brewer's conjecture and Gilbert/Lynch proof), and practical implications for distributed database design
- Capability: web-research (informal — no formal capability definition exists)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-pure-learning-test/cache/step-1-cap-research.md
- Constraints: mind/soul/core.md, SYSTEM.md §Knowledge Source Prohibition
- Inputs: task-profile.md, analysis.md
- Outputs: tasks/20260401-pure-learning-test/cache/step-1-cap-research.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: cache/step-1-cap-research.md exists and contains verified information from at least 2 fetched external sources covering CAP theorem definition, proof, and practical implications
- Failure Policy: retry
- Instructions:
  1. Trigger Learning(Acquire) ACQ-001
  2. Stage 1 (Search): Use WebSearch for "CAP theorem distributed systems" to find authoritative sources
  3. Stage 2 (Fetch): Use WebFetch to retrieve content from at least 2 authoritative sources (prefer academic/authoritative: Gilbert & Lynch paper, established distributed systems references)
  4. Stage 3 (Verification): Dispatch independent verification subagent to verify source quality and factual consistency
  5. Write research summary to cache/step-1-cap-research.md with source attributions

### Step 2
- Name: Synthesize Knowledge Artifact
- Goal: Produce the final knowledge artifact documenting the CAP theorem analysis in _output/
- Capability: knowledge-synthesis (informal — no formal capability definition exists)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-pure-learning-test/_output/cap-theorem-analysis.md
- Constraints: mind/soul/core.md, knowledge must be traceable to verified sources from Step 1
- Inputs: tasks/20260401-pure-learning-test/cache/step-1-cap-research.md
- Outputs: tasks/20260401-pure-learning-test/_output/cap-theorem-analysis.md
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1
- Completion Criteria: _output/cap-theorem-analysis.md exists and contains sections covering CAP theorem definition, the three properties, proof sketch, practical trade-offs, and database classification examples
- Failure Policy: rework
- Instructions:
  1. Read cache/step-1-cap-research.md for all acquired research material
  2. Synthesize a structured analysis document covering: theorem definition, formal properties (C, A, P), proof sketch, practical trade-off analysis, examples of real databases classified by CAP choices, and brief mention of extensions (PACELC)
  3. Write to _output/cap-theorem-analysis.md
  4. Verify all claims are traceable to fetched sources

## Handoffs
- Step 1 produces cache/step-1-cap-research.md which is the sole input for Step 2
- Step 2 reads cache/step-1-cap-research.md and produces _output/cap-theorem-analysis.md

## Completion Check
- _output/cap-theorem-analysis.md exists and is non-empty
- cache/step-1-cap-research.md exists with source-attributed research
- All claims in the knowledge artifact are traceable to verified external sources
