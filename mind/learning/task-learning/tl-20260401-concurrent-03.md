# Task Learning Record

## Task ID
- 20260401-concurrent-03

## Task Summary
- Researched three distributed consensus algorithms: Raft, Paxos, and PBFT
- Produced a research summary in _output/ and acquired 6 verified sources across 3 ACQ events

## External Acquisition

### ACQ-001: Raft consensus algorithm

- **Trigger**: Step 1 (Acquire Raft Consensus Knowledge)
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-03/acquire/verification-report.md` §ACQ-001
- **Passed Sources**: src-001, src-002

### ACQ-002: Paxos consensus algorithm

- **Trigger**: Step 2 (Acquire Paxos Consensus Knowledge)
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-03/acquire/verification-report.md` §ACQ-002
- **Passed Sources**: src-003, src-004

### ACQ-003: PBFT consensus algorithm

- **Trigger**: Step 3 (Acquire PBFT Knowledge)
- **Status**: completed
- **Verification Report**: `tasks/20260401-concurrent-03/acquire/verification-report.md` §ACQ-003
- **Passed Sources**: src-005, src-006

## Candidate Knowledge

### [KDC-001] Raft consensus mechanism

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-001
- **Source Anchor**: `tasks/20260401-concurrent-03/acquire/raw-sources/src-001-raft-paper.md`
- **Verification Status**: passed
- **Original Excerpt**: > "Raft separates the key elements of consensus — leader election, log replication, and safety — and it enforces a stronger degree of coherency to reduce the number of states that must be considered."
- **Derived Conclusion**: Raft consensus decomposes into three independent subproblems (leader election, log replication, safety), enforcing stronger coherency than Paxos to reduce state space complexity

### [KDC-002] Paxos two-phase consensus protocol

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-002
- **Source Anchor**: `tasks/20260401-concurrent-03/acquire/raw-sources/src-003-paxos-paper.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The algorithm operates in two phases: Phase 1 (Prepare): (a) A proposer selects a proposal number n and sends a prepare request with number n to a majority of acceptors. (b) If an acceptor receives a prepare request with number n greater than that of any prepare request to which it has already responded, then it responds with a promise not to accept any more proposals numbered less than n and with the highest-numbered proposal (if any) that it has accepted. Phase 2 (Accept): (a) If the proposer receives a response to its prepare requests from a majority of acceptors, then it sends an accept request with proposal number n and value v, where v is the value of the highest-numbered proposal among the responses, or any value if no proposal was reported. (b) If an acceptor receives an accept request for a proposal numbered n, it accepts the proposal unless it has already responded to a prepare request having a number greater than n."
- **Derived Conclusion**: Paxos achieves consensus through a two-phase protocol (Prepare/Accept) using majority quorum: proposers select monotonically increasing proposal numbers, acceptors promise exclusivity to highest-numbered proposals, and acceptance requires majority agreement

### [KDC-003] PBFT three-phase Byzantine consensus

**Source Type**: grounded-external

- **Acquisition Event**: ACQ-003
- **Source Anchor**: `tasks/20260401-concurrent-03/acquire/raw-sources/src-005-pbft-paper.md`
- **Verification Status**: passed
- **Original Excerpt**: > "The algorithm works in three phases: 1. Pre-prepare: The primary assigns a sequence number to the request and multicasts a pre-prepare message to the other replicas. 2. Prepare: If a backup accepts the pre-prepare message, it enters the prepare phase by multicasting a prepare message to all other replicas. A replica is prepared when it has the pre-prepare and 2f matching prepare messages. 3. Commit: When a replica is prepared, it multicasts a commit message. A replica commits when it has 2f+1 matching commit messages (including its own)."
- **Derived Conclusion**: PBFT achieves Byzantine fault tolerance through a three-phase commit protocol (pre-prepare, prepare, commit) requiring 3f+1 replicas for f Byzantine faults, where agreement requires collecting 2f matching messages at each phase

## Potential Capability Impact
- none

## Next Promotion Target
- KDC-001: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-03-raft-consensus.md`
- KDC-002: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-03-paxos-protocol.md`
- KDC-003: promoted to `mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-03-pbft-consensus.md`

## Notes
- none
