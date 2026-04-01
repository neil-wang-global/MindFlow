# Acquire Search Log

## Task ID
- 20260401-concurrent-30

## ACQ-001: Leader Election Algorithms

### Trigger
- step-triggered: Step 1

### Knowledge Gap or Problem
- Need knowledge about leader election algorithms in distributed systems, specifically the Bully algorithm and Ring algorithm — their mechanics, failure handling, message complexity, and trade-offs

### Search Queries

#### Query 1
- **Query String**: "Bully algorithm leader election distributed systems"
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:00:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://www.cs.colostate.edu/~cs551/CourseNotes/Synchronization/BullyExample.html | Colorado State University course material — academic primary source on Bully algorithm with detailed example |
| 2 | https://en.wikipedia.org/wiki/Bully_algorithm | Wikipedia article — structured overview referencing Garcia-Molina's original 1982 paper |

#### Query 2
- **Query String**: "Ring algorithm Chang Roberts leader election message complexity"
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:01:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://www.cs.uic.edu/~ajayk/Chapter9.pdf | UIC distributed computing textbook chapter — academic primary source covering Ring election |
| 2 | https://en.wikipedia.org/wiki/Chang_and_Roberts_algorithm | Wikipedia article on Chang-Roberts algorithm with complexity analysis reference |

### Fetch Plan
- https://www.cs.colostate.edu/~cs551/CourseNotes/Synchronization/BullyExample.html (src-001)
- https://www.cs.uic.edu/~ajayk/Chapter9.pdf (src-002)

### Notes
- Focused on academic sources for algorithm specifics; Wikipedia entries used for candidate identification only, not as knowledge sources per Knowledge Source Prohibition
- Both selected sources are from university computer science departments, aligning with Soul constraint for primary source preference

## ACQ-002: Distributed Locking Mechanisms

### Trigger
- step-triggered: Step 2

### Knowledge Gap or Problem
- Need knowledge about distributed locking mechanisms — specifically Redlock (Redis-based), Google Chubby lock service, and Apache ZooKeeper locks — their design, correctness properties, failure modes, and trade-offs

### Search Queries

#### Query 1
- **Query String**: "Redlock distributed lock algorithm Redis correctness analysis"
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:10:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://redis.io/docs/latest/develop/use/patterns/distributed-locks/ | Official Redis documentation — primary source for Redlock algorithm specification |
| 2 | https://martin.kleppmann.com/2016/02/08/how-is-distributed-locking-done-correctly.html | Martin Kleppmann's analysis — peer-reviewed critique of Redlock correctness |

#### Query 2
- **Query String**: "Chubby lock service ZooKeeper distributed coordination comparison"
- **Tool Used**: WebSearch
- **Timestamp**: 2026-04-01T10:11:00Z

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://static.googleusercontent.com/media/research.google.com/en//archive/chubby-osdi06.pdf | Google Research — original Chubby paper (OSDI 2006) |
| 2 | https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks | Apache ZooKeeper official documentation — lock recipe |

### Fetch Plan
- https://redis.io/docs/latest/develop/use/patterns/distributed-locks/ (src-003)
- https://static.googleusercontent.com/media/research.google.com/en//archive/chubby-osdi06.pdf (src-004)
- https://zookeeper.apache.org/doc/current/recipes.html#sc_recipes_Locks (src-005)

### Notes
- Kleppmann's critique URL was considered but the Redis official docs already provide the Redlock specification; Kleppmann's analysis is secondary commentary
- Focused on primary sources: Redis official docs, Google Research paper, Apache ZooKeeper official docs
- Three sources selected to cover all three locking mechanisms (Redlock, Chubby, ZooKeeper)
