# soul

This directory defines the `Soul` module inside `Mind`.

`Soul` is the highest constraint layer of `Mind`.  
It does not execute `Task`s, and it does not directly produce business results.  
Its only job is to provide long-term stable constraint files that can be repeatedly referenced.

## Directory Responsibility

`mind/soul/` stores long-term stable constraints only. It must not store task-level temporary content.

Current fixed rules:

- `mind/soul/core.md` is the primary file of `Soul`
- `Learning(Read)` may read `mind/soul/core.md`
- other modules may use this directory only as a constraint source and must not write task-intermediate artifacts back here

## What `Soul` Defines

`Soul` is used to define these eight classes of constraints:

- `Identity`
- `Mission`
- `Values`
- `Taboos`
- `Methodology Preference`
- `Decision Style`
- `Aesthetic Preference`
- `Learning Policy`

## Explicitly Forbidden

The following content must not be written into `mind/soul/`:

- the temporary goal of a specific `Task`
- execution instructions of a specific `Step`
- unconfirmed candidate knowledge
- implementation details of `Capability`
- task-level `Learning Record`

## Read Rules

When `Learning(Read)` reads `Soul`, it may read only:

- `mind/soul/core.md`

If additional `Soul` files are introduced in the future, they must first be declared in this directory documentation before they become readable by `Learning(Read)`.
