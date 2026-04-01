# Dead Letter Queue Handler Design

## Task ID
- 20260401-concurrent-10

## Overview

This document defines a DLQ handler for distributed message processing systems. The design synthesizes verified best practices from AWS SQS and Azure Service Bus documentation with established circuit breaker patterns. The handler covers four core areas: poison message handling, DLQ monitoring, automatic retry policies, and message forensics.

## Design Principles

Per Soul constraints:
- Resilience over raw performance
- Explicit failure handling over silent degradation
- Never ignore failure modes in distributed systems
- Never assume network reliability between services
- Never skip monitoring and alerting

## 1. Poison Message Handling

### Detection Strategy

A poison message is defined as any message that consistently causes consumer failures. The handler implements a three-tier detection strategy:

**Tier 1 — Delivery Count Threshold**
- Track delivery attempts per message via message metadata (delivery count header)
- Configure `maxDeliveryCount` per queue (recommended: 5 for standard workloads, 3 for latency-sensitive)
- When delivery count exceeds threshold, route message to DLQ automatically
- Rationale: aligns with Azure Service Bus default (10) and AWS SQS redrive policy (`maxReceiveCount`)

**Tier 2 — Content Validation Gate**
- Validate message schema before processing attempt
- Messages failing schema validation are routed directly to DLQ with reason `ValidationFailed`
- Prevents wasting delivery attempts on structurally invalid messages

**Tier 3 — Application-Level Dead-Lettering**
- Applications explicitly dead-letter messages that fail business rule validation
- Must include `DeadLetterReason` (exception type) and `DeadLetterDescription` (stack trace) per Azure best practice
- Custom reason codes for application-specific failure categories

### Isolation Rules

- Each source queue has a dedicated DLQ — never mix dead letters from different workflows
- DLQ messages cannot be dead-lettered again (prevents infinite DLQ chains)
- DLQ retention period must exceed source queue retention to prevent premature deletion

### State Machine

```
[Normal Queue] --maxDeliveryCount exceeded--> [Dead Letter Queue]
[Normal Queue] --schema validation failed--> [Dead Letter Queue]
[Normal Queue] --app-level rejection------> [Dead Letter Queue]
[Dead Letter Queue] --redrive after fix----> [Normal Queue]
[Dead Letter Queue] --TTL expired----------> [Archived/Deleted]
```

## 2. DLQ Monitoring

### Metrics

| Metric | Source | Alert Threshold | Action |
|--------|--------|----------------|--------|
| DLQ depth (message count) | Queue metrics | > 0 messages | Immediate alert |
| DLQ message age | ApproximateAgeOfOldestMessage | > 1 hour | Investigation alert |
| DLQ inflow rate | Messages/minute entering DLQ | > 5% of source queue throughput | Escalation alert |
| Redrive success rate | Reprocessed messages / total redriven | < 80% | Pattern review alert |

### Alerting Strategy

- **Level 1 (Info)**: First message enters DLQ — triggers notification to owning team
- **Level 2 (Warning)**: DLQ depth exceeds 10 messages or messages older than 1 hour — triggers investigation
- **Level 3 (Critical)**: DLQ inflow rate exceeds 5% of source throughput — triggers circuit breaker evaluation

### Integration Points

- CloudWatch alarms (AWS) / Azure Monitor (Azure) for DLQ depth
- Distributed tracing correlation (correlation ID propagation from source to DLQ)
- Dashboard showing DLQ depth, age distribution, and failure reason breakdown

### Circuit Breaker Interaction

Per circuit breaker states knowledge (kb-concept-circuit-breaker-states.md):
- When DLQ inflow rate triggers Level 3 alert, evaluate whether the downstream service has failed
- If circuit is already Open, DLQ inflow is expected — suppress redundant alerts
- When circuit transitions to Half-Open, monitor DLQ inflow for the trial request window
- When circuit returns to Closed, verify DLQ inflow returns to baseline

## 3. Automatic Retry Policies

### Retry Configuration

```
Retry Policy:
  maxRetries: 5
  backoffStrategy: exponential
  initialDelay: 1s
  maxDelay: 60s
  backoffMultiplier: 2
  jitter: true (0-500ms random)
```

### Failure Classification

| Failure Type | Retry? | Backoff | Max Attempts | DLQ Action |
|-------------|--------|---------|--------------|------------|
| Transient (timeout, throttle, 503) | Yes | Exponential with jitter | 5 | Route to DLQ after exhaustion |
| Permanent (400, schema invalid) | No | N/A | 0 | Immediate DLQ routing |
| Unknown | Yes | Exponential with jitter | 3 | Route to DLQ with forensics |

### Idempotency Requirement

- All message handlers must be idempotent — retries must not cause duplicate side effects
- Use message deduplication IDs where supported
- Track processed message IDs in an idempotency store with TTL matching message retention

### Redrive (DLQ-to-Source)

- After root cause is fixed, messages can be redriven from DLQ back to source queue
- Redrive policy specifies which source queues may send to the DLQ (per AWS `RedriveAllowPolicy`)
- Automated redrive must verify the fix before bulk replay:
  1. Redrive a sample (e.g., 5 messages)
  2. Verify successful processing
  3. If sample passes, redrive remaining batch
  4. If sample fails, abort redrive and escalate

## 4. Message Forensics

### Metadata Enrichment

Every message entering the DLQ must carry:

| Field | Description | Source |
|-------|-------------|--------|
| `original_queue` | Source queue name/ARN | System |
| `original_enqueue_time` | When message was first enqueued | System |
| `delivery_count` | Number of delivery attempts | System |
| `dead_letter_reason` | System or application reason code | System/App |
| `dead_letter_description` | Exception type and stack trace | Application |
| `correlation_id` | Distributed tracing correlation ID | Application |
| `last_consumer_id` | Identity of last consumer that attempted processing | Application |
| `failure_timestamp` | When the final failure occurred | System |

### Root Cause Analysis Workflow

1. **Triage**: Group DLQ messages by `dead_letter_reason` to identify failure patterns
2. **Correlate**: Use `correlation_id` to trace the full request path through distributed tracing
3. **Reproduce**: Extract message payload and replay against a staging environment
4. **Classify**: Determine if failure is transient (environment), permanent (data), or systemic (code)
5. **Resolve**: Fix root cause, verify fix, then redrive affected messages

### Retention and Archival

- DLQ message retention: 14 days (must exceed source queue retention)
- Messages older than 14 days are archived to cold storage with full metadata
- Archived messages are searchable by `correlation_id`, `dead_letter_reason`, and `failure_timestamp`
- FIFO queue caveat: enqueue timestamp resets when moved to DLQ (per AWS documentation) — use `failure_timestamp` for accurate forensics timing

## Source Attribution

This design is grounded in verified sources:
- src-001: AWS SQS Dead Letter Queues documentation (https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html)
- src-002: Azure Service Bus Dead Letter Queues documentation (https://learn.microsoft.com/en-us/azure/service-bus-messaging/service-bus-dead-letter-queues)
- Existing knowledge: Circuit breaker states pattern (kb-concept-circuit-breaker-states.md)
