# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://microservices.io/patterns/client-side-discovery.html

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Chris Richardson is a recognized authority on microservices architecture patterns; microservices.io is the canonical reference for microservices patterns

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Pattern: Client-side service discovery

## Context

Services typically need to call one another. In a monolithic application, services invoke one another through language-level method or procedure calls. In a traditional distributed system deployment, services run at fixed, well known locations (hosts and ports) and so can easily call one another using HTTP/REST or some RPC mechanism. However, a modern microservice-based application typically runs in a virtualized or containerized environments where the number of instances of a service and their locations changes dynamically.

## Problem

How does the client of a service - the API gateway or another service - discover the location of a service instance?

## Forces

- Each instance of a service exposes a remote API such as HTTP/REST, or Thrift etc. at a particular location (host and port)
- The number of services instances and their locations changes dynamically
- Virtual machines and containers are usually assigned dynamic IP addresses
- The number of services instances might vary dynamically. For example, an EC2 Autoscaling Group adjusts the number of instances based on load

## Solution

When making a request to a service, the client obtains the location of a service instance by querying a Service Registry, which knows the locations of all service instances.

The following diagram shows the structure of this pattern.

The client-side service discovery pattern works as follows:

1. The service instance registers its network location with the service registry on startup
2. The service registry entry is refreshed using a heartbeat mechanism
3. The client queries the service registry to find available instances
4. The client then uses a load-balancing algorithm to select one of the available service instances and makes a request

## Examples

The Netflix/Pivotal Netflix OSS project provides a great example of client-side discovery:

- Netflix Eureka is a service registry
- Netflix Ribbon is an IPC client that works with Eureka to load balance requests across the available service instances

## Resulting context

Client-side discovery has the following benefits:
- Fewer moving parts and network hops compared to Server-side Discovery

Client-side discovery also has the following drawbacks:
- This pattern couples the client to the Service Registry
- You need to implement client-side service discovery logic for each programming language/framework used by your service clients, e.g. Netflix Ribbon for Java, etc.

## Related patterns

- Service Registry
- Server-side discovery is an alternative solution
- Self registration
- 3rd party registration

---

# Pattern: Server-side service discovery

## Context

Services typically need to call one another. In a monolithic application, services invoke one another through language-level method or procedure calls. In a traditional distributed system deployment, services run at fixed, well known locations (hosts and ports) and so can easily call one another using HTTP/REST or some RPC mechanism. However, a modern microservice-based application typically runs in a virtualized or containerized environments where the number of instances of a service and their locations changes dynamically.

## Problem

How does the client of a service - the API gateway or another service - discover the location of a service instance?

## Solution

When making a request to a service, the client makes a request via a router (a.k.a load balancer) that runs at a well known location. The router queries a service registry, which might be built into the router, and forwards the request to an available service instance.

The following diagram shows the structure of this pattern.

The server-side service discovery pattern works as follows:

1. The service instance registers its network location with the service registry on startup
2. The client sends a request to the router (load balancer)
3. The router queries the service registry and forwards the request to an available instance

## Examples

An AWS Elastic Load Balancer (ELB) is an example of server-side discovery. A client makes requests (HTTP or TCP) via the ELB using its DNS name. The ELB load balances the traffic among a set of registered EC2 instances or ECS containers. There isn't a separate service registry. Instead, the EC2 instances and ECS containers are registered with the ELB itself.

Kubernetes also uses server-side service discovery. Kubernetes creates a DNS name for each service. A client sends a request using the DNS name. Kubernetes acts as a service registry and routes the request to an available instance using built-in kube-proxy.

## Resulting context

Server-side discovery has a number of benefits:
- Compared to client-side discovery, the client code is simpler since it does not have to deal with discovery. Instead, a client simply makes a request to the router
- Many deployment environments already provide this functionality (e.g. Kubernetes, AWS ELB)

Server-side discovery also has the following drawbacks:
- Unless it's part of the deployment environment, the router must be a highly available system component
- The router is another moving part that must be installed and configured
- The router can become a bottleneck

## Related patterns

- Service Registry
- Client-side discovery is an alternative solution
- Self registration
- 3rd party registration
