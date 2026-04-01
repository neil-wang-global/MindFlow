# Plan

## Task ID
- 20260401-concurrent-30

## Goal
- Research distributed coordination mechanisms (leader election algorithms and distributed locking) through two separate ACQ events, produce a consolidated research document, and promote verified knowledge through the full pipeline

## Runtime State
- the fixed runtime state file is: `tasks/20260401-concurrent-30/state.md`

## Global Constraints
- default final result directory: `tasks/20260401-concurrent-30/_output/`
- ACQ labels (ACQ-001, ACQ-002) must be consistent across state.md, search-log.md, verification-report.md, and tl-{task-id}.md
- All source IDs must be unique across ACQ events
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid sources
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md

### Step 1
- Name: Research Leader Election Algorithms
- Goal: Acquire and verify knowledge about leader election algorithms (Bully algorithm, Ring algorithm) through external source acquisition
- Capability: none (no capability definition files exist)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-30/cache/step-1-leader-election-notes.md`
- Constraints: `mind/soul/core.md` (primary source preference, evidence-based design)
- Inputs: task-profile.md, analysis.md
- Outputs: `tasks/20260401-concurrent-30/cache/step-1-leader-election-notes.md`, ACQ-001 artifacts in `tasks/20260401-concurrent-30/acquire/`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ-001 search-log section exists in `acquire/search-log.md` with at least 2 queries; ACQ-001 verification-report section exists in `acquire/verification-report.md` with at least 2 sources verified; `cache/step-1-leader-election-notes.md` exists with synthesized findings about Bully and Ring algorithms
- Failure Policy: escalate-to-reflection
- Instructions: 1. Trigger Learning(Acquire) as ACQ-001. 2. Search for primary sources on Bully algorithm and Ring algorithm for leader election. 3. Fetch and verify sources per acquire module rules. 4. Synthesize findings into step-1-leader-election-notes.md covering algorithm mechanics, failure modes, and comparison.

### Step 2
- Name: Research Distributed Locking and Produce Output
- Goal: Acquire and verify knowledge about distributed locking (Redlock, Chubby, ZooKeeper locks) through external source acquisition, then produce the consolidated research output
- Capability: none (no capability definition files exist)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-30/cache/step-2-distributed-locking-notes.md`, `tasks/20260401-concurrent-30/_output/distributed-coordination-research.md`
- Constraints: `mind/soul/core.md` (primary source preference, evidence-based design)
- Inputs: task-profile.md, analysis.md, `tasks/20260401-concurrent-30/cache/step-1-leader-election-notes.md`
- Outputs: `tasks/20260401-concurrent-30/cache/step-2-distributed-locking-notes.md`, `tasks/20260401-concurrent-30/_output/distributed-coordination-research.md`, ACQ-002 artifacts in `tasks/20260401-concurrent-30/acquire/`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: ACQ-002 search-log section exists in `acquire/search-log.md`; ACQ-002 verification-report section exists in `acquire/verification-report.md`; `cache/step-2-distributed-locking-notes.md` exists with findings on distributed locking; `_output/distributed-coordination-research.md` exists covering both leader election and distributed locking topics
- Failure Policy: escalate-to-reflection
- Instructions: 1. Trigger Learning(Acquire) as ACQ-002. 2. Search for primary sources on Redlock, Chubby, and ZooKeeper locks. 3. Fetch and verify sources per acquire module rules. 4. Synthesize findings into step-2-distributed-locking-notes.md. 5. Combine Step 1 and Step 2 findings into the final output document `_output/distributed-coordination-research.md`.

## Handoffs
- Step 1 produces `cache/step-1-leader-election-notes.md` which Step 2 reads as input for the consolidated output
- Both steps write to the shared `acquire/` directory with separate ACQ sections (ACQ-001 for Step 1, ACQ-002 for Step 2)

## Completion Check
- `_output/distributed-coordination-research.md` exists and covers both leader election and distributed locking
- ACQ-001 and ACQ-002 both recorded in `state.md §Learning(Acquire) Log`
- `acquire/search-log.md` has sections for both ACQ-001 and ACQ-002
- `acquire/verification-report.md` has sections for both ACQ-001 and ACQ-002
- All source IDs are unique across ACQ events
