# Knowledge Base Entry

## Type
- concept

## Summary
- Real-world distributed databases are practically classified as either CP (MongoDB, Redis, HBase -- prioritize consistency during partitions) or AP (Cassandra, CouchDB, ScyllaDB, DynamoDB -- prioritize availability during partitions). No distributed NoSQL database is classified as CA because partition tolerance cannot be sacrificed in distributed systems. Many modern databases offer tunable consistency, blurring the binary classification.

## Source Lineage
- Task ID: 20260401-pure-learning-test
- Task Learning Record: mind/learning/task-learning/tl-20260401-pure-learning-test.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-pure-learning-test-cap-classification.md
- Review File: mind/learning/reviews/review-20260401-pure-learning-test-cap-classification.md
- Original Source Anchor: tasks/20260401-pure-learning-test/acquire/raw-sources/src-001-cap-theorem.md
- Original Source URL: https://en.wikipedia.org/wiki/CAP_theorem

## Key Evidence
> "**MongoDB** and **Redis** maintain consistency while sacrificing availability during partitions, making them CP systems. **CouchDB**, **Cassandra**, and **ScyllaDB** are AP databases. The article states that \"there are no NoSQL databases one would classify as CA.\""

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-pure-learning-test-cap-classification.md

## Applicability
- Applies to: distributed database selection decisions; understanding which databases prioritize consistency vs availability during network partitions
- Does not apply to: single-node database deployments; the classification is about partition behavior, not general performance; tunable consistency means real-world behavior depends on configuration

## Notes
- Classification is a simplification; many modern databases (Cassandra, Cosmos DB) offer tunable consistency levels
- For a more nuanced framework including normal-operation trade-offs, see PACELC extension
