# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-002

## Source URL
- https://static.googleusercontent.com/media/research.google.com/en//archive/chubby-osdi06.pdf

## Fetch Timestamp
- 2026-04-01T10:13:00Z

## Source Type
- Academic Article

## Credibility Assessment
- High
- Google Research paper published at OSDI 2006

## Fetch Status
- success

## Fetch Completeness
- truncated
- Paper is 16 pages; tool output captured the first 10 pages covering design, architecture, and lock semantics

## Original Content

# The Chubby Lock Service for Loosely-Coupled Distributed Systems

Mike Burrows, Google Inc.

## Abstract

We describe our experiences with the Chubby lock service, which is intended to provide coarse-grained locking as well as reliable (though low-volume) storage for a loosely-coupled distributed system. Chubby provides an interface much like a distributed file system with advisory locks, but the design emphasis is on availability and reliability, as opposed to high performance.

## 1. Introduction

Chubby is a lock service used within Google to provide a primary service: advisory locks. Its most popular use at Google is as a name service. It is built on top of a consensus protocol (Paxos) to ensure consistency across replicas.

The purpose of a lock service, as opposed to a consensus library, is to allow clients to synchronize their activities and to agree on basic information about their environment. The primary goals are:
- Coarse-grained synchronization
- Reliable, low-volume storage (e.g., storing a master's address)
- Event notification

## 2. Design

### 2.1 Rationale

We chose to build a lock service rather than a consensus library for several reasons:
1. Developers are more familiar with locks than consensus protocols
2. A lock service reduces the number of servers needed (consensus requires a quorum)
3. A lock service can provide a name service
4. Distributed consensus algorithms use quorums and need replicas — a lock service handles this

### 2.2 System Structure

A Chubby cell consists of five replicas (typically in different racks). Replicas use a distributed consensus protocol (a variant of Paxos) to elect a master. The master must obtain votes from a majority of replicas and promises to keep the master lease for a set interval. Replicas periodically renew the master's lease.

Client operations:
- All reads and writes go through the master
- Read operations are served from the master's in-memory cache
- Write operations propagate via the consensus protocol

### 2.3 Files, Directories, and Handles

Chubby exports a file-system-like interface:
- Nodes are either files or directories
- Each node has a name like `/ls/cell/path`
- `/ls` stands for "lock service"
- `cell` identifies the Chubby cell

### 2.4 Locks and Sequencers

Each Chubby file and directory can act as a reader-writer lock:
- **Exclusive (writer) mode**: one client may hold the lock
- **Shared (reader) mode**: any number of clients may hold the lock

Chubby locks are advisory, not mandatory. A lock holder receives a sequencer — an opaque byte string describing the lock state (lock name, mode, generation number). Clients pass the sequencer to servers, which can verify that the lock is still held.

### 2.5 Events

Chubby clients can subscribe to events:
- File contents modified
- Child node added, removed, or modified
- Chubby master failed over
- A lock handle has become invalid
- Lock acquired

### 2.6 Caching

Chubby clients cache file data and node metadata. The master keeps a list of what each client may be caching and sends invalidation events. The cache is consistent — either the client sees a consistent view or an error.

## 3. Mechanisms

### 3.1 Paxos Implementation

Chubby uses Multi-Paxos with some modifications:
- Master lease: the elected master has a lease that replicas promise not to elect a new master during
- This allows the master to serve reads without going through Paxos for every read

### 3.2 Sessions and KeepAlives

A Chubby session is a relationship between a Chubby cell and a Chubby client:
- Maintained by periodic KeepAlive RPCs
- Each session has a lease timeout
- If the master fails over, the new master must honor existing sessions

### 3.3 Fail-overs

When a master fails:
1. A new master is elected via Paxos
2. The new master picks a new master epoch number
3. It reads the Paxos database to reconstruct state
4. It responds to session KeepAlives, extending leases
5. It processes new operations

## 4. Use, Surprises, and Design Errors

### 4.1 Use as a Name Service

Chubby is primarily used as a name service within Google. DNS was considered but did not provide the consistency guarantees needed. Chubby provides strongly consistent name resolution.

### 4.2 Abusive Clients

Some teams used Chubby as a general-purpose storage system, leading to high load. Google introduced quotas and encouraged using Chubby only for its intended purpose (coarse-grained locks and small metadata).
