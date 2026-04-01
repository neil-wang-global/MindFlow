# Plan

## Task ID
- 20260401-parallel-test

## Goal
- Produce a consolidated security audit report covering frontend and backend services by running parallel audit branches and merging results.

## Runtime State
- the fixed runtime state file is: `tasks/20260401-parallel-test/state.md`

## Global Constraints
- Default final result directory: `tasks/20260401-parallel-test/_output/`
- Intermediate handoff files: `tasks/20260401-parallel-test/cache/`
- Soul constraints: resilience over performance, evidence-based design, explicit failure handling
- Dispatch fields must be consistent across analysis.md, plan.md, and reflection-report.md per SYSTEM.md Dispatch Field Consistency

### Step 1
- Name: Frontend Security Audit
- Goal: Produce a security audit report for the frontend service covering XSS, CSRF, CSP, and dependency vulnerabilities
- Capability: none (no matching capability defined)
- Dispatch Mode: parallel-branch
- Parallel Group: audit
- Synchronization Point: Step 3
- Merge Owner: Step 3
- Output Isolation: `tasks/20260401-parallel-test/cache/step-1-frontend-audit.md` — isolated from Step 2 output path
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, analysis.md
- Outputs: `tasks/20260401-parallel-test/cache/step-1-frontend-audit.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Subagent / Branch Scope: Independent frontend audit branch; no shared mutable state with other branches
- Merge / Sync Rule: Output is consumed by Step 3 (merge owner) after synchronization point is reached
- Completion Criteria: File `tasks/20260401-parallel-test/cache/step-1-frontend-audit.md` exists and contains sections for XSS, CSRF, CSP, and dependency risk findings
- Failure Policy: retry
- Instructions: Write a structured frontend security audit report to `cache/step-1-frontend-audit.md`. Cover the following vulnerability categories: Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF), Content Security Policy (CSP) configuration, and third-party dependency risks. Each category should include a risk rating, finding description, and recommended mitigation.

### Step 2
- Name: Backend Security Audit
- Goal: Produce a security audit report for the backend service covering injection, authentication, authorization, and data exposure vulnerabilities
- Capability: none (no matching capability defined)
- Dispatch Mode: parallel-branch
- Parallel Group: audit
- Synchronization Point: Step 3
- Merge Owner: Step 3
- Output Isolation: `tasks/20260401-parallel-test/cache/step-2-backend-audit.md` — isolated from Step 1 output path
- Constraints: `mind/soul/core.md`
- Inputs: task-profile.md, analysis.md
- Outputs: `tasks/20260401-parallel-test/cache/step-2-backend-audit.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: none
- Subagent / Branch Scope: Independent backend audit branch; no shared mutable state with other branches
- Merge / Sync Rule: Output is consumed by Step 3 (merge owner) after synchronization point is reached
- Completion Criteria: File `tasks/20260401-parallel-test/cache/step-2-backend-audit.md` exists and contains sections for injection, authentication, authorization, and data exposure findings
- Failure Policy: retry
- Instructions: Write a structured backend security audit report to `cache/step-2-backend-audit.md`. Cover the following vulnerability categories: SQL/NoSQL Injection, Authentication weaknesses, Authorization flaws, and Data Exposure risks. Each category should include a risk rating, finding description, and recommended mitigation.

### Step 3
- Name: Merge Security Audit Reports
- Goal: Read both parallel branch outputs and produce a consolidated security audit report
- Capability: none (no matching capability defined)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-parallel-test/_output/security-audit-report.md`
- Constraints: `mind/soul/core.md`
- Inputs: `tasks/20260401-parallel-test/cache/step-1-frontend-audit.md`, `tasks/20260401-parallel-test/cache/step-2-backend-audit.md`
- Outputs: `tasks/20260401-parallel-test/_output/security-audit-report.md`
- Publish To Sources: none
- Learning: not-needed
- Depends On: Step 1, Step 2
- Completion Criteria: File `tasks/20260401-parallel-test/_output/security-audit-report.md` exists and contains both frontend and backend findings consolidated with an executive summary
- Failure Policy: retry
- Instructions: Read `cache/step-1-frontend-audit.md` and `cache/step-2-backend-audit.md`. Merge both reports into a single consolidated security audit report at `_output/security-audit-report.md`. Include an executive summary, combined risk matrix, and organized sections for frontend and backend findings. Ensure consistent formatting across both source reports.

## Handoffs
- Step 1 writes to `cache/step-1-frontend-audit.md`; Step 2 writes to `cache/step-2-backend-audit.md`
- Steps 1 and 2 run in parallel (Parallel Group: audit) with no inter-branch communication
- Step 3 is the Synchronization Point and Merge Owner: it waits for both branches to complete, then reads both cache files to produce the final merged output
- Parallel merge strategy: file-based — each branch writes to an isolated cache path; Step 3 reads both files and synthesizes

## Completion Check
- `tasks/20260401-parallel-test/cache/step-1-frontend-audit.md` exists with frontend audit content
- `tasks/20260401-parallel-test/cache/step-2-backend-audit.md` exists with backend audit content
- `tasks/20260401-parallel-test/_output/security-audit-report.md` exists with merged report containing both frontend and backend findings
- All three Steps are marked `completed` in state.md Step Status Map
- Parallel Branch Status shows both branches completed and synchronization point ready
