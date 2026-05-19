# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001 — Raft leader election mechanism

## Source URL
- https://raft.github.io/raft.pdf

## Fetch Timestamp
- 2026-04-01

## Source Type
- Academic Article

## Credibility Assessment
- High — original peer-reviewed paper by the Raft protocol authors (Ongaro & Ousterhout), published at USENIX ATC 2014

## Fetch Status
- success

## Fetch Completeness
- partial — content retrieved via WebSearch tool which fetches and processes page content with AI summarization; the full PDF could not be fetched directly (WebFetch tool permission denied); content below represents the leader election sections as retrieved by the search tool

## Original Content

Source: "In Search of an Understandable Consensus Algorithm" by Diego Ongaro and John Ousterhout, USENIX ATC 2014. Retrieved from https://raft.github.io/raft.pdf via WebSearch.

Raft Leader Election Mechanism:

Raft uses a strong leader model where log entries only flow from the leader to other servers. Servers operate in one of three states: Leader, Follower, or Candidate. Time is divided into terms (logical clocks), each beginning with an election.

Election Trigger: If a follower receives no communication (heartbeat) within an election timeout, it transitions to candidate state.

RequestVote RPC: The candidate increments its current term, votes for itself, and sends RequestVote RPCs in parallel to all other servers in the cluster. Each server votes for at most one candidate per term, on a first-come-first-served basis. The RequestVote RPC includes the candidate's term number and log information (last log index and last log term) so that voters can ensure they only vote for candidates with logs at least as up-to-date as their own.

Election Outcomes: A candidate continues in the candidate state until one of three things happens:
1. It wins the election — receives votes from a majority of servers, becomes leader, and begins sending heartbeats.
2. Another server establishes itself as leader — the candidate receives an AppendEntries RPC from a valid leader with a term >= its own and reverts to follower.
3. No winner (split vote) — the election timeout expires without a majority; a new election begins.

Randomized Election Timeout: This is Raft's mechanism for preventing and resolving split votes. Each server chooses its election timeout randomly from a fixed interval (typically 150-300 ms). This spreads out servers so that in most cases, only a single server times out first, wins the election before others time out, and sends heartbeats to reset their timers. Even if a split vote occurs, randomized timeouts ensure the next election is unlikely to produce another split.

Split Vote Handling: A split vote occurs when multiple candidates start elections simultaneously and no single candidate receives a majority. Without randomized timeouts, split votes could repeat indefinitely (livelock). Raft handles this by having each candidate restart its election timer with a new random value after a failed election. The candidate that times out first in the new round is likely to win before others start competing. This ensures elections typically resolve within one or two extra rounds.

Key Safety Properties:
- Election Safety: At most one leader can be elected in a given term.
- Leader Completeness: A candidate cannot win an election unless its log contains all committed entries.
- Term numbers act as a logical clock to detect stale leaders and obsolete messages.

"Raft separates the key elements of consensus, such as leader election, log replication, and safety, and it enforces a stronger degree of coherency to reduce the number of states that must be considered."
