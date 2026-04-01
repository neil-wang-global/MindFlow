# Raw Source

## Source ID
- src-010

## ACQ Event
- ACQ-003

## Source URL
- https://learn.microsoft.com/en-us/azure/architecture/patterns/strangler-fig

## Fetch Timestamp
- 2026-04-01T10:48:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Microsoft Azure official architecture patterns documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Strangler Fig pattern

Incrementally migrate a legacy system by gradually replacing specific pieces of functionality with new applications and services. As features from the legacy system are replaced, the new system eventually replaces all of the old system's features, strangling the old system and allowing you to decommission it.

## Context and problem

As systems age, the development tools, hosting technology, and even system architectures they were built on can become increasingly obsolete. As new features and functionality are added, the complexity of these applications can increase dramatically, making them harder to maintain or add new features to.

Completely replacing a complex system can be a huge undertaking. Often, you will need to gradually migrate to a new system, while keeping the old system to handle features that haven't been migrated yet.

## Solution

Incrementally replace specific pieces of functionality with new applications and services. Create a facade that intercepts requests going to the backend legacy system. The facade routes these requests either to the legacy application or the new services. Existing features can be migrated to the new system gradually, and consumers can continue using the same interface, unaware that any migration has taken place.

### Implementation steps

1. **Create the facade/proxy layer**: Set up a routing mechanism (API gateway, reverse proxy, or load balancer) that sits between clients and the backend systems

2. **Migrate incrementally**: For each piece of functionality to migrate:
   - Build the new implementation
   - Route traffic to the new implementation
   - Verify the new implementation works correctly
   - Remove the old implementation when confident

3. **Use an Anti-Corruption Layer**: When the new system needs to communicate with the legacy system:
   - Create translation services between old and new models
   - Prevent legacy concepts from leaking into the new system
   - Keep the boundary clean for eventual complete migration

4. **Handle data migration**: Data may need to be synchronized or migrated:
   - Keep data in sync during transition using events or replication
   - Plan for the final data migration when decommissioning the old system

### Routing strategies

- **URL-based routing**: Route by URL path or pattern (e.g., /api/v2/* goes to new system)
- **Header-based routing**: Route based on request headers (e.g., feature flags)
- **Percentage-based routing**: Gradually shift traffic percentage from old to new (canary deployment)

## When to use this pattern

- When you need to gradually migrate a backend application to a new architecture
- When a big-bang approach to migration is too risky
- When the application can be transformed into multiple functional areas

## Considerations

- The facade/proxy must handle both old and new service routing correctly
- Data stores may need to be shared or synchronized during migration
- The migration may stall or become permanent if not managed as an active project
- Network latency may be added by the routing layer
- The pattern needs to handle failure in both old and new systems gracefully
