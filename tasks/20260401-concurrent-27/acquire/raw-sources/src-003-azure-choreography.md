# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/patterns/choreography

## Fetch Timestamp
- 2026-04-01T10:04:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Microsoft Azure Architecture Center — official vendor documentation on choreography pattern

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Choreography pattern: Decentralize workflow logic and distribute the responsibilities to other components within a system.

Context and problem: A cloud-based application is often divided into several small services that work together to process a business transaction end-to-end. Even a single operation (within a transaction) can result in multiple point-to-point calls among all services. Ideally, those services should be loosely coupled. It's challenging to design a workflow that's distributed, efficient, and scalable because it often involves complex interservice communication.

A common pattern for communication is to use a centralized service or an orchestrator. Incoming requests flow through the orchestrator as it delegates operations to the respective services. Each service just completes their responsibility and isn't aware of the overall workflow.

However, there are some drawbacks. Adding or removing services might break existing logic because you need to rewire portions of the communication path. This dependency makes orchestrator implementation complex and hard to maintain. The orchestrator might have a negative impact on the reliability of the workload. Under load, it can introduce performance bottleneck and be the single point of failure. It can also cause cascading failures in the downstream services.

Solution: Delegate the transaction handling logic among the services. Let each service decide and participate in the communication workflow for a business operation. The pattern is a way to minimize dependency on custom software that centralizes the communication workflow. The components implement common logic as they choreograph the workflow among themselves without having direct communication with each other.

A common way to implement choreography is to use a message broker that buffers requests until downstream components claim and process them.

Issues and considerations:
- Handling failures can be challenging. Components in an application might conduct atomic tasks but they might still have a level of dependency. Failure in one component can affect others, which might cause delays in completing the overall request. Implementing compensating transactions might introduce complexity.
- The pattern is suitable for a workflow where independent business operations are processed in parallel. The workflow can become complicated when choreography needs to occur in a sequence.
- The pattern becomes a challenge if the number of services grows rapidly. Given the high number of independent moving parts, the workflow between services tends to get complex. Distributed tracing also becomes difficult.
- In an orchestrator-led design, the central component can partially participate and delegate resiliency logic to another component that retries transient, nontransient, and timeout failures, consistently. With the dissolution of the orchestrator in the choreography pattern, the downstream components shouldn't pick up those resiliency tasks.

When to use this pattern:
- The downstream components handle atomic operations independently (fire and forget).
- You expect the components to get updated and replaced frequently.
- You use serverless architectures for simple workflows.
- Communication between bounded contexts requires loose coupling across domain boundaries.
- There's performance bottleneck introduced by the central orchestrator.

This pattern might not be useful when:
- The application is complex and requires a central component to handle shared logic.
- There are situations where point-to-point communication between the components is inevitable.
- You need to consolidate all operations that downstream components handle by using business logic.
