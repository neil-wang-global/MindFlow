# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/microservices/design/data-considerations

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Microsoft Azure Architecture Center documentation, maintained by Microsoft cloud architecture team

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

This article describes considerations for managing data in a microservices architecture. Each microservice manages its own data, so data integrity and data consistency pose critical challenges.

Two services shouldn't share a data store. Each service manages its own private data store, and other services can't access it directly. This rule prevents unintentional coupling between services, which happens when services share the same underlying data schemas. If the data schema changes, the change must be coordinated across every service that relies on that database. Isolating each service's data store limits the scope of change and preserves the agility of independent deployments. Each microservice might also have unique data models, queries, or read and write patterns. A shared data store limits each team's ability to optimize data storage for its specific service.

This approach naturally leads to polyglot persistence, which means using multiple data storage technologies within a single application. One service might need the schema-on-read capabilities of a document database. Another service might need the referential integrity that a relational database management system (RDBMS) provides. Each team can choose the best option for its service.

Note: Services can safely share the same physical database server. Problems occur when services share the same schema, or they read and write to the same set of database tables.

## Challenges

The distributed approach to managing data introduces several challenges. First, redundancy can occur across data stores. The same data item might appear in multiple places. For example, data might be stored as part of a transaction and then stored elsewhere for analytics, reporting, or archiving. Duplicated or partitioned data can lead to problems with data integrity and consistency. When data relationships span multiple services, traditional data management techniques can't enforce those relationships.

Traditional data modeling follows the rule of one fact in one place. Every entity appears exactly once in the schema. Other entities might reference it but not duplicate it. The main advantage of the traditional approach is that updates occur in a single place, which prevents data consistency problems. In a microservices architecture, you must consider how updates propagate across services and how to manage eventual consistency when data appears in multiple places without strong consistency.

## Approaches to managing data

No single approach works for all cases. Consider the following general guidelines to manage data in a microservices architecture:

- Define the required consistency level for each component, and prefer eventual consistency where possible. Identify areas in the system where you need strong consistency or atomicity, consistency, isolation, and durability (ACID) transactions. And identify areas where eventual consistency is acceptable.
- Use a single source of truth when you require strong consistency. One service might represent the source of truth for a given entity and expose it through an API. Other services might hold their own copy of the data, or a subset of the data, that's eventually consistent with the primary data but not considered the source of truth. For example, in an e-commerce system that has a customer order service and a recommendation service, the recommendation service might listen to events from the order service. But if a customer requests a refund, the order service, not the recommendation service, has the complete transaction history.
- Apply transaction patterns to maintain consistency across services. Use patterns like Scheduler Agent Supervisor and Compensating Transaction to keep data consistent across multiple services. To avoid partial failure among multiple services, you might need to store an extra piece of data that captures the state of a unit of work that spans multiple services.
- Store only the data that a service needs. A service might only need a subset of information about a domain entity. For example, in the shipping bounded context, you need to know which customer is associated with a specific delivery. But you don't need the customer's billing address because the accounts bounded context manages that information.
- Consider whether your services are coherent and loosely coupled. If two services continually exchange information with each other and create chatty APIs, you might need to redraw your service boundaries. Merge the two services or refactor their functionality.
- Use an event-driven architecture style. In this architecture style, a service publishes an event when changes to its public models or entities occur. Other services can subscribe to these events.

## Example: Choose data stores for the drone delivery application

The previous articles in this series describe a drone delivery service as a running example.

### Delivery service
The delivery service stores information about every delivery that's currently scheduled or in progress. It listens for events from the drones and tracks the status of deliveries in progress. It also sends domain events with delivery status updates.

Users frequently check the status of a delivery while they wait for their package. So the delivery service requires a data store that emphasizes throughput (read and write) over long-term storage. The delivery service doesn't do complex queries or analysis. It only fetches the latest status for a specific delivery. The delivery service team chose Azure Managed Redis for its high read-write performance. The information stored in Azure Managed Redis is short-lived. After a delivery finishes, the delivery history service becomes the system of record.

### Delivery history service
The delivery history service listens for delivery status events from the delivery service. It stores this data in long-term storage. This historical data supports two scenarios, each with different storage requirements.

The first scenario aggregates data for data analytics to optimize the business or improve service quality. For this scenario, the storage must be optimized for data analysis over large datasets and use a schema-on-read approach. Azure Data Lake Storage is a good fit for this scenario.

The second scenario lets users look up the history of a delivery after the delivery finishes. To address this problem, the delivery history service also stores a subset of the historical data in Azure Cosmos DB for quicker lookup.

### Package service
The package service stores information about all packages. The data store requirements: long-term storage, high write throughput, simple queries by package ID without complex joins. The package data isn't relational, so a document-oriented database works well. Azure DocumentDB can achieve high throughput by using sharded collections.
