# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-002

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker

## Fetch Timestamp
- 2026-04-01T15:40:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Microsoft Azure Architecture Center, same authoritative source as src-001 but re-fetched specifically for half-open state timeout content

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Recoverability: You should configure the circuit breaker to match the likely recovery pattern of the operation that it protects. For example, if the circuit breaker remains in the Open state for a long period, it can raise exceptions even if the reason for the failure is resolved. Similarly, a circuit breaker can fluctuate and reduce the response times of applications if it switches from the Open state to the Half-Open state too quickly.

Failed operations testing: In the Open state, rather than using a timer to determine when to switch to the Half-Open state, a circuit breaker can periodically ping the remote service or resource to determine whether it's available. This ping can either attempt to invoke a previously failed operation or use a special health-check operation that the remote service provides.

You can customize and adapt this pattern to different types of failures. For example, you can apply an increasing time-out timer to a circuit breaker. You can place the circuit breaker in the Open state for a few seconds initially. If the failure isn't resolved, increase the time-out to a few minutes and adjust accordingly. In some cases, rather than returning a failure and raising an exception, the Open state can return a default value that's meaningful to the application.

Traditionally, circuit breakers relied on preconfigured thresholds, such as failure count and time-out duration. This approach resulted in a deterministic but sometimes suboptimal behavior. Adaptive techniques that use AI and machine learning can dynamically adjust thresholds based on real-time traffic patterns, anomalies, and historical failure rates. This approach improves resiliency and efficiency.

Inappropriate time-outs on external services: A circuit breaker might not fully protect applications from failures in external services that have long time-out periods. If the time-out is too long, a thread that runs a circuit breaker might be blocked for an extended period before the circuit breaker indicates that the operation failed. During this time, many other application instances might also try to invoke the service through the circuit breaker and tie up numerous threads before they all fail.

Half-Open: A limited number of requests from the application are allowed to pass through and invoke the operation. If these requests are successful, the circuit breaker assumes that the fault that caused the failure is fixed, and the circuit breaker switches to the Closed state. The failure counter is reset. If any request fails, the circuit breaker assumes that the fault is still present, so it reverts to the Open state. It restarts the time-out timer so that the system can recover from the failure. The Half-Open state helps prevent a recovering service from suddenly being flooded with requests. As a service recovers, it might be able to support a limited volume of requests until the recovery is complete. But while recovery is in progress, a flood of work can cause the service to time out or fail again.

The success counter for the Half-Open state records the number of successful attempts to invoke the operation. The circuit breaker reverts to the Closed state after a specified number of successful, consecutive operation invocations. If any invocation fails, the circuit breaker enters the Open state immediately and the success counter resets the next time it enters the Half-Open state.

After a predefined time-out, the circuit breaker enters a Half-Open state that permits a limited number of trial requests. If these trial requests succeed without returning 429 responses, the breaker resets to a Closed state, and normal operations restore back. If failures persist, the breaker reverts to the Open state.
