# Plan

## Task ID
20260401-concurrent-03

## Goal
Produce three approved knowledge artifacts covering Raft, Paxos, and PBFT consensus algorithms.

## Runtime State
- `tasks/20260401-concurrent-03/state.md`

## Global Constraints
- Default final result directory: `tasks/20260401-concurrent-03/_output/`
- Knowledge Source Prohibition: no AI summaries as sources
- Soul constraint: primary sources required (original papers or authoritative references)

### Step 1
- Name: Acquire Raft Consensus Knowledge
- Goal: Acquire and verify external sources on Raft consensus algorithm
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-03/acquire/raw-sources/src-001-*, src-002-*`
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, analysis.md
- Outputs: `tasks/20260401-concurrent-03/acquire/raw-sources/src-001-raft-paper.md`, `tasks/20260401-concurrent-03/acquire/raw-sources/src-002-raft-overview.md`, entries in search-log.md and verification-report.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: Two raw source files exist in acquire/raw-sources/ for Raft; search-log.md contains ACQ-001 entry; verification-report.md contains ACQ-001 entry with all sources PASS
- Failure Policy: retry
- Instructions: Search for Raft consensus sources. Fetch two authoritative sources. Verify source quality and accuracy.

### Step 2
- Name: Acquire Paxos Consensus Knowledge
- Goal: Acquire and verify external sources on Paxos consensus algorithm
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-03/acquire/raw-sources/src-003-*, src-004-*`
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, analysis.md, Step 1 outputs
- Outputs: `tasks/20260401-concurrent-03/acquire/raw-sources/src-003-paxos-paper.md`, `tasks/20260401-concurrent-03/acquire/raw-sources/src-004-paxos-overview.md`, entries in search-log.md and verification-report.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: Two raw source files exist in acquire/raw-sources/ for Paxos; search-log.md contains ACQ-002 entry; verification-report.md contains ACQ-002 entry with all sources PASS
- Failure Policy: retry
- Instructions: Search for Paxos consensus sources. Fetch two authoritative sources. Verify source quality and accuracy.

### Step 3
- Name: Acquire PBFT Knowledge
- Goal: Acquire and verify external sources on PBFT consensus algorithm
- Capability: research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-03/acquire/raw-sources/src-005-*, src-006-*`
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, analysis.md, Step 1-2 outputs
- Outputs: `tasks/20260401-concurrent-03/acquire/raw-sources/src-005-pbft-paper.md`, `tasks/20260401-concurrent-03/acquire/raw-sources/src-006-pbft-overview.md`, entries in search-log.md and verification-report.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 2
- Completion Criteria: Two raw source files exist in acquire/raw-sources/ for PBFT; search-log.md contains ACQ-003 entry; verification-report.md contains ACQ-003 entry with all sources PASS
- Failure Policy: retry
- Instructions: Search for PBFT consensus sources. Fetch two authoritative sources. Verify source quality and accuracy.

## Handoffs
- Step 1 produces Raft sources → Step 2 builds on consensus vocabulary
- Step 2 produces Paxos sources → Step 3 extends to Byzantine model
- All steps share `acquire/` directory with unique source IDs

## Completion Check
- Six raw source files (src-001 through src-006) exist in acquire/raw-sources/
- search-log.md contains ACQ-001, ACQ-002, ACQ-003 entries
- verification-report.md contains three ACQ entries, all sources PASS
