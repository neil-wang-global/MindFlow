# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-30

## Summary
- Chubby is a coarse-grained lock service built on Paxos consensus with advisory locks, sequencer-based stale lock prevention, and session-based liveness

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-30.md
- candidate knowledge item reference: KDC-004

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-30/acquire/raw-sources/src-004-chubby-lock-service.md
  - ACQ Event: ACQ-002
  - Verification Report: tasks/20260401-concurrent-30/acquire/verification-report.md §ACQ-002
  - Verification Status: passed

## Original Excerpt
> "We describe our experiences with the Chubby lock service, which is intended to provide coarse-grained locking as well as reliable (though low-volume) storage for a loosely-coupled distributed system. Chubby provides an interface much like a distributed file system with advisory locks, but the design emphasis is on availability and reliability, as opposed to high performance."

## Candidate Conclusion
Google's Chubby is a coarse-grained lock service built on Paxos consensus with a 5-replica cell architecture. It provides advisory locks (exclusive and shared) with sequencer-based stale lock prevention, session-based liveness via KeepAlive heartbeats, and event notification. The design choice of a lock service over a consensus library was driven by developer familiarity with lock abstractions and the ability to co-locate a name service.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-30-chubby-lock-service.md

## Notes
- none
