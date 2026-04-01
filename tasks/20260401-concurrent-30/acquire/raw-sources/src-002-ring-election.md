# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://www.cs.uic.edu/~ajayk/Chapter9.pdf

## Fetch Timestamp
- 2026-04-01T10:03:00Z

## Source Type
- Academic Article

## Credibility Assessment
- High
- University computer science department textbook chapter

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Chapter 9: Leader Election

## 9.1 Introduction

Leader election is a fundamental problem in distributed computing. The goal is for a set of processes to agree on a single process to act as coordinator. The elected leader is used for centralized coordination tasks such as mutual exclusion, transaction management, and failure recovery.

## 9.2 Ring-Based Election (Chang and Roberts, 1979)

The Chang-Roberts algorithm operates on a unidirectional ring topology.

### Algorithm
1. Any process can initiate an election by sending an ELECTION message containing its own ID clockwise around the ring
2. When a process receives an ELECTION message:
   - If the ID in the message is greater than the receiver's ID: forward the message (unchanged) to the next process in the ring
   - If the ID in the message is less than the receiver's ID: replace the ID with its own and forward
   - If the ID in the message equals the receiver's ID: this process is the leader; send a COORDINATOR message around the ring
3. When a process receives a COORDINATOR message, it records the leader and forwards the message until it returns to the leader

### Message Complexity
- Worst case: O(n^2) messages when process IDs are arranged in decreasing order around the ring
- Best case: O(n) messages when the highest-ID process initiates the election
- Average case: O(n log n) messages (proven by Chang and Roberts)

### Comparison with Bully Algorithm
| Property | Bully | Ring (Chang-Roberts) |
|----------|-------|---------------------|
| Topology | Fully connected | Unidirectional ring |
| Best case messages | O(n) | O(n) |
| Worst case messages | O(n^2) | O(n^2) |
| Average case messages | O(n^2) | O(n log n) |
| Process knowledge | All IDs known | Only neighbor known |
| Failure handling | Restart election | More complex recovery |

## 9.3 Improvements

The Hirschberg-Sinclair algorithm (1980) improves ring election to O(n log n) worst case by using bidirectional communication and progressively larger neighborhoods.

## 9.4 Leader Election in Asynchronous Systems

In asynchronous systems without failure detectors, leader election is equivalent to consensus (FLP impossibility applies). Practical systems use timeout-based failure detectors (e.g., Omega failure detector) to circumvent this impossibility.

## 9.5 Practical Considerations

- ZooKeeper uses a variant of leader election based on ephemeral sequential znodes
- Raft consensus protocol embeds leader election as a subprotocol using randomized timeouts
- etcd, Consul, and similar systems build on these foundations

## Summary

Leader election algorithms differ in their topology assumptions, message complexity, and failure handling. The Bully algorithm is simple but expensive; the Chang-Roberts ring algorithm is more efficient on average; modern systems embed election within consensus protocols for stronger guarantees.
