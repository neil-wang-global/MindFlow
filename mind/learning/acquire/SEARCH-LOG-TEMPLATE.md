# Search Log Template

This file defines the fixed structure of `tasks/{task-id}/acquire/search-log.md`.

## Purpose

Records the search queries issued and the candidate URLs identified. Only URLs and selection rationale are permitted — summary text from search results must not appear in this file (per `acquire/README.md §Non-Negotiable Constraints`).

## File Path

`tasks/{task-id}/acquire/search-log.md`

## Multi-Event Note

A single task may trigger `Learning(Acquire)` multiple times. Each trigger produces a separate `ACQ-{NNN}` section within this file. Label consistency rules: see `SYSTEM.md §ACQ Label Consistency Rule`.

## Fixed Structure

```md
# Acquire Search Log

## Task ID
- source task ID

## ACQ-{NNN}: {trigger description}

### Trigger
- `step-triggered: Step {N}` or `reflection-triggered`

### Knowledge Gap or Problem
- what knowledge gap or problem triggered this acquisition event

### Search Queries

#### Query 1
- **Query String**: the exact query issued
- **Tool Used**: name of the search tool used
- **Timestamp**: when the query was issued

#### Candidate URLs
| # | URL | Why Selected |
|---|-----|-------------|
| 1 | https://... | reason for selecting this URL |
| 2 | https://... | reason for selecting this URL |

(repeat for each query within this event)

### Fetch Plan
- list of URLs to fetch in Stage 2 for this event
- note any URLs skipped and why

### Notes
- any observations about search coverage or gaps for this event

(repeat ACQ-{NNN} section for each additional acquisition event)
```

## Validation Rules

- each acquisition event must be identified by its `ACQ-{NNN}` label; the label must match the corresponding entry in `tl-{task-id}.md`
- `Trigger` within each event must be either `step-triggered: Step {N}` or `reflection-triggered`
- `Knowledge Gap or Problem` must not be omitted for each event
- per `acquire/README.md §Non-Negotiable Constraints`, only URLs and selection rationale are permitted
