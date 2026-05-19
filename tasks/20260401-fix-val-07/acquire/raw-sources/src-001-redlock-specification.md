# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://redis.io/docs/latest/develop/use/patterns/distributed-locks/

## Fetch Timestamp
- 2026-04-01T00:00:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — official Redis documentation maintained by Redis Ltd.

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

Below is a concise extraction/summary of the Redlock material from the Redis documentation (distributed locks page), covering the algorithm, steps, safety/liveness considerations, retry and clock-drift handling, and implementation guidance including code-like pseudo-code and important caveats.

Redlock — algorithm summary
- Purpose: implement a distributed, fault-tolerant mutual exclusion lock using multiple independent Redis nodes.
- Basic idea: acquire the same logical lock in a majority of independent Redis servers, each for a short TTL. If you manage to lock a majority and the total time to acquire the locks is less than the TTL (adjusted for clock drift), you consider the lock acquired.

Algorithm steps (high level)
1. Prepare:
   - Have N independent Redis master nodes (N is odd in examples; commonly N = 5).
   - Use a strong unique random value (token) to identify the lock owner for this attempt.
   - Choose a TTL for the lock (in milliseconds).

2. Acquisition phase:
   - Record start time.
   - For each Redis node, in sequence:
     - Try to set the lock with SET resource_name value NX PX ttl (i.e., set if not exists with expiry).
     - If SET returns success, count that node as locked.
     - If SET fails or the node is unreachable within a short timeout, treat as not locked and continue to next node.
   - After attempting all N nodes, compute elapsed time = now − start time.

3. Success decision:
   - If locks were acquired in at least majority ( > N/2 ) of nodes AND elapsed time < ttl − drift:
     - The lock is considered acquired, and the client may proceed.
   - Otherwise:
     - Release any locks that were acquired (only remove locks whose value equals the owner token).
     - Optionally, wait a random small delay and retry acquisition.

4. Release:
   - To release, run a small script on each Redis node to remove the lock only if the stored value matches the token (to avoid deleting someone else's lock). Example Lua script:
     - if redis.call("get",KEYS[1]) == ARGV[1] then return redis.call("del",KEYS[1]) else return 0 end

Retry mechanism
- If acquisition fails (didn't get a majority, or elapsed time exceeded adjusted TTL), client must release any partial locks and retry.
- Retry should include a small random delay to avoid lock storms and contention (commonly a few milliseconds randomized).
- Each attempt uses a new unique token.

Clock drift handling and validity time
- Because the client takes time to acquire locks across nodes, the remaining validity of the lock is less than the TTL you set on each node. The algorithm subtracts elapsed time and a small safety margin (drift) from TTL to compute the effective validity.
- Validity calculation (conceptual):
  - validity = ttl − (time_elapsed) − drift
  - If validity > 0 (after elapsed and drift), lock is still valid for that period.
- The "drift" term accounts for clock drifts and Redis' expire algorithms. The documentation shows the need to subtract a small factor from TTL to be safe; the Redlock paper suggests drift as a small fraction of TTL plus a small constant to account for expiry precision.
- Because lock acquisition must finish significantly before the per-node TTL expires, choose TTLs sufficiently larger than the expected acquisition time and network latencies.

Safety and liveness properties
- Safety (mutual exclusion):
  - Redlock aims to guarantee that only one client holds the lock at any time as long as a majority of Redis nodes are functioning and the algorithm conditions are respected (unique token, majority locks, validity calculation).
  - Use of the token and "delete-if-equals" release script prevents accidental unlocking by others.
- Liveness (progress):
  - The algorithm ensures that a client can obtain a lock eventually as long as a majority of Redis nodes are reachable and some timing assumptions hold (retries with backoff).
- Important assumptions and practical notes:
  - The algorithm relies on independent failures of Redis instances. If instances share a failure domain (same machine, same storage, same network segment), Redlock's guarantees are weakened.
  - Network partitions, long pauses, or large clock drifts can impair correctness.
  - Because acquiring a majority is required, at most floor((N−1)/2) nodes can fail without preventing locks.

Implementation guidance and best practices
- Use independent Redis instances (different servers, networks, machines, and disks).
- Use SET resource value NX PX ttl for acquiring locks on each node.
- Use a high-quality random token per lock acquisition attempt.
- When releasing, always use the get-and-del pattern (atomic Lua script) to ensure you only remove locks you own.
- Keep TTLs sufficiently larger than the worst-case acquisition round-trip time plus some margin for retries.
- Use a short timeout for network operations when talking to each node so acquisition attempts don't block too long.
- Use random small delays between retries to reduce thundering herd effects.
- Avoid using Redis replication (master + replicas) to emulate N independent masters—Redlock requires independent masters. Replication does not add to fault tolerance in this scheme.
- Do not use Redlock on multiple Redis instances running on the same physical host.

Representative pseudo-code (conceptual)
- AcquireLock(resource, ttl):
  - token = random()
  - start = current_time_ms()
  - n = 0
  - for each Redis server in servers:
    - if SET(resource, token, NX, PX, ttl) == OK:
      - n = n + 1
  - elapsed = current_time_ms() − start
  - drift = ttl * clock_drift_factor + 2  // conceptual drift term
  - if n >= majority and elapsed < ttl − drift:
    - return (true, token, ttl − elapsed − drift)  // acquired, remaining validity
  - else:
    - for each server where lock was set:
      - run release script to delete only if value == token
    - return (false, null, 0)

- ReleaseLock(resource, token):
  - For each server:
    - EVAL Lua script:
      - if redis.call("get",KEYS[1]) == ARGV[1] then return redis.call("del",KEYS[1]) else return 0 end
    - (do this against each server; ignore failures)

Caveats and warnings (from the documentation and broader discussion)
- Redlock is subtle and can be misused. It requires careful handling of retries, timeouts, token uniqueness, and independent Redis nodes.
- The Redlock algorithm and its correctness have been subject to debate in the distributed-systems community. Some practitioners prefer other coordination systems (e.g., Zookeeper, etcd/consensus-based solutions) or a single Redis instance with reliable persistence and replication depending on failure model and requirements.
- If you use Redlock, make sure you understand its assumptions: independent failures, bounded clock drift, reasonably small network delays compared to TTL, and correctly implemented safe release.
