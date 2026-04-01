# Knowledge Base Entry

## Type
- concept

## Summary
- Chubby is a coarse-grained lock service built on Paxos consensus with advisory locks, sequencer-based stale lock prevention, and session-based liveness

## Source Lineage
- Task ID: 20260401-concurrent-30
- Task Learning Record: `mind/learning/task-learning/tl-20260401-concurrent-30.md`
- Draft File: `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-30-chubby-lock-service.md`
- Review File: `mind/learning/reviews/review-20260401-concurrent-30-chubby-lock-service.md`
- Original Source Anchor: `tasks/20260401-concurrent-30/acquire/raw-sources/src-004-chubby-lock-service.md`
- Original Source URL: https://static.googleusercontent.com/media/research.google.com/en//archive/chubby-osdi06.pdf

## Key Evidence
> "We describe our experiences with the Chubby lock service, which is intended to provide coarse-grained locking as well as reliable (though low-volume) storage for a loosely-coupled distributed system. Chubby provides an interface much like a distributed file system with advisory locks, but the design emphasis is on availability and reliability, as opposed to high performance."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-30-chubby-lock-service.md

## Applicability
- Applies to: loosely-coupled distributed systems requiring coarse-grained synchronization, name service, and small metadata storage
- Does not apply to: fine-grained locking (millisecond-level); high-throughput data storage; systems outside Google's infrastructure (Chubby is internal; ZooKeeper is the open-source equivalent)

## Notes
- Mike Burrows, OSDI 2006; 5-replica cell architecture; also serves as name service within Google
