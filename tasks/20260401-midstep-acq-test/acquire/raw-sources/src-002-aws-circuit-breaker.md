# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/circuit-breaker.html

## Fetch Timestamp
- 2026-04-01T15:33:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — AWS Prescriptive Guidance is an authoritative, professionally maintained reference for cloud design patterns

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

The circuit breaker pattern can prevent a caller service from retrying a call to another service (callee) when the call has previously caused repeated timeouts or failures. The pattern is also used to detect when the callee service is functional again.

Motivation

When multiple microservices collaborate to handle requests, one or more services might become unavailable or exhibit high latency. When complex applications use microservices, an outage in one microservice can lead to application failure. Microservices communicate through remote procedure calls, and transient errors could occur in network connectivity, causing failures. During synchronous execution, the cascading of timeouts or failures can cause a poor user experience.

However, in some situations, the failures could take longer to resolve—for example, when the callee service is down or a database contention results in timeouts. In such cases, if the calling service retries the calls repeatedly, these retries might result in network contention and database thread pool consumption. Additionally, if multiple users are retrying the application repeatedly, this will make the problem worse and can cause performance degradation in the entire application.

The circuit breaker pattern was popularized by Michael Nygard in his book, Release It (Nygard 2018). This design pattern can prevent a caller service from retrying a service call that has previously caused repeated timeouts or failures. It can also detect when the callee service is functional again.

Circuit breaker objects work like electrical circuit breakers that automatically interrupt the current when there is an abnormality in the circuit. Electrical circuit breakers shut off, or trip, the flow of the current when there is a fault. Similarly, the circuit breaker object is situated between the caller and the callee service, and trips if the callee is unavailable.

Applicability

Use this pattern when:
- The caller service makes a call that is most likely going to fail.
- A high latency exhibited by the callee service (for example, when database connections are slow) causes timeouts to the caller service.
- The caller service makes a synchronous call, but the callee service isn't available or exhibits high latency.

Issues and Considerations

- Service agnostic implementation: To prevent code bloat, we recommend that you implement the circuit breaker object in a microservice-agnostic and API-driven way.
- Circuit closure by callee: When the callee recovers from the performance issue or failure, they can update the circuit status to CLOSED. This is an extension of the circuit breaker pattern and can be implemented if your recovery time objective (RTO) requires it.
- Multithreaded calls: The expiration timeout value is defined as the period of time the circuit remains tripped before calls are routed again to check for service availability. When the callee service is called in multiple threads, the first call that failed defines the expiration timeout value. Your implementation should ensure that subsequent calls do not move the expiration timeout endlessly.
- Force open or close the circuit: System administrators should have the ability to open or close a circuit. This can be done by updating the expiration timeout value in the database table.
- Observability: The application should have logging set up to identify the calls that fail when the circuit breaker is open.

Implementation — High-level Architecture — States and Transitions

No failures (Circuit CLOSED): The order service routes all calls to the payment service through the circuit breaker normally.

Failure detection: If the payment service times out, the circuit breaker detects the timeout and tracks the failure.

Threshold exceeded (Circuit OPEN): If the timeouts exceed a specified threshold, the application opens the circuit. When the circuit is open, the circuit breaker object doesn't route the calls to the payment service. It returns an immediate failure when the order service calls the payment service.

Periodic probing (HALF-OPEN): The circuit breaker object periodically tries to see if the calls to the payment service are successful.

Recovery (Circuit CLOSED again): When the call to payment service succeeds, the circuit is closed, and all further calls are routed to the payment service again.

Implementation Using AWS Services

The solution uses express workflows in AWS Step Functions to implement the circuit breaker pattern. The Step Functions state machine provides retry capabilities and decision-based control flow.

The solution uses an Amazon DynamoDB table as the data store to track circuit status. This can be replaced with an in-memory datastore such as Amazon ElastiCache (Redis OSS) for better performance.

Flow:
1. When a service wants to call another service, it starts the workflow with the name of the callee service.
2. The workflow gets the circuit breaker status from the DynamoDB CircuitStatus table, which stores currently degraded services.
3. If CircuitStatus contains an unexpired record for the callee, the circuit is open — the Step Functions workflow returns an immediate failure and exits with a FAIL state.
4. If the CircuitStatus table doesn't contain a record for the callee or contains an expired record, the service is operational. The ExecuteLambda step calls the Lambda function sent through a parameter value. If the call succeeds, the workflow exits with a SUCCESS state.
5. If the service call fails or times out, the application retries with exponential backoff for a defined number of times.
6. If the service call fails after the retries, the workflow inserts a record in the CircuitStatus table for the service with an ExpiryTimeStamp, and the workflow exits with a FAIL state.
7. Subsequent calls to the same service return an immediate failure as long as the circuit breaker is open.
8. The Get Circuit Status step checks service availability based on the ExpiryTimeStamp value. Expired items are deleted from the CircuitStatus table using the DynamoDB time to live (TTL) feature.
