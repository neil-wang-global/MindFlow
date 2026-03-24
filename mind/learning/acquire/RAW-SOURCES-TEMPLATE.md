# Raw Source Template

This file defines the fixed structure of individual raw source files saved under `tasks/{task-id}/acquire/raw-sources/`.

## File Naming Rule

- file path: `tasks/{task-id}/acquire/raw-sources/src-{NNN}-{slug}.md`
- `{NNN}` is a zero-padded sequence number, e.g. `001`, `002`
- `{slug}` is a short descriptor of the source content

## Purpose

Each file stores the complete, unmodified content fetched from one URL. No summarization, extraction, paraphrasing, or interpretation is permitted in this file. The content field must contain the raw fetched text exactly as returned by the fetch tool.

## Fixed Structure

```md
# Raw Source

## Source ID
- src-{NNN}

## ACQ Event
- ACQ-{NNN} — the acquisition event that triggered this fetch; must match the corresponding entry in `search-log.md` and `verification-report.md`

## Source URL
- the URL that was actually fetched

## Fetch Timestamp
- date and time when the fetch was performed

## Source Type
- Academic Article / Technical Documentation / Official Announcement / News Report / Blog Post / Other

## Credibility Assessment
- High / Medium / Low
- assessment is based on source authority only, not on content

## Fetch Status
- `success` or `failed: {reason}`

## Original Content

[Complete verbatim content from fetch tool. Must not be modified, summarized, or extracted from.]
```

## Validation Rules

- `ACQ Event` must not be omitted; must match an ACQ-{NNN} entry in `search-log.md`
- `Source URL` must not be omitted
- `Fetch Timestamp` must not be omitted
- `Original Content` must contain the full fetched text — not a summary, not key points, not excerpts
- A file with `Fetch Status: failed` must not contain fabricated content in `Original Content`
- No interpretation fields (key points, relevance, extracted data) are permitted in this file
