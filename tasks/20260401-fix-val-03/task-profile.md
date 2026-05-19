# Task Profile

## Task ID
- 20260401-fix-val-03

## Task Type
- learning

## Goal
- Learn about two distinct topics: (1) the Raft consensus protocol's leader election mechanism, including randomized election timeouts, RequestVote RPC, term monotonicity, and split vote handling; and (2) the internal memory management algorithm of a proprietary real-time database called "QuantumDB X9." The first topic is well-documented and should succeed; the second is fictional/nonexistent and should exhaust all acquisition attempts, producing a knowledge gap.

## Inputs
- `tasks/20260401-fix-val-03/learning-read.md` — audit record of prior knowledge reads
- `mind/learning/knowledge-base/approved/kb-concept-raft-consensus.md` — existing high-level Raft knowledge (covers decomposition into three subproblems but not leader election details)
- `mind/soul/core.md` — soul constraints (distributed systems engineer, primary source prioritization)

## Success Criteria
- Raft leader election mechanism knowledge acquired, verified, and promoted to knowledge base
- QuantumDB X9 acquisition exhausted with a formal knowledge gap file created
- Knowledge Outcome set to `partially-acquired` (one success, one exhaustion)
- Overall Status set to `completed`

## Complexity
- medium

## Risk
- medium

## Capability Needs
- web-search: to find Raft paper and QuantumDB X9 documentation
- web-fetch: to retrieve source documents
- knowledge-management: to process knowledge through the promotion pipeline

## Constraints
- Soul Learning Policy requires primary sources (the Raft paper by Ongaro & Ousterhout, 2014, is the canonical source)
- QuantumDB X9 is fictional; no primary sources exist; ACQ must be formally exhausted
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid sources
- 4 pending capability updates exceed the 3+ threshold (flagged in learning-read)
- 3 deferred reviews exceed the 2+ threshold (flagged in learning-read)

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — task is straightforward knowledge acquisition without applicability analysis

## Notes
- This task exercises mixed ACQ outcomes: one successful acquisition through the full pipeline (draft, review, kb) and one exhausted acquisition resulting in a knowledge gap file
