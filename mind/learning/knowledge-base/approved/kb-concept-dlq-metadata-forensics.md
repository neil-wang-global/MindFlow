# Knowledge Base Entry

## Type
- concept

## Summary
- DLQ systems should support both system-level and application-level dead-lettering. For message forensics, applications should attach structured metadata to dead-lettered messages: the exception type in a DeadLetterReason field and the stack trace in a DeadLetterDescription field. This metadata enables root cause analysis by providing the exact failure context alongside the message payload.

## Source Lineage
- Task ID: 20260401-concurrent-10
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-10.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-10-dlq-metadata-forensics.md
- Review File: mind/learning/reviews/review-20260401-concurrent-10-dlq-metadata-forensics.md
- Original Source Anchor: tasks/20260401-concurrent-10/acquire/raw-sources/src-002-azure-servicebus-dlq.md
- Original Source URL: https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-dead-letter-queues

## Key Evidence
> "Application-level dead-lettering: In addition to the system-provided dead-lettering features, applications can use the DLQ to explicitly reject unacceptable messages. They can include messages that can't be properly processed because of any sort of system issue, messages that hold malformed payloads, or messages that fail authentication when some message-level security scheme is used. We recommend that you include the type of the exception in the DeadLetterReason and the stack trace of the exception in the DeadLetterDescription as it makes it easier to troubleshoot the cause of the problem resulting in messages being dead-lettered."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-10-dlq-metadata-forensics.md

## Applicability
- Applies to: message-driven architectures where failed messages need post-mortem analysis; any DLQ implementation where operators need to diagnose and resolve message processing failures
- Does not apply to: systems where message loss is acceptable; simple logging-only failure handling without structured diagnostics

## Notes
- Grounded in Azure Service Bus official documentation; verified via ACQ-001
- The DeadLetterReason/DeadLetterDescription naming convention is Azure-specific; the pattern of attaching exception type and stack trace metadata applies to any DLQ implementation
