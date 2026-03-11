# inference

This directory defines the `Inference` module.

Responsibilities:

- perform controlled inference
- provide candidate conclusions when needed

Notes:

- `Inference` is not a permanently active default `Step`
- its output is provisional by default and does not directly become a formal capability

## Common Trigger Conditions

- `Analysis` lacks sufficient information
- `Reflection` discovers reusable lessons
- `Learning` requires abstraction
- the user explicitly requests it

## Required Constraint Loading Before Execution

Before running `Inference`, the agent must read:

- `mind/soul/core.md`
- the upstream artifact that triggered it
