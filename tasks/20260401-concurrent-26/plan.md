# Plan

## Task ID
- 20260401-concurrent-26

## Goal
- Design a monitoring dashboard specification and implement it; the task will be cancelled during Step 2 to validate the cancellation protocol path

## Runtime State
- tasks/20260401-concurrent-26/state.md

## Global Constraints
- Soul constraints: resilience over performance, evidence-based design, explicit failure handling, operational simplicity
- Default final result directory: tasks/20260401-concurrent-26/_output/
- Concurrency rules: must not modify existing shared files; all created files must include task-id
- No publish-back to sources/ required

### Step 1
- Name: Design monitoring dashboard
- Goal: Produce a complete monitoring dashboard specification covering metrics, layout, data sources, and alerting thresholds
- Capability: none (no matching capability defined)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-26/cache/step-1-dashboard.md
- Constraints: mind/soul/core.md (aesthetic preference for clear state machines and minimal configuration surface)
- Inputs: task-profile.md, analysis.md
- Outputs: tasks/20260401-concurrent-26/cache/step-1-dashboard.md
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Completion Criteria: cache/step-1-dashboard.md exists and contains at minimum: metrics list, layout specification, data source mapping, and alerting threshold definitions
- Failure Policy: stop
- Instructions: Design a monitoring dashboard for distributed systems observability. Include: (1) key metrics (latency p50/p95/p99, error rates, throughput, saturation), (2) layout with panels organized by service health, traffic, and resource utilization, (3) data source mapping for each metric, (4) alerting thresholds based on SLO targets.

### Step 2
- Name: Implement dashboard
- Goal: Begin implementing the dashboard based on the Step 1 design specification
- Capability: none (no matching capability defined)
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-concurrent-26/_output/
- Constraints: mind/soul/core.md; must follow the design from Step 1
- Inputs: tasks/20260401-concurrent-26/cache/step-1-dashboard.md
- Outputs: tasks/20260401-concurrent-26/_output/ (dashboard implementation artifacts)
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1
- Completion Criteria: _output/ contains at least one implementation artifact that follows the design specification from Step 1
- Failure Policy: stop
- Instructions: Implement the monitoring dashboard following the design specification from cache/step-1-dashboard.md. Begin with the core dashboard configuration and panel definitions. (Note: this step will be cancelled before completion per the test scenario.)

## Handoffs
- Step 1 produces cache/step-1-dashboard.md which Step 2 consumes as its primary input
- Step 2 writes final output to _output/

## Completion Check
- cache/step-1-dashboard.md exists with complete dashboard design
- _output/ contains dashboard implementation artifacts
- (Note: full completion is not expected — task will be cancelled during Step 2)
