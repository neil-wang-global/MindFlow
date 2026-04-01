# Plan

## Task ID
- 20260401-midstep-acq-test

## Goal
- Design a circuit breaker pattern for microservice communication and produce a complete design document backed by externally acquired and independently verified research

## Runtime State
- tasks/20260401-midstep-acq-test/state.md

## Global Constraints
- All external knowledge must be independently verified before use in design
- Default final result directory: tasks/20260401-midstep-acq-test/_output/
- Intermediate files go to: tasks/20260401-midstep-acq-test/cache/
- Soul constraints: resilience-focused; evidence-based design; primary sources preferred
- No publish-back to sources/ required

### Step 1
- Name: Research circuit breaker pattern fundamentals
- Goal: Acquire external knowledge about the circuit breaker pattern for microservice communication, including core concepts (states, transitions, failure detection) from authoritative sources
- Capability: web-research
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-midstep-acq-test/cache/step-1-research.md
- Constraints: mind/soul/core.md (learning policy: primary sources preferred)
- Inputs: task goal, analysis.md
- Outputs: cache/step-1-research.md (research summary with source references)
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: cache/step-1-research.md exists and contains circuit breaker state machine description with at least 2 verified external source references
- Failure Policy: escalate-to-reflection
- Instructions: Search for "circuit breaker pattern microservices" using WebSearch. Fetch at least 2 authoritative URLs using WebFetch. Save raw sources to acquire/raw-sources/. Dispatch independent subagent for verification. Compile verified research into cache/step-1-research.md covering: closed/open/half-open states, transition triggers, failure counting, and timeout mechanisms.

### Step 2
- Name: Design circuit breaker pattern implementation
- Goal: Produce a detailed circuit breaker design including state machine specification, transition rules, failure thresholds, timeout configuration, and monitoring considerations
- Capability: system-design
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-midstep-acq-test/cache/step-2-design.md
- Constraints: mind/soul/core.md (values: explicit failure handling; aesthetic: clear state machines)
- Inputs: cache/step-1-research.md, analysis.md
- Outputs: cache/step-2-design.md (detailed design with state machine, transitions, configuration)
- Publish To Sources: none
- Learning: optional
- Depends On: Step 1
- Completion Criteria: cache/step-2-design.md exists and contains state machine specification, transition rules table, configuration parameters with recommended values, and monitoring requirements
- Failure Policy: retry
- Instructions: Using Step 1 research output, design the circuit breaker implementation. Define state machine with closed/open/half-open states. Specify transition rules and triggers. Define configuration parameters (failure threshold, timeout duration, half-open trial count). If a knowledge gap is encountered about specific best practices (e.g., half-open state timeout strategies), trigger Learning(Acquire) mid-step. Include monitoring and observability considerations per soul constraints.

### Step 3
- Name: Produce final design document
- Goal: Combine research findings and design work into a complete, well-structured design document suitable for implementation teams
- Capability: technical-writing
- Dispatch Mode: sequential
- Output Isolation: tasks/20260401-midstep-acq-test/_output/circuit-breaker-design.md
- Constraints: mind/soul/core.md (aesthetic: diagrams and state transition tables over prose-heavy documentation)
- Inputs: cache/step-1-research.md, cache/step-2-design.md
- Outputs: _output/circuit-breaker-design.md (final design document)
- Publish To Sources: none
- Learning: terminal-only
- Depends On: Step 1, Step 2
- Completion Criteria: _output/circuit-breaker-design.md exists and contains all sections: overview, state machine, transitions, configuration, monitoring, and references to external sources
- Failure Policy: retry
- Instructions: Synthesize research and design into a cohesive design document. Include: executive summary, problem statement, circuit breaker state machine (with ASCII state diagram), transition rules table, configuration parameters with defaults and rationale, monitoring/alerting recommendations, and references section citing verified external sources. Ensure all design decisions are traceable to acquired research.

## Handoffs
- Step 1 -> Step 2: cache/step-1-research.md provides research foundation for design decisions
- Step 2 -> Step 3: cache/step-2-design.md provides detailed design for document synthesis
- Step 1 -> Step 3: cache/step-1-research.md provides source references for citations

## Completion Check
- _output/circuit-breaker-design.md exists with complete circuit breaker design
- cache/step-1-research.md and cache/step-2-design.md exist as intermediate artifacts
- All external sources have been independently verified (verification-report.md present in acquire/)
- Design decisions are traceable to verified external sources
