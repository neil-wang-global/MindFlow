# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-10

## Summary
- Poison messages in DLQ systems are detected by tracking delivery counts against a configurable threshold; when exceeded, messages are moved to the DLQ for isolation and later redriven to the source queue after root cause resolution

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-10.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-10/acquire/raw-sources/src-001-aws-sqs-dlq.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-10/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Poison message handling: A \"poison\" message (one that continually fails processing) is handled by moving it to the DLQ once it has been received maxReceiveCount times by consumers without successful deletion. Once in the DLQ you can: examine logs and message contents to determine failure causes; decide to redrive (move) messages back to the source queue after fixing the cause."

## Candidate Conclusion
- Poison messages in a DLQ system are detected by tracking delivery attempt counts against a configurable threshold (maxReceiveCount). When a message exceeds this threshold without successful processing, it is automatically moved to the DLQ for isolation. Recovery involves examining the DLQ contents to diagnose the failure, then redriving messages back to the source queue after the root cause is fixed.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-10-dlq-poison-redrive.md

## Notes
- none
