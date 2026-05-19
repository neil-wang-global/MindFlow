# Acquire Search Log

## Task ID
- 20260401-fix-val-02

## ACQ-001: Zanzibar internal sharding algorithm

### Trigger
- step-triggered: Step 2

### Knowledge Gap or Problem
- The task requires knowledge of Google Zanzibar's undocumented internal sharding algorithm — the proprietary mechanism by which Zanzibar partitions and distributes authorization relation tuples across its infrastructure, beyond what Google Spanner provides automatically. This knowledge has never been publicly documented.

### Search Queries

#### Query 1
- **Query String**: Google Zanzibar internal sharding algorithm implementation details undocumented
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://research.google/pubs/zanzibar-googles-consistent-global-authorization-system/ | Google Research page for the original Zanzibar paper — the only primary source |
| 2 | https://usenix.org/conference/atc19/presentation/palt | USENIX ATC 2019 presentation page — the venue where the paper was published |

#### Query 2
- **Query String**: Zanzibar authorization system data partitioning sharding strategy Google proprietary
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://research.google/pubs/zanzibar-googles-consistent-global-authorization-system/ | Same as Query 1 — still the only primary source identified |
| 2 | https://cloud.google.com/iam/docs/zanzibar-based-authorization | Google Cloud IAM documentation referencing Zanzibar — might contain implementation details |

#### Query 3
- **Query String**: "Zanzibar" sharding algorithm site:research.google OR site:usenix.org OR site:static.googleusercontent.com
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| (none) | (no results) | Search returned no results for this targeted query |

### Fetch Plan
- URL 1: https://research.google/pubs/zanzibar-googles-consistent-global-authorization-system/ (Google Research paper page)
- URL 2: https://usenix.org/conference/atc19/presentation/palt (USENIX presentation page)
- URL 3: https://cloud.google.com/iam/docs/zanzibar-based-authorization (Google Cloud IAM docs)
- Note: all three URLs were planned for fetch but WebFetch tool was denied by the runtime environment

### Notes
- All searches consistently return only the 2019 USENIX ATC paper and secondary blog posts interpreting it
- No primary source documenting the undocumented internal sharding algorithm was found
- The search results confirm that the Zanzibar paper describes general architecture (relation tuples, Leopard indexing, Zookies, aclservers) but delegates sharding to Google Spanner's built-in mechanisms — the specific sharding algorithm at the Zanzibar application layer is proprietary and not publicly documented
- Secondary sources (blog posts from Permit.io, Auth0, Ory, Descope, The New Stack) are interpretations of the paper, not primary sources
- WebFetch tool was denied, preventing Stage 2 fetch of any candidate sources
