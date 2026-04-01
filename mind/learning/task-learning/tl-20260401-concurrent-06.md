# Task Learning Record

## Task ID
- 20260401-concurrent-06

## Task Summary
- Designed a retry-with-backoff library API supporting multiple jitter strategies (full, equal, decorrelated) to prevent thundering herd effects in distributed systems
- Acquired external knowledge about jitter strategies via ACQ-001 from AWS Architecture Blog and AWS Builders Library
- Produced _output/retry-backoff-library.md with API design, backoff algorithms, jitter implementations, and usage examples

## External Acquisition

### ACQ-001: Jitter strategies for retry-with-backoff library

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-06/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] Three jitter strategies for exponential backoff in distributed retry systems

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-06/acquire/raw-sources/src-001-aws-backoff-jitter.md
- **Verification Status**: passed
- **Original Excerpt**: > "The solution is to add randomness — "jitter" — to the backoff time. We tested three jitter approaches:\n\n### Full Jitter\n\n```\nsleep = random_between(0, min(cap, base * 2 ** attempt))\n```\n\nFull Jitter randomizes the entire backoff value from zero to the exponential ceiling. This gives the best spread across retry attempts.\n\n### Equal Jitter\n\n```\ntemp = min(cap, base * 2 ** attempt)\nsleep = temp / 2 + random_between(0, temp / 2)\n```\n\nEqual Jitter takes half of the exponential backoff as a guaranteed minimum, then adds a random component for the other half. This provides a floor that ensures callers always wait at least some time.\n\n### Decorrelated Jitter\n\n```\nsleep = min(cap, random_between(base, sleep * 3))\n```\n\nDecorrelated Jitter is different from the other two: instead of using the attempt number to determine the exponential ceiling, it uses the previous sleep value. Each retry's delay depends on the last delay, creating a more decorrelated pattern."
- **Derived Conclusion**: Three mathematically defined jitter strategies exist for exponential backoff in distributed retry systems: (1) Full Jitter randomizes the entire delay from zero to the exponential ceiling, providing maximum spread; (2) Equal Jitter guarantees a minimum wait of half the exponential delay while adding randomness to the other half; (3) Decorrelated Jitter uses the previous sleep value rather than attempt number, creating state-dependent delays. Full Jitter provides the best performance in contention scenarios with lowest total completion time and fewest calls.

## Potential Capability Impact
- none

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-06-jitter-strategies.md

## Notes
- none
