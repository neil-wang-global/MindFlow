# Plan

## Task ID
- 20260401-concurrent-09

## Goal
- Acquire structured knowledge about feature toggle categorization taxonomy (release, experiment, ops, permission toggles) and produce a feature flag system design document that applies this taxonomy.

## Runtime State
- tasks/20260401-concurrent-09/state.md

## Global Constraints
- Default final result directory: tasks/20260401-concurrent-09/_output/
- Concurrency rules: do not modify existing shared files; all created files must include task-id
- Soul constraints: resilience over raw performance, evidence-based design, explicit failure handling
- Fixed promotion path for acquired knowledge: task-learning/ -> drafts/ -> reviews/ -> knowledge-base/approved/

### Step 1
- Name: Research feature toggle categorization
- Goal: Acquire external knowledge about the four categories of feature toggles (release toggles, experiment toggles, ops toggles, permission toggles) via Learning(Acquire)
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-09/cache/ (ACQ artifacts: search-log, raw sources, verification report)
- Constraints: mind/soul/core.md (learning policy: prioritize primary sources, validate external claims)
- Inputs: task statement specifying toggle categorization taxonomy
- Outputs: tasks/20260401-concurrent-09/cache/ (verified knowledge about toggle categorization)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event triggered and completed (search-log.md exists in acquire/, at least one source verified in verification-report.md, or knowledge gap filed if exhausted)
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) to research feature toggle categorization. Search for primary sources on toggle taxonomy — the canonical reference is Martin Fowler's "Feature Toggles" article which defines release toggles, experiment toggles, ops toggles, and permission toggles. Verify acquired sources per ACQ Stage 3. Record all ACQ artifacts in the acquire/ subdirectory.

### Step 2
- Name: Design feature flag system
- Goal: Produce a feature flag system design document applying the toggle categorization taxonomy
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-09/_output/feature-flag-system.md
- Constraints: mind/soul/core.md (values: resilience over raw performance, operational simplicity); acquired toggle taxonomy from Step 1
- Inputs: Step 1 ACQ artifacts (verified toggle categorization knowledge), mind/soul/core.md
- Outputs: tasks/20260401-concurrent-09/_output/feature-flag-system.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/feature-flag-system.md exists and contains: system architecture, toggle categorization section covering all four toggle types, lifecycle management, and evaluation criteria
- Failure Policy: rework
- Instructions: Using the toggle categorization knowledge acquired in Step 1, design a feature flag system. The document must cover: (1) system architecture for flag storage, evaluation, and propagation; (2) toggle categorization (release, experiment, ops, permission) with lifecycle policies per category; (3) flag evaluation engine design; (4) operational considerations (monitoring, auditing, flag retirement). Apply Soul values: prefer resilience over raw performance, explicit failure handling for flag evaluation fallbacks.

## Handoffs
- Step 1 produces verified toggle categorization knowledge in cache/ (ACQ artifacts). Step 2 reads this knowledge to inform the design document in _output/.

## Completion Check
- _output/feature-flag-system.md exists with complete design content
- ACQ event was triggered in Step 1 (Learning(Acquire) Log in state.md records the event)
- All acquired knowledge is ready for terminal Learning promotion
