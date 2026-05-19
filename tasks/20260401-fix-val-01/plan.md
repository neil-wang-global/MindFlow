# Plan

## Task ID
- 20260401-fix-val-01

## Goal
- Acquire, verify, and synthesize external knowledge about the CAP theorem's practical implications for database selection in microservice architectures, producing promoted knowledge artifacts and a structured knowledge document.

## Runtime State
- tasks/20260401-fix-val-01/state.md

## Global Constraints
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid sources
- Soul Learning Policy: prioritize primary sources (academic papers, official documentation, production incident reports)
- Soul Values: evidence-based design over intuition; prefer quantitative benchmarks over qualitative recommendations
- Default final result directory: tasks/20260401-fix-val-01/_output/
- Existing approved knowledge (CAP impossibility, classification, PACELC) must not be duplicated; new knowledge must extend beyond this baseline

### Step 1
- Name: Acquire external knowledge on practical CAP implications for microservice database selection
- Goal: Search for, fetch, and verify authoritative external sources about how CAP trade-offs translate into concrete database selection criteria for microservice bounded contexts
- Capability: web-search
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-fix-val-01/acquire/
- Constraints: mind/soul/core.md, SYSTEM.md §Knowledge Source Prohibition
- Inputs: existing approved knowledge (kb-concept-cap-impossibility.md, kb-concept-cap-classification.md, kb-concept-pacelc-extension.md) as baseline context
- Outputs: tasks/20260401-fix-val-01/acquire/search-log.md, tasks/20260401-fix-val-01/acquire/raw-sources/, tasks/20260401-fix-val-01/acquire/verification-report.md
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: at least 2 raw source files exist in acquire/raw-sources/ AND verification-report.md exists with at least 1 source marked as verified
- Failure Policy: rework
- Instructions: Execute Learning(Acquire) per mind/learning/README.md. Stage 1 (Search): use WebSearch to find authoritative sources on practical CAP implications for database selection in microservices — target Martin Kleppmann's "Designing Data-Intensive Applications", official database documentation (MongoDB, Cassandra, DynamoDB), and production engineering blogs from companies like Netflix, Uber, or Stripe. Stage 2 (Fetch): use WebFetch to retrieve identified source pages and save as raw-source files. Stage 3 (Verify): run independent subagent verification of source content against claimed summaries. Focus on: per-service data store patterns, tunable consistency trade-offs, decision frameworks for CP vs AP selection per bounded context.

### Step 2
- Name: Synthesize acquired knowledge into structured knowledge artifact
- Goal: Produce a comprehensive knowledge artifact document summarizing practical CAP implications for database selection in microservice architectures
- Capability: knowledge-synthesis
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-fix-val-01/_output/
- Constraints: mind/soul/core.md, acquired sources must be cited with specific page/section references
- Inputs: tasks/20260401-fix-val-01/acquire/raw-sources/ (verified sources from Step 1), tasks/20260401-fix-val-01/acquire/verification-report.md
- Outputs: tasks/20260401-fix-val-01/_output/cap-database-selection-guide.md
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1
- Completion Criteria: tasks/20260401-fix-val-01/_output/cap-database-selection-guide.md exists AND contains at least 3 distinct practical insights beyond the existing CAP/PACELC knowledge base entries
- Failure Policy: rework
- Instructions: Read all verified sources from Step 1. Extract practical database selection criteria, per-service data store patterns, and decision frameworks. Organize into a structured document covering: (1) decision matrix for CP vs AP selection per bounded context type, (2) tunable consistency configurations and their implications, (3) real-world examples of database selection trade-offs in microservices. Cite specific sources for each claim.

### Step 3
- Name: Address pending capability updates and deferred reviews (maintenance)
- Goal: Review and advance pending capability updates (4 files, threshold 4 >= 3 met) and evaluate deferred reviews (3 files, threshold 2+ met)
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: updates to existing files in mind/learning/capability-updates/ and mind/learning/reviews/
- Constraints: SYSTEM.md §Capability Update Advancement, SYSTEM.md §Deferred Review Advancement
- Inputs: cu-20260401-failure-test-cap-benchmarking.md, cu-20260325-cap-load-testing.md, cu-20260326-cap-schema-design.md, cu-20260327-cap-api-gateway.md, review-20260401-concurrent-24-client-server-discovery.md, review-20260401-bulkhead-isolation.md, review-20260401-concurrent-24-consul-dns-discovery.md
- Outputs: updated cu-*.md and review-*.md files with advanced Status or re-evaluation decisions
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: all 4 capability update files have been reviewed with advancement decision documented AND all 3 deferred review files have been re-evaluated with re-open/reject decision documented
- Failure Policy: escalate-to-reflection
- Instructions: For capability updates: review each cu-*.md file. The 3 approved updates (load-testing, schema-design, api-gateway) cannot be advanced to applied because their target capability files do not exist yet — document this limitation. The 1 proposed update (cap-benchmarking) has been previously reviewed and kept as proposed due to external tool dependency — confirm this assessment. For deferred reviews: evaluate each review-*.md file and determine whether to re-open (if additional evidence could be gathered) or reject (if the deferral reason cannot be resolved). Document the decision in each file's Scan History.

## Handoffs
- Step 1 -> Step 2: Step 1 produces acquire/raw-sources/ and acquire/verification-report.md; Step 2 reads these as inputs for knowledge synthesis
- Step 3 is independent of Steps 1-2 (maintenance operation)

## Completion Check
- tasks/20260401-fix-val-01/acquire/verification-report.md exists with at least 1 verified source
- tasks/20260401-fix-val-01/_output/cap-database-selection-guide.md exists
- All 4 capability update files reviewed, all 3 deferred review files re-evaluated
- state.md reflects completed status for all Steps
