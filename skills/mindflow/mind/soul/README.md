# soul

This directory defines the `Soul` module inside `Mind`.

`Soul` is the highest constraint layer of `Mind`.
It does not execute `Task`s, and it does not directly produce business results.
Its only job is to provide long-term stable constraint files that can be repeatedly referenced.

The protocol for `Soul` lives in this directory; the `Soul` file itself is runtime state and lives in the Runtime Root (see `SYSTEM.md §Runtime Layout`). The repository contains only the seed `templates/mind/soul/core.md`.

## What `Soul` Defines

`Soul` defines these eight classes of constraints:

- `Identity`
- `Mission`
- `Values`
- `Taboos`
- `Methodology Preference`
- `Decision Style`
- `Aesthetic Preference`
- `Learning Policy`

## Read Rules

When any module reads `Soul`, it may read only:

- `mind/soul/core.md`

`mind/soul/core.md` resolves against the Runtime Root. No `core.md` exists in the repository — the seed file is `templates/mind/soul/core.md`.

If additional `Soul` files are introduced in the future, they must first be declared in this documentation before they become readable.

## Bootstrap

When `mind/soul/core.md` in the Runtime Root has all fields set to "To be defined", `Soul` constraints are not enforced. This is the state of a freshly initialized Runtime Root: copy `templates/mind/soul/core.md` into `mind/soul/core.md` under the Runtime Root and fill it (see `SYSTEM.md §Runtime Layout §Initializing a Runtime Root` and `CLAUDE.md §First-Time Setup`).

`Learning(Read)` must record this state explicitly in `learning-read.md §Soul Reads` (see `mind/learning/learning-read/TEMPLATE.md` for the exact wording).

## Explicitly Forbidden

The following content must not be written into `mind/soul/`:

- the temporary goal of a specific `Task`
- execution instructions of a specific `Step`
- unconfirmed candidate knowledge
- implementation details of `Capability`
- task-level `Learning Record`

The following is also forbidden regardless of directory:

- writing `core.md` into the Protocol Root, or editing `templates/mind/soul/core.md` to record task state
