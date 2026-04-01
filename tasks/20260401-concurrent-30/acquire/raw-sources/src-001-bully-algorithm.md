# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://www.cs.colostate.edu/~cs551/CourseNotes/Synchronization/BullyExample.html

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- University computer science department course material

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Bully Algorithm for Leader Election

The Bully Algorithm was proposed by Hector Garcia-Molina in 1982. It is used in distributed systems to elect a coordinator (leader) among a group of processes.

## Assumptions
- Every process has a unique ID
- Every process knows the IDs of all other processes
- Communication is reliable (messages are eventually delivered)
- Processes can fail by crashing (crash-stop model)

## Algorithm Description

The algorithm works as follows:

1. **Election Initiation**: When a process P detects that the coordinator has failed (e.g., via timeout), it initiates an election:
   - P sends an ELECTION message to all processes with higher IDs
   - If no response is received within timeout T, P declares itself the coordinator by sending a COORDINATOR message to all processes with lower IDs
   - If P receives a response (an ANSWER message), P waits for a COORDINATOR message; if none arrives within timeout, P restarts the election

2. **Response to ELECTION**: When a process Q receives an ELECTION message from a lower-ID process:
   - Q sends an ANSWER message back to the sender
   - Q then initiates its own election (if it has not already done so)

3. **Coordinator Announcement**: The process with the highest ID that is alive will eventually send a COORDINATOR message to all lower-ID processes

## Message Complexity
- Best case: O(1) messages — the process with the second-highest ID detects failure and sends one ELECTION message, gets no response, sends (n-2) COORDINATOR messages
- Worst case: O(n^2) messages — the process with the lowest ID initiates the election, triggering a cascade

## Failure During Election
- If the newly elected coordinator fails during the election, the algorithm restarts
- The algorithm handles this because any process that detects coordinator failure can initiate a new election

## Example
Consider processes P1, P2, P3, P4, P5 where P5 is the current coordinator:
1. P5 crashes
2. P3 detects the crash, sends ELECTION to P4, P5
3. P4 responds with ANSWER to P3
4. P4 sends ELECTION to P5 (no response)
5. P4 declares itself coordinator, sends COORDINATOR to P1, P2, P3

## Advantages
- Simple to understand and implement
- Guarantees the highest-ID process becomes coordinator
- Self-stabilizing after failures

## Disadvantages
- High message overhead in worst case (O(n^2))
- Assumes all processes know about each other
- The "bully" aspect: highest ID always wins, regardless of capability
- Not suitable for networks with frequent partitions
