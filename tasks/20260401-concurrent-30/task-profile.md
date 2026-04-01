# Task Profile

## Task ID
- 20260401-concurrent-30

## Task Type
- learning

## Goal
- Research distributed coordination mechanisms across two domains: (1) leader election algorithms (Bully algorithm, Ring algorithm) and (2) distributed locking mechanisms (Redlock, Chubby, ZooKeeper locks). Each domain requires external knowledge acquisition. The output is a consolidated research document covering both coordination topics.

## Inputs
- Task statement specifying two research areas with ACQ requirements
- Soul constraints from `mind/soul/core.md` (primary source preference, evidence-based design)
- No directly relevant approved KB entries (existing entries cover CAP/PACELC theory but not coordination primitives)

## Success Criteria
- Both ACQ events (ACQ-001 for leader election, ACQ-002 for distributed locking) complete with verified sources
- Output document `_output/distributed-coordination-research.md` covers both topics with source-backed findings
- Knowledge candidates from both ACQ events are promoted through the full knowledge pipeline
- ACQ label consistency holds across all artifacts

## Complexity
- medium

## Risk
- medium

## Capability Needs
- Research and knowledge synthesis
- Source verification and cross-validation
- Distributed systems domain knowledge

## Constraints
- All ACQ source IDs must be unique across both events
- ACQ labels (ACQ-001, ACQ-002) must be consistent across state.md, search-log.md, verification-report.md, and tl-{task-id}.md
- Concurrency rules: do not modify existing shared files; all created files must include task-id; append only to INDEX.md
- Knowledge Source Prohibition: search summaries and AI-generated overviews are never valid sources

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — this is a straightforward dual-ACQ research task without ambiguous analysis requiring inference

## Notes
- Multi-ACQ task: both steps trigger separate Learning(Acquire) events sharing the same acquire/ directory
- search-log.md and verification-report.md will have separate sections for ACQ-001 and ACQ-002
