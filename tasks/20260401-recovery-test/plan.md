# Plan

## Task ID
- 20260401-recovery-test

## Goal
- Produce a complete 3-tier caching strategy design for an API gateway, covering cache layers, eviction policies, invalidation, TTL management, and consistency guarantees

## Runtime State
- the fixed runtime state file is: tasks/20260401-recovery-test/state.md

## Global Constraints
- mind/soul/core.md — resilience over raw performance, evidence-based design, explicit failure handling
- default final result directory: tasks/20260401-recovery-test/_output/

### Step 1
- Name: Define Cache Layers
- Goal: Define the three cache layers (edge, application, data) with distinct responsibilities
- Capability: system-design
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-recovery-test/cache/step-1-cache-layers.md
- Constraints: mind/soul/core.md
- Inputs: tasks/20260401-recovery-test/task-profile.md
- Outputs: tasks/20260401-recovery-test/cache/step-1-cache-layers.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: file cache/step-1-cache-layers.md exists and contains definitions for all three layers (edge, application, data) with distinct responsibilities stated for each
- Failure Policy: retry
- Instructions: Define each of the three cache layers. For each layer, specify its position in the request path, what it caches, its scope (per-user vs shared), and its primary purpose. Ensure layer responsibilities do not overlap.

### Step 2
- Name: Design Eviction Policies
- Goal: Design eviction policies for each cache layer with rationale
- Capability: system-design
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-recovery-test/cache/step-2-eviction-policies.md
- Constraints: mind/soul/core.md
- Inputs: tasks/20260401-recovery-test/cache/step-1-cache-layers.md
- Outputs: tasks/20260401-recovery-test/cache/step-2-eviction-policies.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: file cache/step-2-eviction-policies.md exists and contains an eviction policy for each of the three layers with rationale explaining why that policy was chosen
- Failure Policy: retry
- Instructions: For each cache layer defined in Step 1, design an appropriate eviction policy. Consider LRU, LFU, TTL-based, and hybrid approaches. Justify each choice based on the layer's characteristics. Address cache warming and cold-start scenarios.

### Step 3
- Name: Write Final Design Document
- Goal: Synthesize all prior work into a coherent final caching strategy design
- Capability: technical-writing
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-recovery-test/_output/caching-strategy.md
- Constraints: mind/soul/core.md
- Inputs: tasks/20260401-recovery-test/cache/step-1-cache-layers.md, tasks/20260401-recovery-test/cache/step-2-eviction-policies.md
- Outputs: tasks/20260401-recovery-test/_output/caching-strategy.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1, Step 2
- Completion Criteria: file _output/caching-strategy.md exists and covers cache layers, eviction policies, invalidation strategy, TTL management, and consistency guarantees
- Failure Policy: retry
- Instructions: Combine the cache layer definitions and eviction policies into a unified design document. Add sections on cache invalidation patterns, TTL management strategy, and consistency guarantees across layers. Ensure the document is self-contained and actionable.

## Handoffs
- Step 1 produces cache/step-1-cache-layers.md, consumed by Step 2 and Step 3
- Step 2 produces cache/step-2-eviction-policies.md, consumed by Step 3
- Step 3 produces _output/caching-strategy.md as the final deliverable

## Completion Check
- cache/step-1-cache-layers.md exists with three distinct cache layer definitions
- cache/step-2-eviction-policies.md exists with per-layer eviction policies
- _output/caching-strategy.md exists and covers layers, eviction, invalidation, TTL, and consistency
