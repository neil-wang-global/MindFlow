# Task Learning Record

## Task ID
- 20260401-concurrent-24

## Task Summary
- Researched service discovery patterns in distributed systems
- Produced a structured research summary covering DNS-based discovery, client-side vs server-side patterns, and Consul/etcd comparison in _output/service-discovery-research.md

## External Acquisition

### ACQ-001: Service discovery patterns knowledge gap

- **Trigger**: step-triggered: Step 1
- **Status**: completed
- **Verification Report**: tasks/20260401-concurrent-24/acquire/verification-report.md §ACQ-001
- **Passed Sources**: src-001, src-002

## Candidate Knowledge

### [KDC-001] Client-side vs server-side service discovery trade-offs

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-24/acquire/raw-sources/src-001-service-discovery-patterns.md
- **Verification Status**: passed
- **Original Excerpt**: > "When making a request to a service, the client obtains the location of a service instance by querying a Service Registry, which knows the locations of all service instances."
- **Derived Conclusion**: In client-side service discovery, the calling service bears responsibility for querying the service registry and selecting an instance via load balancing. This gives clients more control and eliminates a network hop, but couples every client to the registry and requires discovery logic in each language/framework.

### [KDC-002] Server-side discovery simplifies clients at the cost of a routing intermediary

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-24/acquire/raw-sources/src-001-service-discovery-patterns.md
- **Verification Status**: passed
- **Original Excerpt**: > "When making a request to a service, the client makes a request via a router (a.k.a load balancer) that runs at a well known location. The router queries a service registry, which might be built into the router, and forwards the request to an available service instance."
- **Derived Conclusion**: Server-side service discovery offloads discovery logic to a router or load balancer, simplifying client code and making it language-agnostic. The trade-off is an additional network hop and the router becoming a potential bottleneck or single point of failure.

### [KDC-003] Consul DNS-based service discovery with integrated health checking

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: tasks/20260401-concurrent-24/acquire/raw-sources/src-002-consul-dns-discovery.md
- **Verification Status**: passed
- **Original Excerpt**: > "By default, DNS queries only return nodes that are passing all health checks. This behavior can be changed:"
- **Derived Conclusion**: Consul provides native DNS-based service discovery where health check results are integrated directly into DNS responses. Unhealthy nodes are automatically excluded from query results, which means DNS-based discovery in Consul inherently provides health-aware routing without requiring additional client-side logic.

## Potential Capability Impact
- none

## Next Promotion Target
- KDC-001: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-24-client-server-discovery.md
- KDC-002: not promoted — overlaps with KDC-001 (same source pattern, complementary conclusion); consolidated into KDC-001 draft
- KDC-003: promoted to mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-24-consul-dns-discovery.md

## Notes
- none
