# Plan

## Task ID
- 20260401-fix-val-07

## Goal
- Acquire deep, structured knowledge about three distributed locking mechanisms (Redis/Redlock, ZooKeeper, etcd), each through a dedicated ACQ event, producing verified knowledge artifacts for all three technologies

## Runtime State
- the fixed runtime state file is: `tasks/20260401-fix-val-07/state.md`

## Global Constraints
- default final result directory: `tasks/20260401-fix-val-07/_output/`
- Soul learning policy: prioritize primary sources (official documentation, academic papers); validate external claims against known system constraints
- All 3 Steps require external knowledge acquisition
- Existing KB entries for Redlock and ZooKeeper inform but do not replace ACQ events — new acquisition must deepen beyond existing coverage

### Step 1
- Name: Redis Distributed Locks — Redlock Algorithm Deep Dive
- Goal: Acquire detailed knowledge about the Redlock algorithm including multi-instance quorum mechanism, safety arguments and assumptions, clock drift handling, TTL-based deadlock freedom, and Kleppmann's critique of timing assumptions
- Capability: none (knowledge acquisition only)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-07/acquire/` (ACQ artifacts for Step 1)
- Constraints: `mind/soul/core.md` must be read before execution; existing KB entry `kb-concept-redlock-algorithm.md` must be consulted to avoid duplicate coverage
- Inputs: existing `kb-concept-redlock-algorithm.md` as baseline; official Redis documentation on distributed locks
- Outputs: verified knowledge artifact in `tasks/20260401-fix-val-07/acquire/`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: none
- Completion Criteria: ACQ event completed with verification report present in `tasks/20260401-fix-val-07/acquire/`; search-log.md records sources found; raw-sources contain at least one fetched primary source; verification-report.md contains assessment
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) targeting Redis distributed lock documentation. Focus on the Redlock algorithm specification from redis.io. Search for the original Redlock specification and Kleppmann's "How to do distributed locking" critique. Verify acquired knowledge against safety properties (mutual exclusion, deadlock freedom, fault tolerance).

### Step 2
- Name: ZooKeeper Distributed Locks — Recipes and Ephemeral Znodes
- Goal: Acquire detailed knowledge about ZooKeeper's distributed lock implementation including the recipe pattern, ephemeral sequential znodes, watch mechanism for herd-effect avoidance, read-write lock support, and session-based liveness guarantees
- Capability: none (knowledge acquisition only)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-07/acquire/` (ACQ artifacts for Step 2)
- Constraints: `mind/soul/core.md` must be read before execution; existing KB entry `kb-concept-zookeeper-locks.md` must be consulted to avoid duplicate coverage
- Inputs: existing `kb-concept-zookeeper-locks.md` as baseline; official ZooKeeper recipes documentation
- Outputs: verified knowledge artifact in `tasks/20260401-fix-val-07/acquire/`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 1
- Completion Criteria: ACQ event completed with verification report present in `tasks/20260401-fix-val-07/acquire/`; search-log.md records sources found; raw-sources contain at least one fetched primary source; verification-report.md contains assessment
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) targeting ZooKeeper lock recipes documentation. Focus on the official Apache ZooKeeper recipes page for locks. Search for details on the ephemeral sequential znode pattern, the watch-predecessor mechanism that avoids thundering herd, and the read-write lock extension. Verify against the ZAB protocol's ordering guarantees.

### Step 3
- Name: etcd Distributed Locks — Lease Mechanism and ZooKeeper Comparison
- Goal: Acquire detailed knowledge about etcd's distributed lock mechanism including the lease-based approach, the etcd concurrency package, linearizable key-value operations, comparison with ZooKeeper's approach to distributed locking, and etcd's use of Raft consensus for lock safety
- Capability: none (knowledge acquisition only)
- Dispatch Mode: sequential
- Output Isolation: `tasks/20260401-fix-val-07/acquire/` (ACQ artifacts for Step 3)
- Constraints: `mind/soul/core.md` must be read before execution; Step 2 output on ZooKeeper must be available for comparison
- Inputs: Step 2 output (ZooKeeper lock knowledge for comparison); official etcd documentation on concurrency primitives
- Outputs: verified knowledge artifact in `tasks/20260401-fix-val-07/acquire/`; comparative analysis in `tasks/20260401-fix-val-07/_output/distributed-locking-comparison.md`
- Publish To Sources: none
- Learning: acquire-required
- Depends On: Step 2
- Completion Criteria: ACQ event completed with verification report present in `tasks/20260401-fix-val-07/acquire/`; search-log.md records sources found; raw-sources contain at least one fetched primary source; verification-report.md contains assessment; comparative analysis output exists in `_output/`
- Failure Policy: escalate-to-reflection
- Instructions: Execute Learning(Acquire) targeting etcd distributed lock documentation. Focus on the official etcd concurrency package documentation and the etcd lease mechanism. Search for how etcd implements distributed locks using leases and revisions. Compare with ZooKeeper's ephemeral znode approach — document similarities (both use consensus, both have session/lease-based liveness) and differences (etcd uses Raft vs ZooKeeper's ZAB, etcd uses key revisions vs sequential znodes). Produce a comparative analysis as the final output artifact.

## Step Independence Matrix

| Step Pair | Distinction | Overlap Assessment |
|-----------|------------|-------------------|
| Step 1 vs Step 2 | Step 1 targets Redis-based lock (Redlock) using independent master quorum without consensus; Step 2 targets ZooKeeper-based lock using ephemeral znodes atop ZAB consensus. Fundamentally different architectures (stateless quorum vs consensus-backed coordination service). | no-overlap |
| Step 1 vs Step 3 | Step 1 targets Redis/Redlock (majority quorum across independent masters); Step 3 targets etcd (lease-based locks atop Raft consensus). Different substrate technologies with different consistency models. | no-overlap |
| Step 2 vs Step 3 | Step 2 targets ZooKeeper (ephemeral znodes, ZAB consensus); Step 3 targets etcd (leases, Raft consensus). Both are consensus-based coordination services, but Step 3 explicitly compares with ZooKeeper — the overlapping area (shared concept of consensus-backed locking) serves a comparative analytical purpose in Step 3 and a standalone descriptive purpose in Step 2. Overlap is under 30% of either Step's scope. | low-overlap |

## Handoffs
- Step 1 output (Redlock knowledge) is self-contained; no handoff to Step 2
- Step 2 output (ZooKeeper lock knowledge) hands off to Step 3 as comparison baseline
- Step 3 produces the final comparative output artifact in `_output/`

## Completion Check
- All 3 ACQ events have verification reports in `tasks/20260401-fix-val-07/acquire/`
- `tasks/20260401-fix-val-07/_output/distributed-locking-comparison.md` exists with comparative analysis
- state.md shows all 3 Steps as `completed`
- Knowledge Outcome = `fully-acquired`
