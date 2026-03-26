# Contributing

## Commit Rules

Before making any commit, ensure commit hooks are installed:

```sh
npm install
```

Do not include `Co-Authored-By`, `Made with`, `Generated with`, or `Signed-off-by` lines in commit messages — the commit hook will reject them.

Commit messages must follow conventional commits with a required scope and body.

## Task ID Format

`YYYYMMDD-short-name` (e.g. `20260324-refactor-learning`). A malformed `task-id` breaks cross-artifact traceability.
