# Bulkhead Pattern Isolation Strategies

## Overview

The bulkhead pattern is a resilience design pattern for distributed systems that isolates elements of an application into pools so that if one fails, others continue to function. Named after the sectioned partitions in ship hulls that prevent a single breach from sinking the entire vessel, the pattern applies the same containment principle to software systems.

In a bulkhead architecture (also known as cell-based architecture), service instances or consumer resources are partitioned into groups based on load and availability requirements. This isolation ensures that a failure or resource exhaustion in one partition does not cascade to affect other partitions.

## Core Problem Addressed

In cloud-based and distributed applications, multiple services interact with multiple consumers. Without isolation:

- Excessive load or failure in one service affects all consumers of that service
- A consumer sending requests to multiple services simultaneously may exhaust shared resources (e.g., connection pools) when one downstream service becomes unresponsive
- Resource exhaustion creates cascading failure: a consumer unable to reach one service eventually becomes unable to reach any service

## Isolation Strategies

### 1. Connection Pool Isolation

Assign dedicated connection pools per downstream service. If a service begins to fail, only its assigned connection pool is exhausted. The consumer can continue using other services through their separate pools.

**Grounded in**: Microsoft Azure Architecture Center — "a consumer that calls multiple services might be assigned a connection pool for each service. If a service begins to fail, it only affects the connection pool assigned for that service."

### 2. Thread Pool Isolation

Dedicate separate thread pools per dependency. A slow or failing dependency exhausts only its own thread pool, preventing it from monopolizing shared application threads.

**Referenced in**: Azure Architecture Center mentions thread pools as a consumer partitioning mechanism alongside processes and semaphores.

### 3. Semaphore Isolation

Use semaphores (concurrency limiters) to cap the number of concurrent calls to a particular dependency. Lighter weight than thread pool isolation since calls execute on the calling thread.

**Referenced in**: Azure Architecture Center mentions semaphores as a consumer partitioning mechanism alongside processes and thread pools.

### 4. Process and Container Isolation

Deploy services into separate virtual machines, containers, or processes. Containers provide a good balance of resource isolation with relatively low overhead.

**Grounded in**: Microsoft Azure Architecture Center — "When you partition services into bulkheads, consider deploying them into separate virtual machines, containers, or processes. Containers offer a good balance of resource isolation with fairly low overhead."

### 5. Queue-Based Isolation

Services communicating via asynchronous messages can be isolated through different sets of queues. Each queue can have dedicated instances processing messages, or a single group of instances using an algorithm to dequeue and dispatch.

**Grounded in**: Microsoft Azure Architecture Center — "Services that communicate by using asynchronous messages can be isolated through different sets of queues."

## Implementation Considerations

- Partition boundaries should align with business and technical requirements; in domain-driven design, they should align with bounded contexts
- Consider combining bulkheads with retry, circuit breaker, and throttling patterns for sophisticated fault handling
- Determine granularity level: tenant-per-partition or multiple-tenants-per-partition
- Monitor each partition's performance and SLA
- Use platform-native controls (rate limits, resource quotas, container resource limits) rather than reimplementing isolation in application code

## When to Use

Use the bulkhead pattern when:
- Isolating resources for specific dependencies to prevent service-wide disruption
- Isolating critical consumers from standard consumers
- Protecting against cascading failures

The pattern may not be suitable when:
- Less efficient resource utilization is unacceptable
- The added complexity is not justified by the failure risk

## Sources

- src-001: Microsoft Azure Architecture Center — Bulkhead Pattern (https://learn.microsoft.com/en-us/azure/architecture/patterns/bulkhead) — verified, passed
