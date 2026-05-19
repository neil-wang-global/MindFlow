# Knowledge Base Entry

## Type
- concept

## Summary
- The database-per-service pattern naturally produces polyglot persistence: each microservice selects its database technology based on its specific data model, query patterns, and consistency requirements. This means a single application may use relational databases for services needing referential integrity, document databases for flexible schemas, and in-memory stores for high-throughput workloads — each selection reflecting the bounded context's position on the CAP/PACELC spectrum.

## Source Lineage
- Task ID: 20260401-fix-val-01
- Task Learning Record: mind/learning/task-learning/tl-20260401-fix-val-01.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-fix-val-01-polyglot-persistence.md
- Review File: mind/learning/reviews/review-20260401-fix-val-01-polyglot-persistence.md
- Original Source Anchor: tasks/20260401-fix-val-01/acquire/raw-sources/src-002-dotnet-data-sovereignty.md
- Original Source URL: https://learn.microsoft.com/en-us/dotnet/architecture/microservices/architect-microservice-container-applications/data-sovereignty-per-microservice

## Key Evidence
> "different microservices often use different kinds of databases. Modern applications store and process diverse kinds of data, and a relational database isn't always the best choice. For some use cases, a NoSQL database such as Azure CosmosDB or MongoDB might have a more convenient data model and offer better performance and scalability than a SQL database like SQL Server or Azure SQL Database. In other cases, a relational database is still the best approach. Therefore, microservices-based applications often use a mixture of SQL and NoSQL databases, which is sometimes called the polyglot persistence approach."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-fix-val-01-polyglot-persistence.md

## Applicability
- Applies to: microservice architecture data layer design; deciding whether to adopt polyglot persistence; understanding the data management implications of the database-per-service pattern
- Does not apply to: monolithic applications where a single database serves all subsystems; systems with uniform data model requirements across all components

## Notes
- Polyglot persistence introduces operational complexity (multiple database technologies to manage, monitor, and maintain) alongside its benefits (per-service optimization, loose coupling, independent scalability)
