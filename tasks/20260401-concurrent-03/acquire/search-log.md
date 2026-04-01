# Acquire Search Log

## Task ID
- 20260401-concurrent-03

## ACQ-001: Raft consensus algorithm

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Need authoritative sources on Raft consensus algorithm mechanisms, leader election, log replication, and safety guarantees

### Search Queries

#### Query 1
- **Query String**: Raft consensus algorithm paper Ongaro Ousterhout
- **Tool Used**: simulated-search
- **Timestamp**: 2026-04-01T09:58:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://raft.github.io/raft.pdf | Original Raft paper by Ongaro and Ousterhout |
| 2 | https://raft.github.io/ | Official Raft website with algorithm description |

#### Query 2
- **Query String**: Raft consensus leader election log replication
- **Tool Used**: simulated-search
- **Timestamp**: 2026-04-01T09:59:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://raft.github.io/ | Confirms official source from query 1 |

### Fetch Plan
- https://raft.github.io/raft.pdf → src-001
- https://raft.github.io/ → src-002

### Notes
- Primary authoritative source identified in first query; second query confirms.

## ACQ-002: Paxos consensus algorithm

### Trigger
- step-triggered: Step 2

### Knowledge Gap or Problem
- Need authoritative sources on Paxos consensus algorithm: proposers, acceptors, learners, two-phase protocol

### Search Queries

#### Query 1
- **Query String**: Paxos consensus algorithm Lamport simplified
- **Tool Used**: simulated-search
- **Timestamp**: 2026-04-01T10:08:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://lamport.azurewebsites.net/pubs/paxos-simple.pdf | Lamport's "Paxos Made Simple" paper |
| 2 | https://martinfowler.com/articles/patterns-of-distributed-systems/paxos.html | Authoritative patterns reference |

#### Query 2
- **Query String**: Paxos protocol phases prepare accept
- **Tool Used**: simulated-search
- **Timestamp**: 2026-04-01T10:09:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://lamport.azurewebsites.net/pubs/paxos-simple.pdf | Confirms primary source |

### Fetch Plan
- https://lamport.azurewebsites.net/pubs/paxos-simple.pdf → src-003
- https://martinfowler.com/articles/patterns-of-distributed-systems/paxos.html → src-004

### Notes
- Lamport's simplified paper is the most accessible authoritative source for Paxos.

## ACQ-003: PBFT consensus algorithm

### Trigger
- step-triggered: Step 3

### Knowledge Gap or Problem
- Need authoritative sources on PBFT: Byzantine fault tolerance, three-phase protocol, 3f+1 requirement

### Search Queries

#### Query 1
- **Query String**: PBFT practical Byzantine fault tolerance Castro Liskov
- **Tool Used**: simulated-search
- **Timestamp**: 2026-04-01T10:18:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://pmg.csail.mit.edu/papers/osdi99.pdf | Original PBFT paper by Castro and Liskov |
| 2 | https://decentralizedthoughts.github.io/2019-12-22-PBFT/ | Academic blog explanation |

#### Query 2
- **Query String**: PBFT three phase commit Byzantine consensus
- **Tool Used**: simulated-search
- **Timestamp**: 2026-04-01T10:19:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://pmg.csail.mit.edu/papers/osdi99.pdf | Confirms primary source |

### Fetch Plan
- https://pmg.csail.mit.edu/papers/osdi99.pdf → src-005
- https://decentralizedthoughts.github.io/2019-12-22-PBFT/ → src-006

### Notes
- Original PBFT paper is the canonical reference; academic blog provides accessible explanation.
