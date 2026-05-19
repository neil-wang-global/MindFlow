# Knowledge Gap

## Gap ID
- gap-20260401-fix-val-02-zanzibar-sharding

## Origin Task
- 20260401-fix-val-02

## Origin ACQ Event
- ACQ-001

## Knowledge Gap Description
- what knowledge was sought: the internal implementation details of Google Zanzibar's undocumented sharding algorithm — specifically how Zanzibar partitions and distributes authorization relation tuples across its infrastructure at the application layer, beyond what Google Spanner provides automatically; includes shard key selection, Leopard index partitioning, hot-spot mitigation, cache sharding, and cross-shard query optimization
- why it could not be acquired: the knowledge is proprietary to Google and has never been publicly documented; the 2019 USENIX ATC paper describes the general architecture but not internal sharding specifics; no follow-up publications or engineering blog posts have disclosed these details; additionally, the WebFetch tool was denied by the runtime, preventing fetching of even the publicly available paper

## Exhaustion Reason
- src-001 (research.google/pubs/zanzibar paper): WebFetch denied — no content fetched
- src-002 (usenix.org/conference/atc19): WebFetch denied — no content fetched
- src-003 (cloud.google.com/iam/docs/zanzibar): WebFetch denied — no content fetched
- fundamental cause: the target knowledge is proprietary and undocumented — no public primary source exists
- verification degradation: same-context mode (independent subagent unavailable)

## Attempted Strategies
- Query 1: "Google Zanzibar internal sharding algorithm implementation details undocumented" (WebSearch) — returned only the 2019 paper and secondary blog posts
- Query 2: "Zanzibar authorization system data partitioning sharding strategy Google proprietary" (WebSearch) — confirmed sharding delegated to Spanner; no internal algorithm documented
- Query 3: "Zanzibar" sharding algorithm restricted to research.google, usenix.org, static.googleusercontent.com — returned no results
- Fetch attempted via WebFetch (denied for all 3 URLs)
- Future retry should: (1) ensure WebFetch tool is available, (2) search for any new Google publications or blog posts since 2019, (3) check if any ex-Google engineers have published implementation details, (4) check if SpiceDB or other Zanzibar-inspired systems have reverse-engineered the sharding approach; however, the fundamental barrier is that this knowledge is proprietary and may never be publicly available

## Status
- open

## Retry Count
- 0

## Resolution
- none

## Scan History
- 20260401-fix-val-02: created, Status: open — ACQ-001 exhausted due to proprietary undocumented knowledge + WebFetch denied
