# Task Profile

## Task ID
- 20260401-protocol-validation

## Task Type
- learning

## Goal
- Execute a complete MindFlow protocol end-to-end to validate that all phases, templates, cross-module rules, and recovery mechanisms work correctly in practice
- Produce a validation report documenting any runtime issues, protocol gaps, or ambiguities discovered during execution
- Test Learning(Acquire) Search/Fetch/Verify pipeline with a real external knowledge acquisition

## Inputs
- SYSTEM.md
- All module README.md and TEMPLATE.md files (loaded per Lazy Loading)
- tasks/EXAMPLE-TEMPLATE.md (reference for expected artifact structure)

## Success Criteria
- All phases executed in correct order without protocol violations
- All artifacts pass their respective TEMPLATE.md Validation Rules
- Learning(Acquire) pipeline tested (Search → Fetch → Verify)
- Validation report produced in _output/ documenting findings

## Complexity
- medium

## Risk
- medium

## Capability Needs
- cap-research: for external knowledge acquisition during ACQ testing
- cap-analysis: for protocol validation and gap identification

## Constraints
- Must follow MindFlow protocol exactly — no shortcuts or skipped phases
- External web fetch required for ACQ testing — network access needed
- Soul constraints not configured (all "To be defined") — no Soul constraints apply

## Task-level Learning Possibility
- `acquire-likely` — external search needed to test the ACQ pipeline

## Mode
- standard

## Inference Possibility
- not needed

## Notes
- This is a meta-task: the system is validating itself
- Any protocol issues found during execution should be recorded in the validation report
