# mind

This directory contains the runtime module definitions of `Mind`.

`Mind` is the runtime base of the entire system.

## Main Flow

Every task must go through:

`Task -> Learning(Read) -> Recognition -> Analysis -> Execution -> Plan -> Execution Control -> [Learning(Acquire)?] -> Reflection -> [Learning(Acquire)?] -> Learning`

Notes:

- `Learning(Read)` first reads `mind/soul/core.md` and `mind/learning/knowledge-base/approved/`
- `Recognition` is responsible for producing `Task Profile`
- `Analysis` is responsible for producing `Analysis Output`
- `Execution` has only one formal output: `Plan`
- `Execution Control` is responsible for advancing `Step`s according to `Plan`
- `Learning(Acquire)` is conditionally triggered during `Step` execution or after `Reflection`; when triggered it is mandatory and must complete all three stages (Search, Fetch and Preserve, Verify) before any external knowledge may enter `tl-{task-id}.md`
- `Reflection` has one formal output: `Reflection Report`
- terminal `Learning` is the mandatory post-task closure loop

## Directory Overview

Each subdirectory owns exactly one module and must not overreach into other modules:

- `recognition/`: recognition and `Task Profile`
- `analysis/`: modeling and decomposition
- `execution/`: materialization into executable `Plan`
- `execution-control/`: runtime advancement according to `Plan`
- `reflection/`: post-task review
- `learning/`: `Learning(Read)`, `Learning(Acquire)`, knowledge consolidation, and `Capability Update`
- `inference/`: on-demand inference
- `soul/`: long-term stable constraints
