# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-dead-letter-queues

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Microsoft Azure official documentation is a primary authoritative source for Service Bus DLQ implementation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Azure Service Bus queues and topic subscriptions provide a secondary subqueue, called a dead-letter queue (DLQ). The dead-letter queue doesn't need to be explicitly created and can't be deleted or managed independent of the main entity.

The purpose of the dead-letter queue is to hold messages that can't be delivered to any receiver, or messages that couldn't be processed. Messages can then be removed from the DLQ and inspected. An application might let a user correct issues and resubmit the message.

From an API and protocol perspective, the DLQ is mostly similar to any other queue, except that messages can only be submitted via the dead-letter operation of the parent entity. In addition, time-to-live isn't observed, and you can't dead-letter a message from a DLQ. The dead-letter queue fully supports normal operations such as peek-lock delivery, receive-and-delete, and transactional operations.

There's no automatic cleanup of the DLQ. Messages remain in the DLQ until you explicitly retrieve them from the DLQ and complete the dead-letter message.

You can access the dead-letter queue by using the following syntax: <queue path>/$deadletterqueue or <topic path>/Subscriptions/<subscription path>/$deadletterqueue.

Moving messages to the DLQ: There are several activities in Service Bus that cause messages to get pushed to the DLQ from within the messaging engine itself. An application can also explicitly move messages to the DLQ. The following two properties (dead-letter reason and dead-letter description) are added to dead-lettered messages. Applications can define their own codes for the dead-letter reason property, but the system sets the following values:

Dead-letter reasons set by the system:
- HeaderSizeExceeded: The size quota for this stream exceeded the limit.
- TTLExpiredException: The message expired and was dead lettered.
- Session ID is null: Session enabled entity doesn't allow a message whose session identifier is null.
- MaxTransferHopCountExceeded: The maximum number of allowed hops when forwarding between queues exceeded the limit (set to 4).
- MaxDeliveryCountExceeded: Message couldn't be consumed after maximum delivery attempts.

Time to live: When you enable dead-lettering on queues or subscriptions, all expiring messages are moved to the DLQ. The dead-letter reason code is set to TTLExpiredException.

Maximum delivery count: There's a limit on number of attempts to deliver messages for Service Bus queues and subscriptions. The default value is 10. Whenever a message is delivered under a peek-lock, but is either explicitly abandoned or the lock is expired, the delivery count on the message is incremented. When the delivery count exceeds the limit, the message is moved to the DLQ. The dead-letter reason for the message in DLQ is set to MaxDeliveryCountExceeded.

Application-level dead-lettering: In addition to the system-provided dead-lettering features, applications can use the DLQ to explicitly reject unacceptable messages. They can include messages that can't be properly processed because of any sort of system issue, messages that hold malformed payloads, or messages that fail authentication when some message-level security scheme is used. We recommend that you include the type of the exception in the DeadLetterReason and the stack trace of the exception in the DeadLetterDescription as it makes it easier to troubleshoot the cause of the problem resulting in messages being dead-lettered.

Dead-lettering in auto forward scenarios: Messages are sent to the dead-letter queue under the following conditions: A message passes through more than four queues or topics that are chained together. The destination queue or topic is disabled or deleted. The destination queue or topic exceeds the maximum entity size.

Sending dead-lettered messages to be reprocessed: Once you resolve the issue that caused the message to be dead lettered, you can resubmit it to the queue or topic to be reprocessed.
