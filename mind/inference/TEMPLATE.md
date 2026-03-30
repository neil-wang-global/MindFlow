# Inference Output Template

This file defines the fixed structure of `Inference` output.

## File Naming Rule

- file path: `tasks/{task-id}/cache/inference-{slug}.md`
- `{slug}` is a short descriptor of the inference topic
- inference output is written to `cache/` because it is an intermediate artifact, not a final task result

## Fixed Structure

```md
# Inference Output

## Task ID
- source task ID

## Trigger
- which module triggered this inference
- `analysis` / `reflection` / `terminal-learning` / `user-request`

## Trigger Artifact
- the specific file and section that triggered the inference
- e.g. `tasks/{task-id}/analysis.md §Complexity Assessment`

## Question
- the specific question or gap that inference is attempting to address

## Reasoning
- the inference chain
- premises, evidence, and logical steps

## Provisional Conclusion
- the conclusion reached by inference
- must be explicitly marked as provisional

## Confidence
- `high` / `medium` / `low`
- basis for the confidence assessment

## Constraints Applied
- which `Soul` constraints were considered during inference
- which knowledge from `Learning(Read)` informed the reasoning

## Limitations
- what this inference does not cover
- what assumptions were made
- what additional information would change the conclusion

## Status
- `provisional` / `accepted-into-analysis` / `accepted-into-reflection` / `accepted-into-terminal-learning` / `rejected`
```

## Validation Rules

- `Trigger` must not be omitted; must be one of: `analysis` / `reflection` / `terminal-learning` / `user-request`
- `Trigger Artifact` must not be omitted; must point to a specific file and section
- `Provisional Conclusion` must not be omitted
- `Status` defaults to `provisional` at creation time
- inference output must not be directly promoted to `approved/` knowledge or applied as a capability change
- if an inference conclusion is later validated by task results or external sources, it may enter the learning pipeline through the normal `tl-{task-id}.md` → `draft-*.md` → `review-*.md` path
