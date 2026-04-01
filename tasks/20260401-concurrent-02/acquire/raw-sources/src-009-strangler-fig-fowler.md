# Raw Source

## Source ID
- src-009

## ACQ Event
- ACQ-003

## Source URL
- https://martinfowler.com/bliki/StranglerFigApplication.html

## Fetch Timestamp
- 2026-04-01T10:47:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Martin Fowler coined the Strangler Fig Application pattern; this is the original article

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# StranglerFigApplication

When Cindy and I went to Australia, we spent some time in the rain forests on the Queensland coast. One of the natural wonders of this area are the huge strangler figs. They seed in the upper branches of a fig tree and gradually work their way down the tree until they root in the soil. Over many years they grow into fantastic and beautiful shapes, meanwhile strangling and killing the tree that was their host.

This metaphor struck me as a way of describing a way of doing a rewrite of an important system. Much of my career has involved rewrites of critical systems. You would think that since we get to do the system over, we'd avoid the mistakes of the original. Sadly, the end result is often no better and is sometimes even worse.

The alternative is to gradually create a new system around the edges of the old, letting it grow slowly over several years until the old system is strangled.

An important part of the Strangler Fig Application pattern is that the old and new can coexist, giving the new system time to grow and potentially for you to learn from the new system before making too many commitments.

## How it Works

The fundamental strategy is:

1. **Identify the portions of the existing application that need to change**: Find the right seams in the application. An event interception layer can help capture the events that are flowing through the existing application.

2. **Transform**: Build the new functionality in the new system, alongside the old. The new system should implement the identified portions.

3. **Redirect**: Use a routing layer (often a facade or proxy) to direct traffic from the old to the new implementation. This can be done feature by feature, page by page, or service by service.

The key insight is that you never have a "big bang" switchover. Instead, you incrementally migrate functionality until the old system can be completely decommissioned.

## Anti-Corruption Layer

When the new system needs to interact with the old, an Anti-Corruption Layer (ACL) serves as a translator between the two systems. The ACL:
- Isolates the new system's domain model from the old system's model
- Translates between the two models as needed
- Prevents the old system's design decisions from "corrupting" the new system
- Can be implemented as adapters, facades, or translation services

The term comes from Eric Evans' Domain-Driven Design. In the context of Strangler Fig migration, the ACL is particularly important because:
- The old and new systems may use different data models
- Business logic may be expressed differently
- The ACL provides a clean boundary that can be removed once migration is complete

## Benefits

- Lower risk than big-bang rewrites
- Allows incremental delivery of value
- Old and new systems coexist during transition
- Team can learn and adjust as migration progresses
- Rollback is straightforward — just redirect traffic back

## Considerations

- Requires a routing mechanism (proxy, load balancer, facade)
- Need to handle data synchronization between old and new systems during transition
- Testing must cover both old and new paths plus the routing layer
- Migration can stall if not actively managed — requires organizational commitment
