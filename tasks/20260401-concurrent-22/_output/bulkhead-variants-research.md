# Bulkhead Pattern Variants Research

## Task ID
- 20260401-concurrent-22

## Overview

The bulkhead pattern is a resilience design that isolates elements of an application into pools so that if one fails, the others continue to function. Named after the sectioned partitions of a ship's hull, the pattern prevents cascading failures by ensuring resource exhaustion in one component does not propagate to others.

This research examines three primary variants of the bulkhead pattern: thread pool bulkhead, semaphore bulkhead, and process-level isolation.

## Source

- Microsoft Azure Architecture Center: Bulkhead Pattern (src-001, verified)
  - URL: https://learn.microsoft.com/en-us/azure/architecture/patterns/bulkhead
  - Last updated: 2026-03-19

## Variant 1: Thread Pool Bulkhead

### Mechanism
Each service dependency receives its own dedicated thread pool. If a downstream service becomes slow or unresponsive, only the threads in its assigned pool are consumed. Other service pools remain unaffected and can continue processing requests normally.

### Trade-offs
- **Isolation strength**: Strong. Complete thread-level isolation between dependencies prevents thread starvation from propagating.
- **Resource overhead**: Moderate to high. Each thread pool consumes memory and OS resources even when idle. The number of pools multiplied by pool sizes can result in significant thread counts.
- **Context propagation**: Thread context (security context, transaction context, MDC logging) must be explicitly propagated across thread boundaries, adding implementation complexity.
- **Timeout support**: Native. Thread pool bulkheads can enforce timeouts by interrupting threads, providing strong latency guarantees.

### Use Cases
Per the Azure documentation, this approach is suitable "when you partition consumers into bulkheads" using thread pools. It is most appropriate for synchronous service-to-service calls where latency isolation is critical.

### Source Evidence
The Azure Architecture Center documentation states: "When you partition consumers into bulkheads, consider using processes, thread pools, and semaphores." It further illustrates bulkheads "structured around connection pools that call individual services" where "only workloads that use the thread pool assigned to Service A are affected."

## Variant 2: Semaphore Bulkhead

### Mechanism
Uses a counting semaphore to limit the number of concurrent calls to a service. Calls execute on the calling thread (no thread switch). When the semaphore limit is reached, additional calls are rejected immediately rather than queued.

### Trade-offs
- **Isolation strength**: Moderate. Limits concurrency but does not isolate the calling thread from downstream latency. If a downstream service is slow, the calling threads are still occupied for the duration.
- **Resource overhead**: Low. No additional thread pools are created. The semaphore is a lightweight concurrency primitive.
- **Context propagation**: Not needed. Since calls execute on the calling thread, all thread-local context is naturally available.
- **Timeout support**: Not native. The semaphore itself does not enforce timeouts on the downstream call. The client must implement its own timeout mechanism.

### Use Cases
Best suited for high-frequency, low-latency operations where the overhead of a dedicated thread pool would be disproportionate, such as in-memory cache lookups or fast local computations. Also appropriate for reactive/non-blocking architectures where thread context switching should be minimized.

### Source Evidence
The Azure documentation lists semaphores alongside processes and thread pools as mechanisms for consumer-side bulkhead partitioning. The lightweight nature of semaphores makes them the appropriate choice when full thread isolation is unnecessary.

## Variant 3: Process-Level Isolation

### Mechanism
Different components or service instances run in separate processes, virtual machines, or containers. Each process has its own memory space, CPU allocation, and resource limits. Failure in one process cannot directly consume resources of another.

### Trade-offs
- **Isolation strength**: Strongest. OS-level process isolation provides complete resource separation including memory, CPU, file descriptors, and network connections.
- **Resource overhead**: Highest. Each process requires its own runtime, memory footprint, and potentially its own OS instance (for VM-level isolation). Containers reduce this overhead compared to full VMs.
- **Communication complexity**: Inter-process communication requires network calls or IPC mechanisms, adding latency and serialization overhead compared to in-process bulkheads.
- **Operational complexity**: Requires container orchestration, service mesh, or VM management infrastructure.

### Use Cases
Per the Azure documentation: "When you partition services into bulkheads, consider deploying them into separate virtual machines, containers, or processes. Containers offer a good balance of resource isolation with fairly low overhead." This variant is appropriate when:
- Services have fundamentally different resource profiles (CPU-bound vs IO-bound)
- Security boundaries require process-level separation
- Independent scaling of each bulkhead is required

### Source Evidence
The Azure documentation states: "Containers offer a good balance of resource isolation with fairly low overhead." It also provides a concrete Kubernetes example of process-level isolation with CPU and memory resource limits on a pod.

Additionally: "Services that communicate by using asynchronous messages can be isolated through different sets of queues. Each queue can have a dedicated set of instances that process messages on the queue."

## Comparison Matrix

| Dimension | Thread Pool | Semaphore | Process-Level |
|-----------|------------|-----------|---------------|
| Isolation granularity | Thread-level | Concurrency limit | OS process/container |
| Resource overhead | Moderate-High | Low | Highest |
| Latency isolation | Yes (timeout) | No (caller blocked) | Yes (separate process) |
| Context propagation | Explicit needed | Natural | N/A (network boundary) |
| Implementation complexity | Moderate | Low | High (orchestration) |
| Failure blast radius | Thread pool only | Caller thread affected | Process only |
| Scaling independence | No (shared JVM) | No (shared JVM) | Yes (independent units) |

## Complementary Patterns

The Azure Architecture Center recommends combining bulkheads with:
- **Circuit breaker**: Prevents repeated calls to a failing service
- **Retry**: Handles transient failures with configurable retry logic
- **Throttling**: Controls resource consumption rates

## Key Considerations

1. **Granularity selection**: "Define partitions around the business and technical requirements of the application." Partition boundaries should align with bounded contexts when using domain-driven design.
2. **Technology-overhead balance**: Consider "the level of isolation offered by the technology and the overhead in terms of cost, performance, and manageability."
3. **Monitoring**: "Monitor each partition's performance and service-level agreement (SLA)."
4. **Platform controls**: "Use built-in platform controls" rather than re-implementing isolation mechanisms in application code.

## Relationship to Deferred Review

The deferred review (review-20260401-bulkhead-isolation.md) was deferred because the Resilience4j source failed to fetch, leaving insufficient cross-validation for a general "resource partitioning" framework conclusion. This research confirms from the Azure Architecture Center that the three variant categories (thread pool, semaphore, process-level) are explicitly documented as distinct isolation mechanisms, not synthesized from a single vague reference. This provides additional cross-validation evidence for the deferred review's subject matter.
