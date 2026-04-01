# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-30

## Summary
- Chang-Roberts ring election algorithm achieves O(n log n) average-case message complexity on unidirectional ring topology, improving over Bully algorithm's O(n^2) average case

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-30.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-30/acquire/raw-sources/src-002-ring-election.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-30/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "The Chang-Roberts algorithm operates on a unidirectional ring topology."

## Candidate Conclusion
The Chang-Roberts ring election algorithm achieves O(n log n) average-case message complexity on a unidirectional ring topology, improving over the Bully algorithm's O(n^2) average case. Each process only needs to know its ring neighbor, making it suitable for systems without full connectivity. The algorithm forwards election messages clockwise, with each process either forwarding higher-ID messages or replacing them with its own ID.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-30-ring-election.md

## Notes
- none
