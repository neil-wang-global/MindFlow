# Plan

## Task ID
- 20260401-concurrent-01

## Goal
- Systematically learn writing techniques across three sub-domains (narrative structure, rhetorical devices, persuasion techniques), acquire external knowledge for each, and produce a comprehensive research document.

## Runtime State
- the fixed runtime state file is: `tasks/20260401-concurrent-01/state.md`

## Global Constraints
- All created files must include task-id `20260401-concurrent-01` to avoid collisions
- Do not modify existing shared files (cu-*.md, gap-*.md, existing review-*.md scan histories)
- Append-only to `mind/learning/knowledge-base/approved/INDEX.md`
- Default final result directory: `tasks/20260401-concurrent-01/_output/`
- ACQ events are simulated (real web tools unavailable)

### Step 1
- Name: Acquire Narrative Structure Techniques
- Goal: Research and acquire knowledge about narrative structure techniques including story arcs, three-act structure, and in medias res
- Capability: research-acquisition
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-01/cache/step1-narrative-structure/`
- Constraints: `mind/soul/core.md` — prioritize primary sources, validate external claims
- Inputs: task goal, analysis.md sub-domain specification
- Outputs: `tasks/20260401-concurrent-01/cache/step1-narrative-structure/research-notes.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event triggered and completed; `cache/step1-narrative-structure/research-notes.md` exists with verified source content about narrative structure techniques; `acquire/` directory contains search-log.md, raw-sources/, and verification-report.md for this ACQ event
- Failure Policy: retry
- Instructions: 1) Identify knowledge gap for narrative structure techniques. 2) Trigger Learning(Acquire) — ACQ-001. 3) Execute simulated search for narrative structure (2 queries targeting story arcs, three-act structure, in medias res). 4) Fetch 2 sources. 5) Run verification (at least 1 source must pass). 6) Compile research notes from verified sources into cache output.

### Step 2
- Name: Acquire Rhetorical Devices Knowledge
- Goal: Research and acquire knowledge about rhetorical devices including metaphor, anaphora, parallelism, and antithesis
- Capability: research-acquisition
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-01/cache/step2-rhetorical-devices/`
- Constraints: `mind/soul/core.md` — prioritize primary sources, validate external claims
- Inputs: task goal, analysis.md sub-domain specification
- Outputs: `tasks/20260401-concurrent-01/cache/step2-rhetorical-devices/research-notes.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event triggered and completed; `cache/step2-rhetorical-devices/research-notes.md` exists with verified source content about rhetorical devices; `acquire/` directory contains search-log.md, raw-sources/, and verification-report.md for this ACQ event
- Failure Policy: retry
- Instructions: 1) Identify knowledge gap for rhetorical devices. 2) Trigger Learning(Acquire) — ACQ-002. 3) Execute simulated search for rhetorical devices (2 queries targeting metaphor, anaphora, parallelism, antithesis). 4) Fetch 2 sources. 5) Run verification (at least 1 source must pass). 6) Compile research notes from verified sources into cache output.

### Step 3
- Name: Acquire Persuasion Techniques Knowledge
- Goal: Research and acquire knowledge about persuasion techniques including ethos, pathos, logos, and Aristotelian appeals
- Capability: research-acquisition
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-01/cache/step3-persuasion-techniques/`
- Constraints: `mind/soul/core.md` — prioritize primary sources, validate external claims
- Inputs: task goal, analysis.md sub-domain specification
- Outputs: `tasks/20260401-concurrent-01/cache/step3-persuasion-techniques/research-notes.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event triggered and completed; `cache/step3-persuasion-techniques/research-notes.md` exists with verified source content about persuasion techniques; `acquire/` directory contains search-log.md, raw-sources/, and verification-report.md for this ACQ event
- Failure Policy: retry
- Instructions: 1) Identify knowledge gap for persuasion techniques. 2) Trigger Learning(Acquire) — ACQ-003. 3) Execute simulated search for persuasion techniques (2 queries targeting ethos, pathos, logos, Aristotelian appeals). 4) Fetch 2 sources. 5) Run verification (at least 1 source must pass). 6) Compile research notes from verified sources into cache output.

### Step 4
- Name: Synthesize Comprehensive Writing Techniques Document
- Goal: Compile all acquired knowledge from Steps 1-3 into a comprehensive research document covering all three writing technique sub-domains
- Capability: document-synthesis
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-concurrent-01/_output/`
- Constraints: `mind/soul/core.md` — evidence-based design, prefer clear state machines over ad-hoc logic (applied as: structured document with clear sections)
- Inputs: `cache/step1-narrative-structure/research-notes.md`, `cache/step2-rhetorical-devices/research-notes.md`, `cache/step3-persuasion-techniques/research-notes.md`
- Outputs: `tasks/20260401-concurrent-01/_output/writing-techniques-research.md`
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1, Step 2, Step 3
- Completion Criteria: `_output/writing-techniques-research.md` exists; document contains sections on all three sub-domains; each section references verified sources
- Failure Policy: rework
- Instructions: 1) Read all three research notes from cache. 2) Structure a comprehensive document with sections for narrative structure, rhetorical devices, and persuasion techniques. 3) Include source citations for all acquired knowledge. 4) Write to `_output/writing-techniques-research.md`.

## Handoffs
- Step 1 → Step 4: `cache/step1-narrative-structure/research-notes.md`
- Step 2 → Step 4: `cache/step2-rhetorical-devices/research-notes.md`
- Step 3 → Step 4: `cache/step3-persuasion-techniques/research-notes.md`
- Steps 1, 2, 3 are independent of each other; Step 4 depends on all three

## Completion Check
- All four Steps completed successfully
- `_output/writing-techniques-research.md` exists and covers all three sub-domains
- Three separate ACQ events (ACQ-001, ACQ-002, ACQ-003) completed with verified sources
- `state.md` shows Overall Status: running (to be transitioned by Execution Control)
