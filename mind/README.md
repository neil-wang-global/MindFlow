# mind

This file is a navigation aid for human readers. The runtime loads `SYSTEM.md` at task start and each module's `README.md` on demand — it does not load this file.

This directory contains the runtime module definitions of `Mind`.

`Mind` is the runtime base of the entire system.

## Main Flow

See `SYSTEM.md §Required Main Flow` for the authoritative flow definition and artifact data flow.

```
Learning(Read) → Recognition → Analysis → Planning → Plan → Execution Control → Reflection → Terminal Learning
     │                                                      │                  │
     │                                                      ▼                  ▼
     │                                              Learning(Acquire)   Learning(Acquire)
     │                                              (mid-step, if gap)  (post-reflection)
     │
     └── reads: soul/core.md, knowledge-base/approved/, knowledge-gaps/, capability-updates/, reviews/
```

## Directory Overview

Each subdirectory owns exactly one module. Each module's `README.md` is self-contained — it defines all rules needed when the runtime enters that module. The runtime loads a module's `README.md` (and `TEMPLATE.md` when producing artifacts) upon entering that module.

- `recognition/`: recognition and `Task Profile`
- `analysis/`: modeling and decomposition
- `planning/`: materialization into executable `Plan`
- `execution-control/`: runtime advancement according to `Plan`
- `reflection/`: post-task review
- `learning/`: `Learning(Read)`, `Learning(Acquire)`, knowledge consolidation, and `Capability Update`
- `inference/`: on-demand inference
- `soul/`: long-term stable constraints
