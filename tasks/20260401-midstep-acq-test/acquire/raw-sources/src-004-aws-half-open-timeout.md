# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-002

## Source URL
- https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/circuit-breaker.html

## Fetch Timestamp
- 2026-04-01T15:41:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — AWS Prescriptive Guidance, same authoritative source as src-002 but re-fetched specifically for half-open timeout and expiry content

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Multithreaded calls: The expiration timeout value is defined as the period of time the circuit remains tripped before calls are routed again to check for service availability. When the callee service is called in multiple threads, the first call that failed defines the expiration timeout value. Your implementation should ensure that subsequent calls do not move the expiration timeout endlessly.

Force open or close the circuit: System administrators should have the ability to open or close a circuit. This can be done by updating the expiration timeout value in the database table.

Periodic probing (HALF-OPEN): The circuit breaker object periodically tries to see if the calls to the payment service are successful.

Recovery (Circuit CLOSED again): When the call to payment service succeeds, the circuit is closed, and all further calls are routed to the payment service again.

The solution uses an Amazon DynamoDB table as the data store to track circuit status. This can be replaced with an in-memory datastore such as Amazon ElastiCache (Redis OSS) for better performance.

If CircuitStatus contains an unexpired record for the callee, the circuit is open — the Step Functions workflow returns an immediate failure and exits with a FAIL state.

If the CircuitStatus table doesn't contain a record for the callee or contains an expired record, the service is operational.

If the service call fails after the retries, the workflow inserts a record in the CircuitStatus table for the service with an ExpiryTimeStamp, and the workflow exits with a FAIL state.

The Get Circuit Status step checks service availability based on the ExpiryTimeStamp value. Expired items are deleted from the CircuitStatus table using the DynamoDB time to live (TTL) feature.

Circuit closure by callee: When the callee recovers from the performance issue or failure, they can update the circuit status to CLOSED. This is an extension of the circuit breaker pattern and can be implemented if your recovery time objective (RTO) requires it.
