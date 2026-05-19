# Task Profile

## Task ID
- 20260401-fix-val-05

## Task Type
- learning

## Goal
- Learn about gRPC load balancing strategies in Kubernetes, specifically comparing client-side vs proxy-based approaches and their trade-offs. gRPC uses HTTP/2 with long-lived multiplexed connections, which defeats standard Kubernetes L4 (kube-proxy) load balancing. This task should produce knowledge about the two primary solution families: client-side balancing (gRPC name resolver + LB policies, xDS-based lookaside balancing) and proxy-based balancing (L7-aware proxies like Envoy/Istio, headless services).

## Inputs
- Existing approved knowledge: kb-concept-envoy-sidecar-architecture.md, kb-concept-istio-traffic-management.md
- learning-read.md scan results (pending cross-task items noted but not relevant to this task's goal)

## Success Criteria
- Produce at least 1 promotable knowledge entry covering gRPC load balancing strategies in Kubernetes
- Knowledge Outcome = fully-acquired
- Overall Status = completed

## Complexity
- low

## Risk
- low

## Capability Needs
- distributed systems knowledge (gRPC protocol, HTTP/2 connection semantics)
- Kubernetes networking knowledge (kube-proxy, headless services, DNS)
- service mesh knowledge (Envoy, Istio, Linkerd)

## Constraints
- This is a learning-only task; no deliverable artifact beyond knowledge
- Must follow Fixed Promotion Path: task-learning -> drafts -> reviews -> approved
- Must produce fragment file for concurrent write safety
- Running concurrently with task 20260401-fix-val-04 — fragment mechanism is being tested

## Task-level Learning Possibility
- acquire-likely

## Mode
- compact

## Inference Possibility
- not needed

## Notes
- The core insight is that gRPC's HTTP/2 multiplexing over persistent connections means Kubernetes' default iptables-based L4 load balancing sends all RPCs to a single backend once the connection is established, requiring either client-side awareness or L7 proxy interception
