# Plan

## Task ID
- 20260401-threshold-maintenance-test

## Goal
- Review and advance pending capability updates that exceed the 3+ threshold, then design an API rate limiter for distributed services.

## Runtime State
- the fixed runtime state file is: tasks/20260401-threshold-maintenance-test/state.md

## Global Constraints
- Soul constraints: resilience over raw performance, explicit failure handling, evidence-based design
- Default final result directory: tasks/20260401-threshold-maintenance-test/_output/
- Maintenance step must complete before the main deliverable per SYSTEM.md §Cross-Task Staleness Thresholds and §Capability Update Advancement

### Step 1
- Name: Review and advance pending capability updates
- Goal: Review 4 pending cu-*.md files. Advance valid proposals from proposed to approved. Update Scan History.
- Capability: none (protocol-internal maintenance)
- Dispatch Mode: sequential
- Output Isolation: mind/learning/capability-updates/cu-*.md files (in-place updates)
- Constraints: mind/soul/core.md, SYSTEM.md §Capability Update Advancement
- Inputs: mind/learning/capability-updates/cu-20260325-cap-load-testing.md, mind/learning/capability-updates/cu-20260326-cap-schema-design.md, mind/learning/capability-updates/cu-20260327-cap-api-gateway.md, mind/learning/capability-updates/cu-20260401-failure-test-cap-benchmarking.md
- Outputs: Updated cu-*.md files with Status changes and Scan History entries
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: At least 2 of the 4 cu-*.md files have Status changed from proposed to approved. All 4 files have Scan History entries for this task's maintenance review.
- Failure Policy: retry
- Instructions:
  1. Read each of the 4 cu-*.md files
  2. For each file, evaluate whether the proposed change is valid: check that Capability, Update Type, Reason, Source, Target Capability File, and Planned Changes are all coherent and justified
  3. For valid proposals: change Status from proposed to approved, add Scan History entry noting advancement
  4. For proposals that cannot be validated (e.g., missing critical information or unclear justification): keep Status as proposed, add Scan History entry explaining why advancement was deferred
  5. cu-20260401-failure-test-cap-benchmarking.md has scan count > 2 (staleness flag); note this in Scan History

### Step 2
- Name: Create API rate limiter design
- Goal: Produce a rate limiter design document covering algorithm selection, configuration options, failure handling, and operational concerns.
- Capability: API design patterns
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-threshold-maintenance-test/_output/rate-limiter-design.md
- Constraints: mind/soul/core.md; design must be grounded in approved KB token bucket knowledge
- Inputs: mind/learning/knowledge-base/approved/kb-concept-token-bucket-mechanism.md, mind/learning/knowledge-base/approved/kb-concept-token-leaky-equivalence.md
- Outputs: tasks/20260401-threshold-maintenance-test/_output/rate-limiter-design.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: rate-limiter-design.md exists in _output/ and covers token bucket algorithm, configuration parameters, failure modes, and operational guidance.
- Failure Policy: retry
- Instructions:
  1. Read approved KB entries on token bucket mechanism and token-leaky equivalence
  2. Design the rate limiter using token bucket as the primary algorithm
  3. Include sections for: algorithm overview, configuration parameters (rate, burst size, window), failure handling (what happens when limiter state is lost), distributed coordination approach, and operational monitoring
  4. Ground all design decisions in Soul constraints (resilience over performance, explicit failure handling)
  5. Write the design document to _output/rate-limiter-design.md

## Handoffs
- Step 1 outputs: updated cu-*.md files. Step 2 does not depend on the content of these updates, only on Step 1 completion (maintenance obligation satisfied before proceeding to deliverable).

## Completion Check
- At least 2 cu-*.md files have Status: approved
- rate-limiter-design.md exists in tasks/20260401-threshold-maintenance-test/_output/
- All cu-*.md files have Scan History entries from this task's maintenance review
