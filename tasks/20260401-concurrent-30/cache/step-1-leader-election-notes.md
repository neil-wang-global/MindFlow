# Step 1: Leader Election Algorithm Research Notes

## ACQ Event
- ACQ-001

## Sources Used
- src-001 (Bully algorithm — Colorado State University CS551 course material)
- src-002 (Ring/Chang-Roberts algorithm — UIC Chapter 9 distributed computing textbook)

## Bully Algorithm (Garcia-Molina, 1982)

### Mechanism
- Operates on fully connected topology where all processes know each other's IDs
- Election initiated when a process detects coordinator failure via timeout
- Three message types: ELECTION (to higher-ID processes), ANSWER (acknowledge), COORDINATOR (announce winner)
- Highest alive process always becomes coordinator (the "bully" property)

### Complexity
- Best case: O(n) messages (second-highest ID detects failure)
- Worst case: O(n^2) messages (lowest-ID process initiates cascade)

### Failure Handling
- If newly elected coordinator fails during election, algorithm restarts
- Self-stabilizing: any process can initiate new election on coordinator failure detection

### Trade-offs
- Simple to implement, but high message overhead in worst case
- Requires complete process knowledge (all IDs known to all)
- Not suitable for networks with frequent partitions

## Ring Algorithm (Chang-Roberts, 1979)

### Mechanism
- Operates on unidirectional ring topology
- Any process initiates by sending ELECTION message with its ID clockwise
- Forwarding rules: forward if incoming ID > own ID; replace with own ID if incoming ID < own ID; declare self leader if incoming ID = own ID
- COORDINATOR message circulates to announce result

### Complexity
- Best case: O(n) messages (highest-ID process initiates)
- Worst case: O(n^2) messages (decreasing ID order around ring)
- Average case: O(n log n) messages (proven by Chang and Roberts)

### Comparison
| Property | Bully | Ring (Chang-Roberts) |
|----------|-------|---------------------|
| Topology | Fully connected | Unidirectional ring |
| Average case | O(n^2) | O(n log n) |
| Process knowledge | All IDs known | Only neighbor known |
| Failure handling | Simple restart | More complex recovery |

## Key Insights
- Both algorithms assume crash-stop failure model
- Modern systems (ZooKeeper, Raft, etcd) embed election within consensus protocols for stronger guarantees
- Hirschberg-Sinclair (1980) improved ring election to O(n log n) worst case using bidirectional communication
- In asynchronous systems, leader election is equivalent to consensus (FLP impossibility applies)
