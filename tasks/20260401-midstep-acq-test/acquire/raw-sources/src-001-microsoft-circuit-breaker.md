# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker

## Fetch Timestamp
- 2026-04-01T15:32:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Microsoft Azure Architecture Center is an authoritative, professionally maintained reference for cloud design patterns

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

The Circuit Breaker pattern helps handle faults that might take varying amounts of time to recover from when an application connects to a remote service or resource. A circuit breaker temporarily blocks access to a faulty service after it detects failures. This action prevents repeated unsuccessful attempts so that the system can recover effectively. This pattern can improve the stability and resiliency of an application.

Context and problem

In a distributed environment, calls to remote resources and services can fail because of transient faults. Transient faults include overcommitted or temporarily unavailable resources, slow network connections, or time-outs. These faults typically correct themselves after a short period of time. To help manage these faults, you should design a cloud application to use a strategy, such as the Retry pattern.

Unanticipated events can create faults that take longer to fix. These faults can range in severity from a partial loss of connectivity to a complete service failure. In these situations, an application shouldn't continually retry an operation that's unlikely to succeed. Instead, the application should quickly recognize the failed operation and handle the failure accordingly.

If a service is busy, failure in one part of the system might lead to cascading failures. For example, you can configure an operation that invokes a service to implement a time-out. If the service fails to respond within this period, the operation replies with a failure message.

However, this strategy can block concurrent requests to the same operation until the time-out period expires. These blocked requests might hold critical system resources, such as memory, threads, and database connections. This problem can exhaust resources, which might fail other unrelated parts of the system that need to use the same resources.

In these situations, an operation should fail immediately and only attempt to invoke the service if it's likely to succeed. To resolve this problem, set a shorter time-out. But ensure that the time-out is long enough for the operation to succeed most of the time.

Solution

The Circuit Breaker pattern helps prevent an application from repeatedly trying to run an operation that's likely to fail. This pattern enables the application to continue running without waiting for the fault to be fixed or wasting CPU cycles on determining that the fault is persistent. The Circuit Breaker pattern also enables an application to detect when the fault is resolved. If the fault is resolved, the application can try to invoke the operation again.

A circuit breaker acts as a proxy for operations that might fail. The proxy should monitor the number of recent failures and use this information to decide whether to allow the operation to proceed or to return an exception immediately.

You can implement the proxy as a state machine that includes the following states. These states mimic the functionality of an electrical circuit breaker:

Closed: The request from the application is routed to the operation. The proxy maintains a count of the number of recent failures. If the call to the operation is unsuccessful, the proxy increments this count. If the number of recent failures exceeds a specified threshold within a given time period, the proxy is placed into the Open state and starts a time-out timer. When the timer expires, the proxy is placed into the Half-Open state. During the time-out, the system tries to fix the problem that caused the failure before it allows the application to attempt the operation again.

Open: The request from the application fails immediately and an exception is returned to the application.

Half-Open: A limited number of requests from the application are allowed to pass through and invoke the operation. If these requests are successful, the circuit breaker assumes that the fault that caused the failure is fixed, and the circuit breaker switches to the Closed state. The failure counter is reset. If any request fails, the circuit breaker assumes that the fault is still present, so it reverts to the Open state. It restarts the time-out timer so that the system can recover from the failure. The Half-Open state helps prevent a recovering service from suddenly being flooded with requests. As a service recovers, it might be able to support a limited volume of requests until the recovery is complete. But while recovery is in progress, a flood of work can cause the service to time out or fail again.

The failure counter for the Closed state is time based. It automatically resets at periodic intervals. This design helps prevent the circuit breaker from entering the Open state if it experiences occasional failures. The failure threshold triggers the Open state only when a specified number of failures occur during a specified interval.

The success counter for the Half-Open state records the number of successful attempts to invoke the operation. The circuit breaker reverts to the Closed state after a specified number of successful, consecutive operation invocations. If any invocation fails, the circuit breaker enters the Open state immediately and the success counter resets the next time it enters the Half-Open state.

Problems and considerations

Consider the following factors when you implement this pattern:

Exception handling: An application that invokes an operation through a circuit breaker must be able to handle the exceptions if the operation is unavailable.

Types of exceptions: The reasons for a request failure can vary in severity. A circuit breaker might be able to examine the types of exceptions that occur and adjust its strategy based on the nature of these exceptions.

Monitoring: A circuit breaker should provide clear observability into both failed and successful requests so that operations teams can assess system health.

Recoverability: You should configure the circuit breaker to match the likely recovery pattern of the operation that it protects.

Failed operations testing: In the Open state, rather than using a timer to determine when to switch to the Half-Open state, a circuit breaker can periodically ping the remote service or resource to determine whether it's available.

Manual override: If the recovery time for a failing operation is extremely variable, you should provide a manual reset option.

Concurrency: A large number of concurrent instances of an application can access the same circuit breaker.

Resource differentiation: Be careful when you use a single circuit breaker for one type of resource if there might be multiple underlying independent providers.

Accelerated circuit breaking: Sometimes a failure response can contain enough information for the circuit breaker to trip immediately.

Multiregion deployments: You can design a circuit breaker for single region or multiregion deployments.

Service mesh circuit breakers: You can implement circuit breakers at the application layer or as a cross-cutting, abstracted feature.

Failed request replay: In the Open state, rather than failing immediately, a circuit breaker can record the details of each request in a journal and arrange for these requests to be replayed when the remote resource or service becomes available.

Inappropriate time-outs on external services: A circuit breaker might not fully protect applications from failures in external services that have long time-out periods.
