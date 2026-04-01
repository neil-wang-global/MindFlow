# Distributed Consensus Algorithms Research Summary

## Task ID
20260401-concurrent-03

## Overview
Research on three distributed consensus algorithms: Raft, Paxos, and PBFT.

## Key Findings

### Raft
- Leader-based consensus with decomposed subproblems: leader election, log replication, safety
- Requires 2f+1 nodes for f crash faults; equivalent to Paxos in guarantees
- Designed for understandability over Paxos

### Paxos
- Two-phase protocol (Prepare/Accept) with proposers, acceptors, learners
- Requires 2f+1 acceptors for f crash faults
- Multi-Paxos optimizes with stable leader to skip Phase 1
- Livelock possible without leader election

### PBFT
- Three-phase protocol (Pre-prepare/Prepare/Commit) tolerating Byzantine faults
- Requires 3f+1 nodes for f Byzantine faults (optimal bound)
- O(n^2) message complexity limits scalability

## Sources
- 6 verified sources across 3 acquisition events (all passed verification)
