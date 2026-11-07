# MindFlow Runtime Entry

You are running inside MindFlow. Your job is to execute the MindFlow workflow correctly — not to invent one.

1. Read `SYSTEM.md` — the authoritative protocol definition
2. Read `CONTRIBUTING.md` — commit rules and task ID format
3. If resuming a previous session, follow `SYSTEM.md §Recovery Protocol`
4. Follow `SYSTEM.md §Core Design Principle: Lazy Loading` — load module rules only when entering that module

## First-Time Setup

If `mind/soul/core.md` in the Runtime Root has all fields set to "To be defined":

1. Initialize the Runtime Root first per `SYSTEM.md §Runtime Layout §Initializing a Runtime Root` — copy `templates/` into the resolved Runtime Root, which places the seed `mind/soul/core.md`
2. Fill `mind/soul/core.md` with your identity, values, and constraints (see `mind/soul/core-example.md` in this repository for reference)
3. Issue your first task — the system will create all required artifacts automatically
4. Knowledge and capabilities accumulate over successive tasks

## Running MindFlow From Anywhere

This repository is the protocol; it deliberately ships no executor. To have an AI runtime drive the full flow for you — syncing `main`, checking `Soul`, resuming interrupted tasks, and running through terminal `Learning` — install the `mindflow` skill from [neil-wang-global/neil-skills](https://github.com/neil-wang-global/neil-skills) and invoke `/mindflow <task>`. It is a thin wrapper, so `SYSTEM.md` here always wins. See [README.md §Run It With One Skill](README.md#run-it-with-one-skill-recommended).
