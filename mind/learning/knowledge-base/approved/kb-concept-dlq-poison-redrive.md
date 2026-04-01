# Knowledge Base Entry

## Type
- concept

## Summary
- Poison messages in a DLQ system are detected by tracking delivery attempt counts against a configurable threshold (maxReceiveCount). When a message exceeds this threshold without successful processing, it is automatically moved to the DLQ for isolation. Recovery involves examining the DLQ contents to diagnose the failure, then redriving messages back to the source queue after the root cause is fixed.

## Source Lineage
- Task ID: 20260401-concurrent-10
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-10.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-10-dlq-poison-redrive.md
- Review File: mind/learning/reviews/review-20260401-concurrent-10-dlq-poison-redrive.md
- Original Source Anchor: tasks/20260401-concurrent-10/acquire/raw-sources/src-001-aws-sqs-dlq.md
- Original Source URL: https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html

## Key Evidence
> "Poison message handling: A \"poison\" message (one that continually fails processing) is handled by moving it to the DLQ once it has been received maxReceiveCount times by consumers without successful deletion. Once in the DLQ you can: examine logs and message contents to determine failure causes; decide to redrive (move) messages back to the source queue after fixing the cause."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-10-dlq-poison-redrive.md

## Applicability
- Applies to: distributed message processing systems using queue-based communication; any system where consumers may fail to process messages (e.g., AWS SQS, Azure Service Bus, RabbitMQ, Kafka)
- Does not apply to: synchronous request-response architectures without message queues; in-process function calls; fire-and-forget patterns where message loss is acceptable

## Notes
- Grounded in AWS SQS official documentation; verified via ACQ-001
- The maxReceiveCount parameter is SQS-specific; equivalent mechanisms exist in other brokers (e.g., MaxDeliveryCount in Azure Service Bus)
