# Task Learning Record

## Task ID
- 20260401-concurrent-10

## Task Summary
- Designed a dead letter queue handler for distributed message processing systems
- Acquired DLQ best practices from AWS SQS and Azure Service Bus documentation
- Produced a comprehensive design document covering poison message handling, DLQ monitoring, automatic retry policies, and message forensics

## External Acquisition

### ACQ-001: DLQ best practices acquisition

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-10/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] DLQ poison message detection and redrive policy pattern

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-10/acquire/raw-sources/src-001-aws-sqs-dlq.md
- **Verification Status**: passed
- **Original Excerpt**: > "Poison message handling: A \"poison\" message (one that continually fails processing) is handled by moving it to the DLQ once it has been received maxReceiveCount times by consumers without successful deletion. Once in the DLQ you can: examine logs and message contents to determine failure causes; decide to redrive (move) messages back to the source queue after fixing the cause."
- **Derived Conclusion**: Poison messages in a DLQ system are detected by tracking delivery attempt counts against a configurable threshold (maxReceiveCount). When a message exceeds this threshold without successful processing, it is automatically moved to the DLQ for isolation. Recovery involves examining the DLQ contents to diagnose the failure, then redriving messages back to the source queue after the root cause is fixed.

### [KDC-002] Azure Service Bus DLQ dead-letter reason metadata pattern

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-10/acquire/raw-sources/src-002-azure-servicebus-dlq.md
- **Verification Status**: passed
- **Original Excerpt**: > "Application-level dead-lettering: In addition to the system-provided dead-lettering features, applications can use the DLQ to explicitly reject unacceptable messages. They can include messages that can't be properly processed because of any sort of system issue, messages that hold malformed payloads, or messages that fail authentication when some message-level security scheme is used. We recommend that you include the type of the exception in the DeadLetterReason and the stack trace of the exception in the DeadLetterDescription as it makes it easier to troubleshoot the cause of the problem resulting in messages being dead-lettered."
- **Derived Conclusion**: DLQ systems should support both system-level and application-level dead-lettering. For message forensics, applications should attach structured metadata to dead-lettered messages: the exception type in a DeadLetterReason field and the stack trace in a DeadLetterDescription field. This metadata enables root cause analysis by providing the exact failure context alongside the message payload.

## Potential Capability Impact
- Consider creating a dlq-handling capability definition based on patterns documented in this task

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-10-dlq-poison-redrive.md
- KDC-002: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-10-dlq-metadata-forensics.md

## Notes
- none
