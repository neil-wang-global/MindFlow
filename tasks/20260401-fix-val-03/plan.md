# Plan

## Task ID
- 20260401-fix-val-03

## Goal
- Acquire knowledge on Raft leader election mechanism (expected success) and QuantumDB X9 memory management (expected exhaustion), producing Knowledge Outcome: partially-acquired

## Runtime State
- `tasks/20260401-fix-val-03/state.md`

## Global Constraints
- Soul Learning Policy: prioritize primary sources; Raft paper is the canonical source
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid sources
- Default final result directory: `tasks/20260401-fix-val-03/_output/`
- Each ACQ event must follow the full Learning(Acquire) pipeline (search, fetch, preserve, verify)
- Subagent dispatches must include `mind/soul/core.md` content

### Step 1
- Name: Acquire Raft Leader Election Knowledge
- Goal: Acquire detailed knowledge about Raft's leader election mechanism from the original Raft paper
- Capability: web-search
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-03/acquire/` for ACQ-001 search-log, raw-sources, verification-report
- Constraints: `mind/soul/core.md`, `mind/learning/README.md` (Learning Acquire rules)
- Inputs: existing knowledge from `kb-concept-raft-consensus.md` (high-level Raft decomposition), task goal statement
- Outputs: `tasks/20260401-fix-val-03/acquire/search-log.md` (ACQ-001 entries), `tasks/20260401-fix-val-03/acquire/raw-sources/` (preserved source content), `tasks/20260401-fix-val-03/acquire/verification-report.md` (ACQ-001 verification)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ-001 search-log contains at least 1 search query with results; at least 1 raw source file preserved in `acquire/raw-sources/`; verification-report contains ACQ-001 entry with pass/fail determination; state.md Learning(Acquire) Log updated with ACQ-001 outcome
- Failure Policy: rework
- Instructions: 1. Search for the Raft consensus paper (Ongaro & Ousterhout, 2014) focusing on leader election mechanism. 2. Fetch the Raft paper or authoritative Raft documentation covering election timeout, RequestVote RPC, term numbers, and split vote handling. 3. Preserve the raw source content. 4. Dispatch independent subagent for Stage 3 verification (subagent prompt must include `mind/soul/core.md` content). 5. Record ACQ-001 outcome in state.md Learning(Acquire) Log.

### Step 2
- Name: Acquire QuantumDB X9 Memory Management Knowledge
- Goal: Attempt to acquire knowledge about QuantumDB X9 internal memory management algorithm; expected to exhaust since this is a fictional product
- Capability: web-search
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-03/acquire/` for ACQ-002 search-log entries, raw-sources (if any), verification-report entries
- Constraints: `mind/soul/core.md`, `mind/learning/README.md` (Learning Acquire rules)
- Inputs: task goal statement specifying QuantumDB X9 memory management
- Outputs: `tasks/20260401-fix-val-03/acquire/search-log.md` (ACQ-002 entries appended), `tasks/20260401-fix-val-03/acquire/verification-report.md` (ACQ-002 entries if sources found)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1 (sequential ACQ label ordering)
- Completion Criteria: ACQ-002 search-log contains at least 2 search queries demonstrating thorough search effort; ACQ-002 outcome recorded in state.md Learning(Acquire) Log as either `completed` or `exhausted`; if exhausted, explicit exhaustion reason documented
- Failure Policy: stop
- Instructions: 1. Search for "QuantumDB X9 memory management algorithm" and variants. 2. If no relevant sources found, perform a second search with alternative terms (e.g., "QuantumDB X9 internal architecture", "QuantumDB X9 documentation"). 3. If sources are found, fetch and verify them. 4. If all sources fail or no sources exist, formally exhaust ACQ-002 with documented reason. 5. Record ACQ-002 outcome in state.md Learning(Acquire) Log.

## Handoffs
- Step 1 writes ACQ-001 artifacts to `acquire/` directory; Step 2 appends ACQ-002 artifacts to the same directory
- Both Steps update `state.md §Learning(Acquire) Log` sequentially

## Completion Check
- state.md Learning(Acquire) Log contains entries for both ACQ-001 and ACQ-002
- ACQ-001 completed successfully (at least 1 verified source preserved)
- ACQ-002 formally exhausted with documented reason
- Both Steps marked as completed in Step Status Map
