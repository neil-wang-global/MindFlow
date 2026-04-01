# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- AWS official documentation is a primary authoritative source for SQS DLQ implementation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

A dead-letter queue (DLQ) is a standard SQS queue that source queues can target to receive messages that are not processed successfully. Messages are moved to the DLQ when they exceed the source queue's configured retry threshold (the redrive policy's maxReceiveCount). DLQs let you isolate unconsumed messages to examine message contents, application exceptions, and processing behavior to diagnose failures. You must create a queue first, then configure it to be used as a DLQ for one or more source queues.

Best practices: Keep the source queue and its DLQ in the same AWS account and Region for optimal performance. Set the DLQ's retention period longer than the source queue's retention period so DLQ messages are not deleted prematurely. Don't attach a DLQ to a FIFO queue if you cannot tolerate breaking the exact order of messages or operations.

Redrive policy and retry configuration: Use a redrive policy to specify the maxReceiveCount — the number of times a consumer can receive a message from the source queue before the message is moved to the DLQ. If maxReceiveCount is very low (for example, 1), a single failed receive will move the message immediately to the DLQ. Set maxReceiveCount high enough to allow sufficient retries for transient errors. For standard queues with a redrive policy where maxReceiveCount > 3: If a message is received 3 or more times without being deleted, SQS moves it to the back of the queue.

Redrive allow policy: Specifies which source queues may send messages to the DLQ. Options: allow all source queues (default), allow specific queues (byQueue — up to 10 source queue ARNs), or deny all (denyAll) which prevents the queue being used as a DLQ.

Poison message handling: A "poison" message (one that continually fails processing) is handled by moving it to the DLQ once it has been received maxReceiveCount times by consumers without successful deletion. Once in the DLQ you can: examine logs and message contents to determine failure causes; decide to redrive (move) messages back to the source queue after fixing the cause.

Message retention and metrics behavior for standard queues: A message's expiration is always based on its original enqueue timestamp. When moved to a DLQ, the enqueue timestamp is unchanged. ApproximateAgeOfOldestMessage for the DLQ indicates how long the message has been in the DLQ (when it moved), not the original send time. Best practice: set DLQ retention > source retention.

For FIFO queues: The enqueue timestamp resets when the message is moved to the DLQ.

Monitoring and operational guidance: Use CloudWatch alarms to detect messages moved to DLQs. Use the DLQ to analyze message payloads and application logs to determine root causes. Use the dead-letter queue redrive workflow to move messages out of the DLQ after diagnosis/fixes.

Configuration notes: You must create the queue before configuring it as a DLQ target. The default redrive allow policy permits all source queues to target the DLQ; you can restrict this. Warning: attaching a DLQ to a FIFO queue can break exact ordering.

A typical redrive policy: {"deadLetterTargetArn":"arn:aws:sqs:region:acct-id:dlq-name","maxReceiveCount":"5"}
