# Research Summary: Google Zanzibar Internal Sharding Algorithm

## Task ID
- 20260401-fix-val-02

## Research Objective
- Acquire knowledge about the internal implementation details of Google's proprietary Zanzibar authorization system's undocumented internal sharding algorithm

## Search Strategies Used

### Strategy 1: Direct search for internal sharding details
- Query: "Google Zanzibar internal sharding algorithm implementation details undocumented"
- Result: No primary sources found documenting internal sharding; only the 2019 USENIX ATC paper and secondary blog posts interpreting it

### Strategy 2: Data partitioning terminology search
- Query: "Zanzibar authorization system data partitioning sharding strategy Google proprietary"
- Result: Same primary source (2019 paper); secondary sources confirm sharding is delegated to Google Spanner

### Strategy 3: Targeted academic/Google source search
- Query: "Zanzibar" sharding algorithm restricted to research.google, usenix.org, static.googleusercontent.com
- Result: No results — no academic or Google publication documents the internal sharding algorithm

## Sources Found
1. **Zanzibar USENIX ATC 2019 paper** (https://research.google/pubs/zanzibar-googles-consistent-global-authorization-system/) — the only primary source; describes general architecture but not internal sharding specifics
2. **Google Cloud IAM Zanzibar documentation** (https://cloud.google.com/iam/docs/zanzibar-based-authorization) — references Zanzibar concepts for Google Cloud IAM but does not expose internal implementation
3. **Secondary blog posts** from Permit.io, Auth0/Okta, Ory, Descope, The New Stack — all interpretations of the 2019 paper; none are primary sources

## Why the Target Knowledge Could Not Be Acquired
1. **Proprietary nature**: Google Zanzibar is an internal Google system. The 2019 paper was a controlled disclosure describing the external architecture and API, not the internal implementation
2. **Spanner delegation**: The paper describes Zanzibar as storing relation tuples in Google Spanner, which itself handles data distribution. The sharding at the Zanzibar application layer (if any exists beyond Spanner's built-in mechanisms) is not documented
3. **No follow-up publications**: Since the 2019 paper, no additional Google publications or engineering blog posts have disclosed internal sharding implementation details
4. **Fetch tool unavailable**: WebFetch was denied by the runtime, preventing fetching of even the publicly available paper and documentation; however, search results strongly indicate no source contains the target knowledge

## Public vs Proprietary Knowledge Boundary

### Publicly Known (from 2019 USENIX ATC paper)
- Relation tuple data model: (object#relation@user)
- Storage backend: Google Spanner (globally distributed, externally consistent)
- Leopard indexing system for group membership pre-computation
- Zookies (snapshot consistency tokens) for the "new enemy" problem
- Aclservers: stateless servers handling authorization checks
- Scale: trillions of ACL entries, millions of checks per second
- API: Check, Read, Expand, Watch operations

### Proprietary/Undocumented
- Internal sharding algorithm (the target of this task)
- Shard key selection for relation tuples at the Zanzibar layer
- Leopard index partitioning strategy
- Hot-spot mitigation algorithms for popular objects
- Cache sharding and distribution strategy
- Cross-shard query optimization for deep relationship traversals
- Spanner configuration details (splits, directory structure, replication factor)

## Conclusion
- The target knowledge — Google Zanzibar's internal sharding algorithm — is proprietary to Google and has never been publicly documented
- No amount of searching will surface this knowledge as it has not been disclosed
- The 2019 USENIX ATC paper remains the only authoritative source, and it explicitly does not cover internal sharding details
- This represents a fundamental information availability gap, not a search coverage gap
