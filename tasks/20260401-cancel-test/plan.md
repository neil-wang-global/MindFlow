# Plan

## Task ID
- 20260401-cancel-test

## Goal
- Research distributed consensus algorithms (Paxos, Raft, PBFT) and produce a structured comparison document as a knowledge artifact

## Runtime State
- the fixed runtime state file is: `tasks/20260401-cancel-test/state.md`

## Global Constraints
- default final result directory: `tasks/20260401-cancel-test/_output/`
- Knowledge Source Prohibition: search summaries and AI-generated overviews are not valid knowledge sources
- Soul constraints not configured — no Soul constraints applied

### Step 1
- Name: Research Distributed Consensus Algorithms
- Goal: Acquire and verify external knowledge on Paxos, Raft, and PBFT consensus algorithms
- Capability: none (no capability definitions exist)
- Dispatch Mode: sequential
- Output Isolation: research artifacts in `tasks/20260401-cancel-test/cache/`
- Constraints: `mind/soul/core.md`, Knowledge Source Prohibition per SYSTEM.md
- Inputs: task goal from task-profile.md
- Outputs: `tasks/20260401-cancel-test/cache/consensus-research-notes.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: research notes file exists in cache/ covering at least three consensus algorithms with verified source references
- Failure Policy: escalate-to-reflection
- Instructions: Search for authoritative sources on Paxos, Raft, and PBFT. For each algorithm, identify the original paper or authoritative reference. Fetch and verify primary sources. Produce structured research notes in cache/.

### Step 2
- Name: Write Consensus Algorithm Comparison Document
- Goal: Synthesize research into a structured comparison document
- Capability: none (no capability definitions exist)
- Dispatch Mode: sequential
- Output Isolation: final document in `tasks/20260401-cancel-test/_output/`
- Constraints: `mind/soul/core.md`, output must be placed in `_output/`
- Inputs: `tasks/20260401-cancel-test/cache/consensus-research-notes.md`
- Outputs: `tasks/20260401-cancel-test/_output/consensus-algorithms-comparison.md`
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1
- Completion Criteria: comparison document exists in `_output/` covering Paxos, Raft, PBFT with trade-off analysis
- Failure Policy: rework
- Instructions: Using the verified research notes from Step 1, write a structured comparison document. Include sections on each algorithm's design, fault tolerance model, performance characteristics, and practical applications. Include a comparison table.

## Handoffs
- Step 1 produces `cache/consensus-research-notes.md` which Step 2 consumes as input
- Step 2 produces the final document in `_output/`

## Completion Check
- `tasks/20260401-cancel-test/_output/consensus-algorithms-comparison.md` exists
- Document covers at least three consensus algorithms with trade-off comparison
- All knowledge sources are verified primary sources
