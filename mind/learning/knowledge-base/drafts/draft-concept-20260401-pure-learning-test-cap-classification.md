# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-pure-learning-test

## Summary
- Distributed databases are classified as CP (MongoDB, Redis) or AP (Cassandra, CouchDB) based on partition behavior; no distributed NoSQL database is classified as CA

## From Task Learning
- mind/learning/task-learning/tl-20260401-pure-learning-test.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-pure-learning-test/acquire/raw-sources/src-001-cap-theorem.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-pure-learning-test/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "**MongoDB** and **Redis** maintain consistency while sacrificing availability during partitions, making them CP systems. **CouchDB**, **Cassandra**, and **ScyllaDB** are AP databases. The article states that \"there are no NoSQL databases one would classify as CA.\""

## Candidate Conclusion
- Real-world distributed databases are practically classified as either CP (MongoDB, Redis, HBase — prioritize consistency during partitions) or AP (Cassandra, CouchDB, ScyllaDB, DynamoDB — prioritize availability during partitions). No distributed NoSQL database is classified as CA because partition tolerance cannot be sacrificed in distributed systems. Many modern databases offer tunable consistency, blurring the binary classification.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-pure-learning-test-cap-classification.md

## Notes
- none
