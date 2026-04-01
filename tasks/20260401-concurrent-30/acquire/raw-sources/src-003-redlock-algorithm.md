# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-002

## Source URL
- https://redis.io/docs/latest/develop/use/patterns/distributed-locks/

## Fetch Timestamp
- 2026-04-01T10:12:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- Official Redis documentation from redis.io

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Distributed Locks with Redis

Distributed locks are a very useful primitive in many environments where different processes must operate with shared resources in a mutually exclusive way.

There are a number of libraries and blog posts describing how to implement a DLM (Distributed Lock Manager) with Redis, but every library uses a different approach, and many use a simple approach with lower guarantees compared to what can be achieved with slightly more complex designs.

## Safety and Liveness Guarantees

We are going to model our design with just three properties that, from our point of view, are the minimum guarantees needed to use distributed locks in an effective way.

1. **Safety property**: Mutual exclusion. At any given moment, only one client can hold a lock.
2. **Liveness property A**: Deadlock free. Eventually it is always possible to acquire a lock, even if the client that locked a resource crashes or gets partitioned.
3. **Liveness property B**: Fault tolerance. As long as the majority of Redis nodes are up, clients are able to acquire and release locks.

## Why Failover-based Implementations Are Not Enough

The simplest way to use Redis to lock a resource is to create a key in an instance. The key is usually created with a limited time to live, using the Redis expires feature, so that eventually it will get released. When the client needs to release the resource, it deletes the key.

This works well until you have a single Redis master. The problem is when the Redis master goes down. If you add a replica, there is a race condition:
1. Client A acquires the lock in the master.
2. The master crashes before the write to the key is transmitted to the replica.
3. The replica gets promoted to master.
4. Client B acquires the lock to the same resource A already holds a lock for. **SAFETY VIOLATION!**

## The Redlock Algorithm

In the distributed version of the algorithm we assume we have N Redis masters. These nodes are totally independent, so we don't use replication or any other implicit coordination system.

We assume N=5 as a reasonable value. To acquire the lock, the client performs the following operations:

1. It gets the current time in milliseconds.
2. It tries to acquire the lock in all the N instances sequentially, using the same key name and random value in all the instances. During step 2, when setting the lock in each instance, the client uses a timeout which is small compared to the total lock auto-release time in order to acquire it. If an instance is not available, we should try to talk with the next instance ASAP.
3. The client computes how much time elapsed in order to acquire the lock, by subtracting the current time from the timestamp obtained in step 1. If and only if the client was able to acquire the lock in the majority of the instances (at least 3), and the total time elapsed to acquire the lock is less than lock validity time, the lock is considered acquired.
4. If the lock was acquired, its validity time is considered to be the initial validity time minus the time elapsed, as computed in step 3.
5. If the client failed to acquire the lock for some reason (either it was not able to lock N/2+1 instances or the validity time is negative), it will try to unlock all the instances (even the ones it believed it was not able to lock).

## Retry on Failure

When a client is unable to acquire the lock, it should try again after a random delay in order to try to desynchronize multiple clients trying to acquire the lock for the same resource at the same time.

## Releasing the Lock

Releasing the lock is simple, and can be performed whether or not the client believes it was able to successfully lock a given instance. It simply involves sending a DEL command to all instances.

## Safety Arguments

Is the algorithm safe? Let's examine what happens in different scenarios:
- If a client acquired a lock in the majority of instances, then no other client can acquire the lock (since N/2+1 SET NX operations are needed).
- The auto-release time is used as a time to live for the lock, so the lock will be automatically released.
