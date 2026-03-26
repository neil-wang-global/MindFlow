# knowledge-base

This directory stores the system-level knowledge assets of `Learning`.

`knowledge-base/` is fixed into three subdirectories:

- `approved/` — the only formal knowledge area; only knowledge here may be read by `Learning(Read)`
- `drafts/` — pending knowledge awaiting review; not readable by `Learning(Read)`
- `archived/` — superseded or retired knowledge; not readable by `Learning(Read)`

## Fixed Rules

- formal knowledge may exist only in `approved/`
- neither `drafts/` nor `archived/` counts as formal knowledge
- if a knowledge file has not entered `approved/`, it must not be used as input to `Recognition` or `Analysis`
- read access rules are defined in `mind/learning/learning-read/README.md §Read Scope`
