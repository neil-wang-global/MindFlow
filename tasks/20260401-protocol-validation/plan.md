# Plan

## Task ID
- 20260401-protocol-validation

## Goal
- Execute a complete MindFlow protocol E2E, test Learning(Acquire) pipeline with real external search, and produce a validation report

## Runtime State
- the fixed runtime state file is: `tasks/20260401-protocol-validation/state.md`

## Global Constraints
- Must follow MindFlow protocol exactly — no shortcuts
- Soul constraints not configured — no Soul constraints apply
- Default final result directory: `tasks/20260401-protocol-validation/_output/`

### Step 1
- Name: Acquire external knowledge on token bucket algorithm
- Goal: Search for, fetch, and verify external knowledge about the token bucket rate limiting algorithm to test the full ACQ pipeline
- Capability: cap-research
- Dispatch Mode: sequential
- Output Isolation: writes only to `cache/step-1-research-notes.md`
- Constraints: `mind/soul/core.md`
- Inputs: `learning-read.md`, `task-profile.md`
- Outputs: `cache/step-1-research-notes.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: `cache/step-1-research-notes.md` exists and contains a summary of token bucket algorithm with at least one external source reference; `acquire/` directory contains search-log.md, at least one raw-source file, and verification-report.md
- Failure Policy: escalate-to-reflection
- Instructions: Search the web for "token bucket algorithm rate limiting". Fetch and preserve at least one source. Trigger Learning(Acquire) to process through all three stages (Search → Fetch & Preserve → Verification). Record research notes summarizing findings.

### Step 2
- Name: Validate artifacts and produce report
- Goal: Check all artifacts produced during this task against their TEMPLATE.md Validation Rules, and produce the final validation report
- Capability: cap-analysis
- Dispatch Mode: sequential
- Output Isolation: writes only to `_output/protocol-validation-report.md`
- Constraints: `mind/soul/core.md`
- Inputs: `learning-read.md`, `task-profile.md`, `analysis.md`, `plan.md`, `state.md`, `cache/step-1-research-notes.md`, `acquire/`
- Outputs: `_output/protocol-validation-report.md`
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1
- Completion Criteria: `_output/protocol-validation-report.md` exists and contains validation results for each artifact type produced during this task
- Failure Policy: retry
- Instructions: Read each artifact produced during this task. For each, check against its TEMPLATE.md Validation Rules. Record pass/fail for each rule. Document any protocol gaps, ambiguities, or issues found. Produce the final validation report.

## Handoffs
- Step 1 → Step 2: via `cache/step-1-research-notes.md` and `acquire/` directory contents

## Completion Check
- `_output/protocol-validation-report.md` exists with validation results
- All 2 Steps are marked completed in `state.md`
