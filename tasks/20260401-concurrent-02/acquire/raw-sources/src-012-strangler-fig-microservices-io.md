# Raw Source

## Source ID
- src-012

## ACQ Event
- ACQ-003

## Source URL
- https://microservices.io/patterns/refactoring/strangler-application.html

## Fetch Timestamp
- 2026-04-01T10:50:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Chris Richardson's canonical microservice pattern catalog

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Pattern: Strangler Application

## Context

You have a large, complex monolithic application and want to migrate it to microservices.

## Problem

How do you migrate a legacy monolithic application to a microservice architecture?

## Solution

Modernize an application by incrementally developing a new (strangler) application around the legacy application. The strangler application consists of two types of services:

1. **Services that implement functionality previously provided by the monolith** — these services gradually replace monolith features
2. **Services that implement new functionality** — these services extend the system beyond the monolith's capabilities

The strangler application communicates with the legacy monolith through an anti-corruption layer, which translates between the two systems' domain models.

Over time, the strangler application replaces the monolith, and the monolith can be decommissioned.

## How it works

The key mechanism is a routing layer (proxy/facade) that sits between clients and the backend:

1. Initially, all requests are routed to the monolith
2. As new microservices are built, the routing layer is updated to redirect specific requests to the new services
3. The monolith continues to handle everything else
4. Eventually, all requests are handled by microservices

### Anti-Corruption Layer (ACL)

The ACL is critical because:
- The new microservices have their own domain model, which may differ significantly from the monolith's model
- Without an ACL, the new services would need to understand the monolith's internal representations
- The ACL translates requests and responses between the two systems
- It isolates the new system from legacy design decisions

Types of ACL implementation:
- **Facade**: simplifies the interface to the legacy system
- **Adapter**: converts the legacy interface to the new system's expected interface
- **Translation service**: a separate service that handles bidirectional model translation

## Benefits

- Reduces risk compared to big-bang rewrites
- Enables incremental delivery of business value
- Teams can learn from experience as migration progresses
- Existing functionality remains available throughout migration
- Rollback is possible at any point by redirecting traffic

## Drawbacks

- Adds complexity of maintaining two systems simultaneously
- Data consistency between systems must be managed
- Additional latency from the routing layer
- Requires organizational commitment to complete the migration

## Related Patterns

- Anti-Corruption Layer — used to translate between old and new systems
- API Gateway — often used as the routing mechanism
- Backend for Frontend (BFF) — can be combined with Strangler for UI-specific migrations
