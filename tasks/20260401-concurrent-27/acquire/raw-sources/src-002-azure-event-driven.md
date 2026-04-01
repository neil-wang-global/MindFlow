# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Microsoft Azure Architecture Center — official vendor documentation from Microsoft

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

An event-driven architecture consists of event producers that generate a stream of events, event consumers that listen for these events, and event channels (often implemented as event brokers or ingestion services) that transfer events from producers to consumers.

Events are delivered in near real time, so consumers can respond immediately to events as they occur. Producers are decoupled from consumers, which means that a producer doesn't know which consumers are listening. Consumers are also decoupled from each other, and in a publish-subscribe model, every consumer sees all of the events.

This process differs from a Competing Consumers pattern. In the Competing Consumers pattern, consumers pull messages from a queue. Each message is processed only one time, assuming that there are no errors. In some systems, such as Azure IoT, events must be ingested at high volumes.

An event-driven architecture can use a publish-subscribe model or an event stream model.

Publish-subscribe: The publish-subscribe messaging infrastructure tracks subscriptions. When an event is published, it sends the event to each subscriber. After the event is received, it isn't stored in a durable log, so new subscribers don't see past events.

Event streaming: Events are written to a log. Events are strictly ordered within a partition and are durable. Clients don't subscribe to the stream. Instead, a client can read from any part of the stream. The client is responsible for advancing their position in the stream, which means that a client can join at any time and can replay events. This replayability supports recovery scenarios, late-arriving consumers, and reprocessing after a bug fix.

On the consumer side, there are some common variations:

Simple event processing: An event immediately triggers an action in the consumer.

Basic event correlation: A consumer processes a few discrete business events, correlates them by an identifier, and persists information from earlier events to use when it processes later events.

Complex event processing: A consumer uses a technology to analyze a series of events and identify patterns in the event data. For example, you can aggregate readings from an embedded device over a time window and generate a notification if the moving average exceeds a specific threshold.

Event stream processing: Use a data streaming platform as a pipeline to ingest events and feed them to stream processors. The stream processors act to process or transform the stream.

There are two primary approaches to structure event payloads:

Include all required attributes in the payload: Use this approach when you want consumers to have all available information without needing to query an external data source. Larger payloads increase transport cost and bandwidth consumption, and can lead to data consistency problems because of multiple systems of record, especially after updates.

Include only keys in the payload: In this approach, consumers retrieve the necessary attributes, such as a primary key, to independently fetch the remaining data from a data source. This method provides better data consistency because it has a single system of record.

There are two primary topologies in event-driven architectures:

Broker topology: Components broadcast events to the entire system. Other components either act on the event or ignore the event. This topology is useful when the event processing flow is relatively simple. This topology is highly decoupled, which helps provide scalability, responsiveness, and component fault tolerance.

Mediator topology: There's an event mediator that manages and controls the flow of events. The event mediator maintains the state and manages error handling and restart capabilities. This topology provides more control, better distributed error handling, and potentially better data consistency. However, it introduces increased coupling between components, and the event mediator can become a bottleneck or a reliability concern.

When to use this architecture:
- Multiple subsystems must process the same events.
- Real-time processing with minimum time lag is required.
- Complex event processing, such as pattern matching or aggregation over time windows, is required.
- High volume and high velocity of data are required, such as with IoT.
- You need to decouple producers and consumers for independent scalability and reliability goals.

This architecture might not be suitable when:
- The workload has simple request-response workflows where synchronous calls meet your latency and throughput requirements. The operational overhead of event brokers, asynchronous error handling, and eventual consistency isn't justified for straightforward interactions.
- Business transactions require strong consistency across services.
- Your team doesn't have experience operating distributed asynchronous systems.

Benefits:
- Producers and consumers are decoupled.
- There are no point-to-point integrations. New consumers can be added without modifying producers or other consumers.
- Consumers can respond to events immediately as they occur.
- It's highly scalable, elastic, and distributed.
- Subsystems have independent views of the event stream.

Challenges:
- Guaranteed delivery: In some systems, especially in IoT scenarios, it's crucial to guarantee that events are delivered.
- Eventual consistency: Because producers and consumers are decoupled through asynchronous event channels, data across services isn't immediately consistent after an event is published.
- Processing events in order or only one time: For resiliency and scalability, each consumer type typically runs in multiple instances, which can create challenges for event ordering and idempotent processing.
- Message coordination across services: Business processes often have multiple services that publish and subscribe to messages to achieve a consistent outcome.
- Error handling: Event-driven architecture primarily relies on asynchronous communication, making error handling more challenging.
- Data loss: If any components crash before successfully processing and handing over the event, the event may be dropped.
- Observability across decoupled components: Distributed tracing is harder in event-driven architectures because there is no shared call context.
