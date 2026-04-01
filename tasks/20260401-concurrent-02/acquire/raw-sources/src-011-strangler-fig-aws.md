# Raw Source

## Source ID
- src-011

## ACQ Event
- ACQ-003

## Source URL
- https://docs.aws.amazon.com/prescriptive-guidance/latest/modernization-decomposing-monoliths/strangler-fig.html

## Fetch Timestamp
- 2026-04-01T10:49:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — AWS official prescriptive guidance for application modernization

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Strangler Fig pattern

The Strangler Fig pattern is a modernization approach that incrementally replaces a monolithic application with microservices.

## Overview

Named after the strangler fig tree that grows around a host tree and eventually replaces it, this pattern involves gradually replacing components of the legacy application with new services.

The pattern works by:
1. Identifying components in the monolith that can be extracted
2. Building new microservices to replace those components
3. Redirecting traffic from the monolith to the new services using a routing layer
4. Eventually decommissioning the monolith when all components have been migrated

## Implementation with AWS services

### Routing layer options
- **Amazon API Gateway**: Routes API requests to either the monolith or new microservices based on URL paths
- **Application Load Balancer (ALB)**: Distributes traffic based on content rules
- **AWS App Mesh**: Service mesh for routing between old and new services

### Anti-Corruption Layer implementation
The Anti-Corruption Layer (ACL) is crucial during migration:
- Implemented as a separate service or library that translates between the monolith's data model and the microservice's domain model
- Prevents the new microservices from being polluted by legacy conventions
- Can use AWS Lambda for lightweight translation or ECS/EKS for more complex translation services
- Should be treated as temporary infrastructure that is removed after migration completes

### Migration phases

**Phase 1: Assess and Plan**
- Map the monolith's domain boundaries
- Identify the least coupled components for initial migration
- Set up monitoring for both systems

**Phase 2: Establish the Facade**
- Deploy the routing layer (API Gateway or ALB)
- Configure it to route all traffic to the monolith initially
- Add monitoring and logging at the routing layer

**Phase 3: Migrate Incrementally**
- Build and deploy the first microservice
- Update routing rules to direct relevant traffic to the new service
- Monitor and verify correctness
- Repeat for additional components

**Phase 4: Decommission**
- When all components are migrated, remove routing to the monolith
- Decommission the monolith
- Simplify the routing layer (may no longer need the facade)

## Best practices

- Start with the least coupled and least critical components
- Maintain feature parity during migration — don't change behavior while migrating
- Use feature flags to control traffic routing
- Keep the ACL thin — don't let it become a second monolith
- Set deadlines for the migration to prevent it from stalling
- Invest in automated testing that covers both old and new paths
