# Task Profile

## Task ID
- 20260401-parallel-test

## Task Type
- delivery

## Goal
- Produce security audit reports for frontend and backend services. The frontend and backend audits run in parallel (parallel-branch dispatch mode), and results are merged into a single consolidated security audit report. This task validates the parallel-branch dispatch mechanism end-to-end.

## Inputs
- Test scenario specification (user request)
- MindFlow protocol files (SYSTEM.md, module READMEs, TEMPLATEs)

## Success Criteria
- Frontend audit report produced at cache/step-1-frontend-audit.md
- Backend audit report produced at cache/step-2-backend-audit.md
- Merged security audit report produced at _output/security-audit-report.md
- Parallel-branch dispatch fields consistent across analysis.md, plan.md, and reflection-report.md
- Parallel Branch Status tracked through pending, running, completed lifecycle in state.md

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Security auditing methodology (frontend and backend)
- Report synthesis and merging

## Constraints
- Steps 1 and 2 must use parallel-branch dispatch mode with a shared Parallel Group
- Step 3 must be sequential and depend on both Steps 1 and 2
- Output paths for Steps 1 and 2 must be isolated (different cache/ files)
- Dispatch fields must be structurally consistent across analysis, plan, and reflection artifacts

## Task-level Learning Possibility
- not-expected

## Mode
- standard

## Inference Possibility
- not expected

## Notes
- This task is an E2E protocol validation test for the parallel-branch dispatch mode
