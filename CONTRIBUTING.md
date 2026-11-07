# Contributing

## Commit Rules

Before making any commit, ensure commit hooks are installed:

```sh
npm install
```

Do not include `Co-Authored-By`, `Made with`, `Generated with`, or `Signed-off-by` lines in commit messages — the commit hook will reject them.

Commit messages must follow conventional commits with a required scope and body.

## Runtime Artifacts

The repository tracks the protocol and its templates only. Runtime artifacts must not be added to it — see `SYSTEM.md §Runtime Layout`:

- `mind/soul/core.md`, `mind/learning/**`, `capabilities/cap-*.md`, `tasks/**`, and `sources/**` are runtime artifacts; they live in the Runtime Root (`runtime/` by default) and are git-ignored
- `templates/` holds seed skeletons and is updated only when the protocol itself changes, never with local state
- do not add runtime artifacts to `.gitignore` exceptions, and do not commit them to make them "portable" — a runtime is reproduced by copying `templates/`, not by checking it in
- a change that only adjusts local state belongs in the Runtime Root; a change that alters protocol behavior belongs here, in the protocol files

## Task ID Format

`YYYYMMDD-short-name` (e.g. `20260324-refactor-learning`). A malformed `task-id` breaks cross-artifact traceability.
