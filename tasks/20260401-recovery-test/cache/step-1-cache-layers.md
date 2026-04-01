# Cache Layer Definitions

## Overview
This document defines the three cache layers for the API gateway caching strategy.

## Layer 1: Edge Cache

- **Position**: At the CDN/reverse proxy layer, closest to the client
- **What it caches**: Full HTTP responses for public, non-personalized endpoints (e.g., product listings, static configuration, public API responses)
- **Scope**: Shared across all users (no per-user data)
- **Primary purpose**: Reduce latency for geographically distributed clients and offload traffic from origin servers
- **Characteristics**: Highest hit rate for cacheable content, lowest latency, limited invalidation control

## Layer 2: Application Cache

- **Position**: Within the API gateway process, after authentication and routing
- **What it caches**: Computed results, aggregated responses, and per-user session data that survives across requests
- **Scope**: Mixed — shared cache for common computations, per-user cache for personalized data
- **Primary purpose**: Avoid redundant computation and database queries for frequently accessed resources
- **Characteristics**: Sub-millisecond access, bounded memory, supports both shared and user-scoped entries

## Layer 3: Data Cache

- **Position**: Between the API gateway and backend data stores (database, external services)
- **What it caches**: Query results, serialized entity objects, and external service responses
- **Scope**: Shared across all gateway instances (typically backed by a distributed cache like Redis)
- **Primary purpose**: Reduce load on backend databases and external services, provide resilience during backend degradation
- **Characteristics**: Network hop required, supports larger data volumes, enables cross-instance sharing, serves as a fallback during backend failures
