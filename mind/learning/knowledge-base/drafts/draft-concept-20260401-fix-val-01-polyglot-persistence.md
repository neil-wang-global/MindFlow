# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-fix-val-01

## Summary
- The database-per-service pattern naturally produces polyglot persistence: each microservice selects its database technology based on its specific data model, query patterns, and consistency requirements, meaning a single application may use multiple database technologies.

## From Task Learning
- mind/learning/task-learning/tl-20260401-fix-val-01.md
- candidate knowledge item reference: KDC-002

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-fix-val-01/acquire/raw-sources/src-002-dotnet-data-sovereignty.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-fix-val-01/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "different microservices often use different kinds of databases. Modern applications store and process diverse kinds of data, and a relational database isn't always the best choice. For some use cases, a NoSQL database such as Azure CosmosDB or MongoDB might have a more convenient data model and offer better performance and scalability than a SQL database like SQL Server or Azure SQL Database. In other cases, a relational database is still the best approach. Therefore, microservices-based applications often use a mixture of SQL and NoSQL databases, which is sometimes called the polyglot persistence approach."

## Candidate Conclusion
- The database-per-service pattern naturally produces polyglot persistence: each microservice selects its database technology based on its specific data model, query patterns, and consistency requirements. This means a single application may use relational databases for services needing referential integrity, document databases for flexible schemas, and in-memory stores for high-throughput workloads — each selection reflecting the bounded context's position on the CAP/PACELC spectrum.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-fix-val-01-polyglot-persistence.md

## Notes
- none
