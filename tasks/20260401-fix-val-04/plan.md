# Plan

## Task ID
- 20260401-fix-val-04

## Goal
- Acquire and promote at least 2 knowledge entries about how Envoy proxies collect and export telemetry data (access logs, metrics, traces) in Istio service mesh; address pending cross-task maintenance items

## Runtime State
- the fixed runtime state file is: `tasks/20260401-fix-val-04/state.md`

## Global Constraints
- Knowledge must be grounded in primary sources (official Envoy/Istio documentation)
- Default final result directory: `tasks/20260401-fix-val-04/_output/`
- Fragment file must be written to `mind/learning/knowledge-base/approved/fragments/` and merged via Index Merge Protocol
- No git commits
- Concurrent execution with task 20260401-fix-val-05

### Step 1
- Name: Cross-task maintenance
- Goal: Review and advance pending capability updates and re-evaluate deferred reviews per SYSTEM.md threshold rules
- Capability: knowledge-synthesis
- Dispatch Mode: sequential
- Output Isolation: side-effects on cross-task files only; no output to `_output/`
- Constraints: `mind/soul/core.md`; SYSTEM.md §Capability Update Advancement and §Deferred Review Advancement; capability update files may reference capability definition files that do not yet exist in `capabilities/`
- Inputs: `mind/learning/capability-updates/cu-20260325-cap-load-testing.md`, `mind/learning/capability-updates/cu-20260326-cap-schema-design.md`, `mind/learning/capability-updates/cu-20260327-cap-api-gateway.md`, `mind/learning/capability-updates/cu-20260401-failure-test-cap-benchmarking.md`, `mind/learning/reviews/review-20260401-bulkhead-isolation.md`, `mind/learning/reviews/review-20260401-concurrent-24-client-server-discovery.md`, `mind/learning/reviews/review-20260401-concurrent-24-consul-dns-discovery.md`
- Outputs: updated scan history entries in cross-task files
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: all 4 capability update files have scan history updated with current task-id; proposed file reviewed for advancement; all 3 deferred review files have scan history updated with current task-id and re-evaluation recorded
- Failure Policy: escalate-to-reflection
- Instructions: 1) Read each cu-*.md file; for cu-20260401-failure-test-cap-benchmarking.md (Status: proposed), evaluate whether to advance to approved; for the 3 approved files, check if target capability files exist in capabilities/ for advancement to applied; 2) Append scan entry to each file's Scan History; 3) Read each deferred review file and re-evaluate; append scan entry to Scan History

### Step 2
- Name: Acquire Envoy telemetry knowledge
- Goal: Fetch official Envoy and Istio documentation on observability/telemetry, produce knowledge artifact covering access logs, metrics, and distributed traces
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-04/_output/` and `tasks/20260401-fix-val-04/acquire/`
- Constraints: `mind/soul/core.md`; knowledge must come from primary sources (official documentation); Knowledge Source Prohibition applies
- Inputs: existing approved knowledge on Envoy sidecar architecture, Istio traffic management, Prometheus dimensional model, W3C traceparent format
- Outputs: `tasks/20260401-fix-val-04/_output/envoy-telemetry-research.md`, acquisition artifacts in `tasks/20260401-fix-val-04/acquire/`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: at least 2 source documents fetched and stored in `acquire/raw-sources/`; verification report produced; knowledge research summary written to `_output/`
- Failure Policy: escalate-to-reflection
- Instructions: 1) Search for official Envoy documentation on observability (access logging, stats/metrics, distributed tracing); 2) Search for official Istio documentation on telemetry and observability; 3) Fetch at least 2 primary source documents; 4) Store fetched content in `acquire/raw-sources/`; 5) Create search log in `acquire/search-log.md`; 6) Verify sources via independent subagent; 7) Produce research summary in `_output/envoy-telemetry-research.md`

## Handoffs
- Step 1 outputs (cross-task file updates) do not feed into Step 2
- Step 2 outputs feed into terminal Learning for knowledge promotion

## Completion Check
- All cross-task maintenance scan entries recorded
- At least 2 source documents acquired and verified
- Knowledge research summary exists in `_output/`
- Terminal Learning can proceed with 2+ knowledge candidates
