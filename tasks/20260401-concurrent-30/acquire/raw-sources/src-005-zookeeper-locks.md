# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-002

## Source URL
- https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks

## Fetch Timestamp
- 2026-04-01T10:14:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Apache ZooKeeper documentation

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# ZooKeeper Recipes and Solutions

## Locks

Fully distributed locks that are globally synchronous, meaning at any snapshot in time no two clients think they hold the same lock. These can be implemented using ZooKeeper.

### Write Locks

Here are the steps for obtaining a write lock:

1. Call `create()` with a pathname of `_locknode_/write-` and set both the sequence and ephemeral flags.
2. Call `getChildren()` on the lock node without setting the watch flag.
3. If the pathname created in step 1 has the lowest sequence number suffix, the client has the lock and the client exits the protocol.
4. The client calls `exists()` with the watch flag set on the path in the lock directory with the next lowest sequence number.
5. If `exists()` returns null, go to step 2. Otherwise, wait for a notification for the pathname from the previous step before going to step 2.

### Read Locks

Here are the steps for obtaining a read lock:

1. Call `create()` with a pathname of `_locknode_/read-` and set both the sequence and ephemeral flags.
2. Call `getChildren()` on the lock node without setting the watch flag.
3. If there are no children with a lower sequence number than the node created in step 1 whose pathname starts with `write-`, the client has the lock and can exit the protocol.
4. Otherwise, call `exists()` with the watch flag on the write node with the next lower sequence number immediately before the read node.
5. If `exists()` returns false, go to step 2.
6. Otherwise, wait for a notification for the pathname from the previous step before going to step 2.

### Recoverable Errors

If a recoverable error occurs calling `create()`, the client should call `getChildren()` and check for a node containing the guid used in the path name. This handles the case where the create succeeds on the server but the server crashes before returning the name of the new node.

### Key Properties

- **Ephemeral nodes**: Lock nodes are ephemeral, so if a client crashes, its lock is automatically released. This prevents deadlocks from failed clients.
- **Sequential nodes**: ZooKeeper assigns a unique monotonically increasing sequence number to each node, providing a natural ordering for lock acquisition.
- **Watches**: Instead of polling, clients set watches on the node immediately preceding theirs. This ensures that only one client is notified when a lock is released, avoiding the "herd effect."

### Shared Locks (Reader-Writer Locks)

The read lock recipe above implements the shared portion of a reader-writer lock. Combined with the write lock, this provides a complete distributed reader-writer lock:
- Multiple clients can hold read locks simultaneously
- Only one client can hold a write lock
- Write locks are exclusive — no read locks can be held while a write lock is held

### Comparison Notes

ZooKeeper's approach to distributed locking differs from Chubby in several ways:
- ZooKeeper uses ephemeral sequential znodes (ZooKeeper nodes) rather than explicit lock operations
- Lock ordering is determined by znode sequence numbers, providing fairness
- The watch mechanism avoids the "herd effect" where all waiters are notified on lock release
- ZooKeeper is a general-purpose coordination service; locks are built from primitives rather than being first-class operations

### Caveats

- There is no way to check for lock contention without also contending for the lock.
- If you do not need strict ordering, you can use a simpler lock protocol.
