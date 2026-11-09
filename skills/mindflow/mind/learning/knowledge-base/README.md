# knowledge-base

This directory stores the system-level knowledge assets of `Learning`.

The directories below are the layout of the knowledge base inside the Runtime Root. The repository does not contain this tree: it holds only the documentation and templates of `mind/learning/knowledge-base/`.

Paths in this module are relative to the Runtime Root (see `SYSTEM.md §Runtime Layout`); paths naming `README.md` / `TEMPLATE.md` files resolve against the Protocol Root.

`knowledge-base/` is fixed into three subdirectories:

- `approved/` — the only formal knowledge area; only knowledge here may be read by `Learning(Read)`
- `drafts/` — pending knowledge awaiting review; not readable by `Learning(Read)`
- `archived/` — superseded or retired knowledge; not readable by `Learning(Read)`

## Fixed Rules

- formal knowledge may exist only in `approved/`
- neither `drafts/` nor `archived/` counts as formal knowledge
- if a knowledge file has not entered `approved/`, it must not be used as input to `Recognition` or `Analysis`
- read access rules are defined in `mind/learning/learning-read/README.md §Read Scope`
