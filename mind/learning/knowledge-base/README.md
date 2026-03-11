# knowledge-base

This directory stores the system-level knowledge assets of `Learning`.

`knowledge-base/` is fixed into three subdirectories:

- `approved/`
- `drafts/`
- `archived/`

## Directory Definitions

### `approved/`

This is the only formal knowledge area.

Only knowledge that has entered `approved/` may be read by `Learning(Read)`.

It stores:

- concept knowledge approved by `Review`
- method knowledge approved by `Review`
- domain knowledge approved by `Review`
- system self-knowledge approved by `Review`

### `drafts/`

This is the pending knowledge area.

It stores:

- candidate knowledge that has not yet completed review
- knowledge files newly extracted from tasks and waiting to enter `reviews/`

`Learning(Read)` must not read this area.

### `archived/`

This is the historical knowledge area.

It stores:

- superseded old knowledge
- retired knowledge that must still be preserved for traceability

`Learning(Read)` must not read this area by default.

## Fixed Rules

- formal knowledge may exist only in `approved/`
- neither `drafts/` nor `archived/` counts as formal knowledge
- if a knowledge file has not entered `approved/`, it must not be used as input to `Recognition` or `Analysis`
