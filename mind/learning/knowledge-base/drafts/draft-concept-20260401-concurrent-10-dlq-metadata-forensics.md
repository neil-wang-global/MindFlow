# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-10

## Summary
- DLQ systems should support application-level dead-lettering with structured metadata (exception type in DeadLetterReason, stack trace in DeadLetterDescription) to enable message forensics and root cause analysis

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-10.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-10/acquire/raw-sources/src-002-azure-servicebus-dlq.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-10/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "Application-level dead-lettering: In addition to the system-provided dead-lettering features, applications can use the DLQ to explicitly reject unacceptable messages. They can include messages that can't be properly processed because of any sort of system issue, messages that hold malformed payloads, or messages that fail authentication when some message-level security scheme is used. We recommend that you include the type of the exception in the DeadLetterReason and the stack trace of the exception in the DeadLetterDescription as it makes it easier to troubleshoot the cause of the problem resulting in messages being dead-lettered."

## Candidate Conclusion
- DLQ systems should support both system-level and application-level dead-lettering. For message forensics, applications should attach structured metadata to dead-lettered messages: the exception type in a DeadLetterReason field and the stack trace in a DeadLetterDescription field. This metadata enables root cause analysis by providing the exact failure context alongside the message payload.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-10-dlq-metadata-forensics.md

## Notes
- none
