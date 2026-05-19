# Acquire Search Log

## Task ID
- 20260401-fix-val-07

## ACQ-001: Redis Distributed Locks — Redlock Algorithm

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Need detailed understanding of the Redlock algorithm beyond the existing KB entry, including: multi-instance quorum mechanism details, safety arguments and assumptions, clock drift handling, TTL-based deadlock freedom, and Kleppmann's critique of timing assumptions

### Search Queries

#### Query 1
- **Query String**: Redis distributed locks Redlock algorithm specification
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T00:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://redis.io/docs/latest/develop/use/patterns/distributed-locks/ | Official Redis documentation — primary authoritative source for Redlock specification |

#### Query 2
- **Query String**: Redlock algorithm safety analysis Kleppmann distributed locking critique
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T00:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://martin.kleppmann.com/2016/02/08/how-to-do-distributed-locking.html | Kleppmann's influential critique of Redlock safety — important counterpoint to official documentation |
| 2 | http://antirez.com/news/101 | Antirez (Redlock author) response to Kleppmann's critique — provides defense of algorithm safety |

### Fetch Plan
- https://redis.io/docs/latest/develop/use/patterns/distributed-locks/ — primary Redlock specification
- https://martin.kleppmann.com/2016/02/08/how-to-do-distributed-locking.html — Kleppmann critique
- http://antirez.com/news/101 — Antirez rebuttal

### Notes
- Primary source (redis.io) is the most critical for this acquisition event
- Kleppmann and Antirez URLs represent the key safety debate; fetch tools became unavailable after first fetch

## ACQ-002: ZooKeeper Distributed Locks — Recipes and Ephemeral Znodes

### Trigger
- step-triggered: Step 2

### Knowledge Gap or Problem
- Need detailed understanding of ZooKeeper's distributed lock implementation beyond the existing KB entry, including: the recipe pattern using ephemeral sequential znodes, watch-predecessor mechanism for herd-effect avoidance, read-write lock extension, session-based liveness guarantees, and ZAB protocol ordering guarantees

### Search Queries

#### Query 1
- **Query String**: Apache ZooKeeper distributed lock recipes ephemeral sequential znodes
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T00:02:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://zookeeper.apache.org/doc/current/recipes.html | Official Apache ZooKeeper documentation — primary authoritative source for lock recipes |
| 2 | https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks | Direct anchor to locks section of the recipes page |

#### Query 2
- **Query String**: ZooKeeper lock implementation watch mechanism herd effect avoidance
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T00:02:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://zookeeper.apache.org/doc/current/recipes.html | Same official source — confirmed relevant to watch mechanism and herd effect |

### Fetch Plan
- https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks — ZooKeeper lock recipes (primary source)

### Notes
- Both search queries converge on the same official documentation source
- WebFetch tool unavailable (permission denied); recording fetch attempt as failed

## ACQ-003: etcd Distributed Locks — Lease Mechanism and ZooKeeper Comparison

### Trigger
- step-triggered: Step 3

### Knowledge Gap or Problem
- Need detailed understanding of etcd's distributed lock mechanism including: the lease-based approach, the etcd concurrency package API, Session and Mutex primitives, revision-based ordering for fairness, comparison with ZooKeeper's ephemeral znode approach, and etcd's use of Raft consensus for linearizable operations

### Search Queries

#### Query 1
- **Query String**: etcd distributed lock lease mechanism concurrency package
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T00:03:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://pkg.go.dev/go.etcd.io/etcd/client/v3/concurrency | Official Go package documentation for etcd concurrency primitives — primary API reference |
| 2 | https://etcd.io/docs/v3.5/dev-guide/api_concurrency_reference_v3/ | Official etcd documentation on concurrency API reference |

#### Query 2
- **Query String**: etcd distributed locking vs ZooKeeper comparison lease revisions
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T00:03:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://etcd.io/docs/v3.5/learning/api/ | Official etcd API documentation covering leases and key-value operations |

### Fetch Plan
- https://pkg.go.dev/go.etcd.io/etcd/client/v3/concurrency — etcd concurrency package API reference (primary source)
- https://etcd.io/docs/v3.5/learning/api/ — etcd API documentation (secondary, fetch failed)

### Notes
- Primary source (pkg.go.dev) successfully fetched; secondary source (etcd.io) fetch tool unavailable
- Search results provided detailed comparison context between etcd and ZooKeeper approaches
