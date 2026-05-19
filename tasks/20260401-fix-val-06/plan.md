# Plan

## Task ID
- 20260401-fix-val-06

## Goal
- Systematically acquire verified knowledge about four narrative writing techniques: foreshadowing/Chekhov's gun, unreliable narrator, stream of consciousness, and frame narrative.

## Runtime State
- `tasks/20260401-fix-val-06/state.md`

## Global Constraints
- Default final result directory: `tasks/20260401-fix-val-06/_output/`
- All ACQ events must follow the three-stage pipeline: search, fetch/preserve, verify
- Soul Learning Policy applies: primary sources preferred, validate claims, evidence-based rigor
- Knowledge Source Prohibition: search summaries and AI-generated overviews are not valid sources

### Step 1
- Name: Foreshadowing and Chekhov's Gun
- Goal: Acquire and verify knowledge about foreshadowing as a narrative technique and Chekhov's gun principle as its specific formalization
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-06/cache/step-1-foreshadowing/`
- Constraints: `mind/soul/core.md`, `tasks/20260401-fix-val-06/analysis.md`
- Inputs: task goal statement; analysis.md Step 1 definition
- Outputs: `tasks/20260401-fix-val-06/cache/step-1-foreshadowing/` (ACQ raw sources, search log, verification report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event completes with at least 1 verified source; verification report exists in cache/step-1-foreshadowing/
- Failure Policy: rework
- Instructions:
  1. Search for authoritative sources on foreshadowing technique and Chekhov's gun principle (target literary criticism, writing craft books, academic literary analysis)
  2. Fetch and preserve at least 2 candidate sources
  3. Verify source content accuracy via independent subagent
  4. Record all ACQ artifacts in the step's output isolation directory

### Step 2
- Name: Unreliable Narrator Technique
- Goal: Acquire and verify knowledge about unreliable narrator technique, including Wayne Booth's original taxonomy and the technique's effects on reader experience
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-06/cache/step-2-unreliable-narrator/`
- Constraints: `mind/soul/core.md`, `tasks/20260401-fix-val-06/analysis.md`
- Inputs: task goal statement; analysis.md Step 2 definition
- Outputs: `tasks/20260401-fix-val-06/cache/step-2-unreliable-narrator/` (ACQ raw sources, search log, verification report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event completes with at least 1 verified source; verification report exists in cache/step-2-unreliable-narrator/
- Failure Policy: rework
- Instructions:
  1. Search for authoritative sources on unreliable narrator (target Wayne Booth's "The Rhetoric of Fiction", literary criticism, narratology scholarship)
  2. Fetch and preserve at least 2 candidate sources
  3. Verify source content accuracy via independent subagent
  4. Record all ACQ artifacts in the step's output isolation directory

### Step 3
- Name: Stream of Consciousness Writing Style
- Goal: Acquire and verify knowledge about stream of consciousness writing, its psychological/literary origins (William James, Edouard Dujardin), and key practitioners (Virginia Woolf, James Joyce, William Faulkner)
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-06/cache/step-3-stream-of-consciousness/`
- Constraints: `mind/soul/core.md`, `tasks/20260401-fix-val-06/analysis.md`
- Inputs: task goal statement; analysis.md Step 3 definition
- Outputs: `tasks/20260401-fix-val-06/cache/step-3-stream-of-consciousness/` (ACQ raw sources, search log, verification report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event completes with at least 1 verified source; verification report exists in cache/step-3-stream-of-consciousness/
- Failure Policy: rework
- Instructions:
  1. Search for authoritative sources on stream of consciousness literary technique (target literary history, modernist literature criticism, psychological basis in William James)
  2. Fetch and preserve at least 2 candidate sources
  3. Verify source content accuracy via independent subagent
  4. Record all ACQ artifacts in the step's output isolation directory

### Step 4
- Name: Frame Narrative Structure
- Goal: Acquire and verify knowledge about frame narrative / story-within-a-story structure, including historical examples (Canterbury Tales, Arabian Nights, Frankenstein) and structural mechanics
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-06/cache/step-4-frame-narrative/`
- Constraints: `mind/soul/core.md`, `tasks/20260401-fix-val-06/analysis.md`
- Inputs: task goal statement; analysis.md Step 4 definition
- Outputs: `tasks/20260401-fix-val-06/cache/step-4-frame-narrative/` (ACQ raw sources, search log, verification report)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event completes with at least 1 verified source; verification report exists in cache/step-4-frame-narrative/
- Failure Policy: rework
- Instructions:
  1. Search for authoritative sources on frame narrative / story-within-a-story (target narratology scholarship, literary criticism of frame tales, structural analysis)
  2. Fetch and preserve at least 2 candidate sources
  3. Verify source content accuracy via independent subagent
  4. Record all ACQ artifacts in the step's output isolation directory

## Step Independence Matrix

| Step Pair | Distinction | Overlap Assessment |
|-----------|------------|-------------------|
| Step 1 vs Step 2 | Step 1 targets foreshadowing (a plot-level technique for planting future event hints) and Chekhov's gun (a specific economy-of-detail principle); Step 2 targets unreliable narrator (a character/voice-level technique affecting reader trust and perception). Different narrative layers: plot mechanics vs narrator reliability. | no-overlap |
| Step 1 vs Step 3 | Step 1 targets foreshadowing/Chekhov's gun (plot-level hint planting); Step 3 targets stream of consciousness (a prose style rendering inner mental experience). Different domains: narrative structure vs prose technique/style. | no-overlap |
| Step 1 vs Step 4 | Step 1 targets foreshadowing/Chekhov's gun (within-story event signaling); Step 4 targets frame narrative (multi-layered story embedding structure). Different scope: intra-story technique vs inter-story architecture. | no-overlap |
| Step 2 vs Step 3 | Step 2 targets unreliable narrator (narrator trustworthiness and its cognitive effects on the reader); Step 3 targets stream of consciousness (interior monologue prose technique). Both relate to narrative voice but from distinct angles: reliability/trust vs stylistic rendering of thought. | low-overlap |
| Step 2 vs Step 4 | Step 2 targets unreliable narrator (narrator credibility); Step 4 targets frame narrative (nested story structure). Different concerns: voice reliability vs structural nesting. A frame narrative may use an unreliable narrator, but the concepts are independently defined. | no-overlap |
| Step 3 vs Step 4 | Step 3 targets stream of consciousness (interior prose technique); Step 4 targets frame narrative (story-within-a-story structure). Different domains entirely: prose style vs narrative architecture. | no-overlap |

## Handoffs
- Step 1 -> Step 2: no data dependency; sequential ordering is for ACQ event management only
- Step 2 -> Step 3: no data dependency; sequential ordering is for ACQ event management only
- Step 3 -> Step 4: no data dependency; sequential ordering is for ACQ event management only
- All step outputs are isolated in their respective `cache/step-N-*/` directories
- Terminal Learning consolidates all ACQ results into `_output/`

## Completion Check
- All 4 Steps complete with verified ACQ events
- All 4 verification reports exist in their respective cache directories
- state.md shows all 4 Steps as `completed`
- Knowledge Outcome set by terminal Learning based on ACQ results
