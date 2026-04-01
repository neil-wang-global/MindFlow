# Knowledge Base Entry

## Type
- concept

## Summary
- The PACELC theorem (Abadi 2010/2012, formally proved by Golab 2018) extends CAP by adding the latency-consistency trade-off during normal (non-partition) operation. This produces four configuration models (PA/EL, PA/EC, PC/EL, PC/EC) that more precisely classify real databases. PACELC is considered more comprehensive than CAP for cloud-scale systems where partitions are rare but latency-consistency trade-offs are constant. Publication details confirmed via ACQ-002: Golab's formal proof in ACM SIGACT News, vol. 49, pp. 73-81, "Proving PACELC."

## Source Lineage
- Task ID: 20260401-pure-learning-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-pure-learning-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-pure-learning-test-pacelc-extension.md
- Review File: mind/learning/reviews/review-20260401-pure-learning-test-pacelc-extension.md
- Original Source Anchor: tasks/20260401-pure-learning-test/acquire/raw-sources/src-002-pacelc-theorem.md
- Original Source URL: https://en.wikipedia.org/wiki/PACELC_theorem

## Key Evidence
> "The PACELC design principle extends the CAP theorem for distributed database systems. It addresses what happens both **during** and **in the absence of** network partitions"

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-pure-learning-test-pacelc-extension.md

## Applicability
- Applies to: distributed database design decisions where latency-consistency trade-offs during normal operation are significant; cloud-scale systems where partitions are rare
- Does not apply to: intermittently connected environments (IoT, mobile) where CAP's partition-time focus is more directly relevant; single-node systems where neither framework applies

## Notes
- PACELC database classifications: PA/EL (Dynamo, Cassandra), PC/EC (VoltDB, PostgreSQL, HBase), PA/EC (MongoDB), PC/EL (PNUTS)
- Many systems (Cassandra, Cosmos DB) offer tunable trade-offs across both dimensions
