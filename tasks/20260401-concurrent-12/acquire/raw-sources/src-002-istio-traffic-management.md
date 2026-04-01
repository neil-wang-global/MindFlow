# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://istio.io/latest/docs/concepts/traffic-management/

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Istio project documentation hosted on istio.io

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Istio's traffic routing rules let you easily control the flow of traffic and API calls between services. Istio simplifies configuration of service-level properties like circuit breakers, timeouts, and retries, and makes it easy to set up important tasks like A/B testing, canary rollouts, and staged rollouts with percentage-based traffic splits. It also provides out-of-box reliability features that help make your application more resilient against failures of dependent services or the network.

Istio's traffic management model relies on the Envoy proxies that are deployed along with your services. All traffic that your mesh services send and receive (data plane traffic) is proxied through Envoy, making it easy to direct and control traffic around your mesh without making any changes to your services.

In order to direct traffic within your mesh, Istio needs to know where all your endpoints are, and which services they belong to. To populate its own service registry, Istio connects to a service discovery system. For example, if you've installed Istio on a Kubernetes cluster, then Istio automatically detects the services and endpoints in that cluster.

Using this service registry, the Envoy proxies can then direct traffic to the relevant services. Most microservice-based applications have multiple instances of each service workload to handle service traffic, sometimes referred to as a load balancing pool. By default, the Envoy proxies distribute traffic across each service's load balancing pool using a least requests model, where each request is routed to the host with fewer active requests from a random selection of two hosts from the pool.

The rest of this guide examines each of the traffic management API resources: Virtual services, Destination rules, Gateways, Service entries, Sidecars.

Virtual services: A virtual service lets you configure how requests are routed to a service within an Istio service mesh. Each virtual service consists of a set of routing rules that are evaluated in order, letting Istio match each given request to the virtual service to a specific real destination within the mesh.

Destination rules: Along with virtual services, destination rules are a key part of Istio's traffic routing functionality. You use destination rules to specify named service subsets, such as grouping all a given service's instances by version. Destination rules also let you customize Envoy's traffic policies when calling the entire destination service or a particular service subset, such as your preferred load balancing model, TLS security mode, or circuit breaker settings.

Load balancing options: By default, Istio uses a least requests load balancing policy. Istio also supports: Random, Weighted, Round robin, Consistent hash, Ring hash, Maglev.

Gateways: You use a gateway to manage inbound and outbound traffic for your mesh, letting you specify which traffic you want to enter or leave the mesh. Gateway configurations are applied to standalone Envoy proxies that are running at the edge of the mesh, rather than sidecar Envoy proxies running alongside your service workloads.

Service entries: You use a service entry to add an entry to the service registry that Istio maintains internally. After you add the service entry, the Envoy proxies can send traffic to the service as if it was a service in your mesh.

Sidecars: By default, Istio configures every Envoy proxy to accept traffic on all the ports of its associated workload, and to reach every workload in the mesh when forwarding traffic. You can use a sidecar configuration to fine-tune the set of ports and protocols that an Envoy proxy accepts, and limit the set of services that the Envoy proxy can reach.

Network resilience and testing:

Timeouts: A timeout is the amount of time that an Envoy proxy should wait for replies from a given service, ensuring that services don't hang around waiting for replies indefinitely.

Retries: A retry setting specifies the maximum number of times an Envoy proxy attempts to connect to a service if the initial call fails. The interval between retries (25ms+) is variable and determined automatically by Istio. The default retry behavior for HTTP requests is to retry twice before returning the error.

Circuit breakers: In a circuit breaker, you set limits for calls to individual hosts within a service, such as the number of concurrent connections or how many times calls to this host have failed. Once that limit has been reached the circuit breaker "trips" and stops further connections to that host. You configure circuit breaker thresholds in destination rules.

Fault injection: Istio lets you inject faults at the application layer. You can inject two types of faults: Delays (timing failures that mimic increased network latency) and Aborts (crash failures that mimic failures in upstream services).
