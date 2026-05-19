# Task Profile

## Task ID
- 20260401-fix-val-07

## Task Type
- learning

## Goal
- Systematically learn about distributed locking mechanisms across three technologies: (1) Redis-based distributed locks focusing on the Redlock algorithm, (2) ZooKeeper-based distributed locks using recipes and ephemeral znodes, (3) etcd-based distributed locks using lease mechanisms with comparison to ZooKeeper. Each technology represents a distinct approach to achieving mutual exclusion in distributed systems.

## Inputs
- Existing KB entries: `kb-concept-redlock-algorithm.md`, `kb-concept-zookeeper-locks.md`
- Soul constraints from `mind/soul/core.md` — prioritize primary sources, quantitative benchmarks
- Task statement specifying 3 Steps with acquire-required

## Success Criteria
- plan.md contains `## Step Independence Matrix` with 3 pair evaluations
- All 3 ACQ events complete successfully
- Knowledge Outcome = `fully-acquired`
- Overall Status = `completed`

## Complexity
- medium

## Risk
- low

## Capability Needs
- External knowledge acquisition (web search and source verification)
- Distributed systems domain knowledge
- Comparative analysis across locking technologies

## Constraints
- All 3 Steps must have `Learning: acquire-required`
- Step Independence Matrix required (3+ acquire-required Steps)
- Each Step targets a different locking technology — overlap should be low or none
- No git commits to be created
- Soul learning policy: primary sources only, validate external claims

## Task-level Learning Possibility
- acquire-likely

## Mode
- standard

## Inference Possibility
- not expected — straightforward knowledge acquisition task with clear boundaries

## Notes
- Two of the three topics already have approved KB entries; ACQ events should deepen understanding beyond existing entries
- etcd-based locks have no existing KB coverage, requiring fresh acquisition
