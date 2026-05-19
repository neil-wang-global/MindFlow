# Plan

## Task ID
- 20260401-fix-val-02

## Goal
- Attempt to acquire knowledge about Google Zanzibar's undocumented internal sharding algorithm; exhaust all reasonable acquisition attempts; formally record the knowledge gap and produce a research summary documenting the boundary between public and proprietary Zanzibar knowledge

## Runtime State
- tasks/20260401-fix-val-02/state.md

## Global Constraints
- Default final result directory: tasks/20260401-fix-val-02/_output/
- Knowledge Source Prohibition applies: search summaries, snippets, and AI-generated overviews are not valid knowledge sources
- Soul Learning Policy: prioritize primary sources; validate external claims against known constraints
- No publish-back to sources/ is needed for this task

### Step 1
- Name: Review pending capability updates
- Goal: Review the 4 pending capability update files (1 proposed, 3 approved) that exceed the 3+ mandatory plan step threshold
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-fix-val-02/cache/
- Constraints: mind/soul/core.md, SYSTEM.md Capability Update Advancement rules
- Inputs: cu-20260401-failure-test-cap-benchmarking.md (proposed), cu-20260326-cap-schema-design.md (approved), cu-20260327-cap-api-gateway.md (approved), cu-20260325-cap-load-testing.md (approved)
- Outputs: tasks/20260401-fix-val-02/cache/cu-review-summary.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: all 4 pending CU files have been reviewed; a cu-review-summary.md exists in cache/ documenting the review decision for each file
- Failure Policy: escalate-to-reflection
- Instructions: Read each of the 4 pending capability update files. For the 3 approved items (cap-schema-design, cap-api-gateway, cap-load-testing), assess whether they can be advanced to applied status — this requires creating the target capability files. Since no capability files currently exist in capabilities/, and creating capability files is outside the scope of a Zanzibar learning task, document that these remain in approved status awaiting a dedicated task. For the proposed item (cap-benchmarking), assess whether it can be advanced to approved — since the external tool dependency cannot be validated in this context, document that it remains proposed. Write a summary to cache/cu-review-summary.md.

### Step 2
- Name: Research Zanzibar internal sharding algorithm
- Goal: Search for primary sources documenting Google Zanzibar's undocumented internal sharding algorithm; attempt to fetch and verify any candidate sources; exhaust all reasonable acquisition strategies
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-fix-val-02/cache/ and tasks/20260401-fix-val-02/_output/
- Constraints: mind/soul/core.md, SYSTEM.md Knowledge Source Prohibition
- Inputs: task-profile.md, analysis.md
- Outputs: tasks/20260401-fix-val-02/cache/ (search logs, acquisition artifacts)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: at least 2 distinct search strategies have been attempted; all ACQ events are either completed or exhausted; acquisition artifacts (search-log.md) exist in the acquire/ directory
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) to search for primary sources about Zanzibar's internal sharding algorithm. Use multiple search strategies: (1) search for the original Zanzibar paper and any follow-up publications, (2) search for Google engineering blog posts about Zanzibar internals, (3) search for any technical deep-dives into Zanzibar sharding specifically. For each candidate source, attempt to fetch and verify. If no verifiable primary source contains the target knowledge (the undocumented internal sharding algorithm), record the ACQ event as exhausted. Do not accept speculative or AI-generated content. Do not conflate publicly documented Zanzibar architecture with the undocumented internal sharding details.

### Step 3
- Name: Produce research summary
- Goal: Produce a research summary documenting what was attempted, what was found (or not found), and the knowledge boundary between public Zanzibar documentation and proprietary internals
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-fix-val-02/_output/
- Constraints: mind/soul/core.md
- Inputs: Step 2 acquisition results (cache/ artifacts)
- Outputs: tasks/20260401-fix-val-02/_output/research-summary.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 2
- Completion Criteria: research-summary.md exists in _output/ and documents the acquisition attempts, their outcomes, and the public/proprietary knowledge boundary
- Failure Policy: escalate-to-reflection
- Instructions: Based on Step 2 results, write a research summary in _output/research-summary.md. Document: (1) what search strategies were used, (2) what sources were found, (3) why the target knowledge could not be acquired, (4) what IS publicly known about Zanzibar (from the 2019 USENIX ATC paper) vs what remains proprietary. This serves as the knowledge artifact for this learning task.

## Handoffs
- Step 1 produces cache/cu-review-summary.md (no downstream dependency from Step 2 or 3)
- Step 2 produces acquisition artifacts in cache/ and acquire/; these are consumed by Step 3
- Step 3 produces the final output in _output/research-summary.md

## Completion Check
- cache/cu-review-summary.md exists
- All ACQ events from Step 2 are recorded in state.md Learning(Acquire) Log
- _output/research-summary.md exists
- state.md reflects the final task outcome
