# Plan

## Task ID
- 20260401-fix-val-08

## Goal
- Learn the OpenTelemetry Collector receiver/processor/exporter pipeline architecture and produce a knowledge artifact documenting how this design enables vendor-agnostic telemetry collection. Also address pending cross-task staleness items.

## Runtime State
- the fixed runtime state file is: `tasks/20260401-fix-val-08/state.md`

## Global Constraints
- Soul Learning Policy: prioritize primary sources (official opentelemetry.io documentation)
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid sources
- Subagent Soul Constraint: all subagent dispatches must include `mind/soul/core.md` content
- Default final result directory: `tasks/20260401-fix-val-08/_output/`
- No git commits

### Step 1
- Name: Cross-Task Staleness Maintenance
- Goal: Review 4 pending capability updates and 3 deferred reviews that exceed staleness thresholds; advance where appropriate
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: updates written to `mind/learning/capability-updates/cu-*.md` and `mind/learning/reviews/review-*.md` Scan History fields
- Constraints: `mind/soul/core.md`, `SYSTEM.md §Capability Update Advancement`, `SYSTEM.md §Deferred Review Advancement`
- Inputs: `cu-20260325-cap-load-testing.md`, `cu-20260326-cap-schema-design.md`, `cu-20260327-cap-api-gateway.md`, `cu-20260401-failure-test-cap-benchmarking.md`, `review-20260401-bulkhead-isolation.md`, `review-20260401-concurrent-24-client-server-discovery.md`, `review-20260401-concurrent-24-consul-dns-discovery.md`
- Outputs: updated Scan History entries in the above files
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: each of the 7 files has a scan entry for `20260401-fix-val-08` in its Scan History section; advancement decisions are recorded with rationale
- Failure Policy: escalate-to-reflection
- Instructions: 1. Read each capability update file; for approved items, evaluate if they can advance to `applied` (requires target capability file to exist and be updated); if no target capability file exists, record that advancement is blocked. 2. For the proposed item (`cu-20260401-failure-test-cap-benchmarking.md`), evaluate if it can advance to `approved`. 3. Read each deferred review file; evaluate if deferral conditions have changed; if not, record continued deferral with rationale. 4. Append scan entries to each file's Scan History.

### Step 2
- Name: OTel Collector Pipeline Research and Acquisition
- Goal: Search for, fetch, and verify official documentation on the OpenTelemetry Collector's receiver/processor/exporter pipeline; produce knowledge artifact
- Capability: none
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-08/acquire/` for ACQ artifacts, `tasks/20260401-fix-val-08/_output/` for final knowledge artifact
- Constraints: `mind/soul/core.md`, `mind/learning/acquire/README.md`
- Inputs: `tasks/20260401-fix-val-08/analysis.md`, approved KB entries from learning-read
- Outputs: `tasks/20260401-fix-val-08/acquire/search-log.md`, `tasks/20260401-fix-val-08/acquire/raw-sources/`, `tasks/20260401-fix-val-08/acquire/verification-report.md`, `tasks/20260401-fix-val-08/_output/otel-collector-pipeline.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: `acquire/search-log.md` exists with at least one result; `acquire/raw-sources/` contains at least one source file; `acquire/verification-report.md` exists with verification outcome; `_output/otel-collector-pipeline.md` exists documenting the pipeline architecture
- Failure Policy: escalate-to-reflection
- Instructions: 1. Follow `mind/learning/acquire/README.md` ACQ stages. 2. Stage 1: Search opentelemetry.io for Collector architecture documentation. 3. Stage 2: Fetch the primary source page on the Collector pipeline. 4. Stage 3: Dispatch verification subagent with `mind/soul/core.md` content included in prompt. 5. Produce knowledge summary artifact in `_output/`. 6. Log subagent dispatch to `cache/subagent-dispatch-log.md`.

## Handoffs
- Step 1 -> Step 2: no data dependency; Step 2 does not consume Step 1 outputs; ordering is sequential per protocol

## Completion Check
- `_output/otel-collector-pipeline.md` exists
- `acquire/verification-report.md` exists with verification passed
- All 7 cross-task files have `20260401-fix-val-08` scan entries
- `cache/subagent-dispatch-log.md` records soul inclusion for each subagent dispatch
- Knowledge Outcome = `fully-acquired`
- Overall Status = `completed`
