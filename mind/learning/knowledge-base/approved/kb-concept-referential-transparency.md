# Knowledge Base Entry

## Type
- concept

## Summary
- Referential transparency is the formal property that enables equational reasoning in functional programming -- an expression can be replaced by its value without behavioral change. This connects directly to pure functions (whose outputs depend solely on inputs with no side effects) and immutability (values cannot be reassigned, ensuring expressions always evaluate consistently). The three concepts form a mutually reinforcing triad: immutable data plus pure functions yield referential transparency.

## Source Lineage
- Task ID: 20260401-concurrent-04
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-04.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-04-referential-transparency.md
- Review File: mind/learning/reviews/review-20260401-concurrent-04-referential-transparency.md
- Original Source Anchor: tasks/20260401-concurrent-04/acquire/raw-sources/src-001-referential-transparency.md
- Original Source URL: https://wiki.haskell.org/Referential_transparency

## Key Evidence
> "An expression e is referentially transparent if, for all programs p, all occurrences of e in p can be replaced by the result of evaluating e without affecting the observable behavior of p. A more formal way to state this: if `e1 = e2` then for any context `C`, `C[e1] = C[e2]`. This property is also known as Leibniz's law or the principle of substitutivity of equals."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-04-referential-transparency.md

## Applicability
- Applies to: reasoning about program correctness in functional and functional-influenced languages; understanding why immutability and purity matter for program reliability; informing design decisions about side-effect management in distributed systems
- Does not apply to: imperative programming contexts where mutation is intentional and managed; performance-critical code paths where mutable state is necessary

## Notes
- none
