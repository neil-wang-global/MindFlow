# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-concurrent-04

## Summary
- Referential transparency is the formal property that an expression can be replaced by its value without behavioral change; pure functions (output depends solely on inputs, no side effects) plus immutable data yield referential transparency, forming the foundational triad of functional programming

## From Task Learning
- mind/learning/task-learning/tl-20260401-concurrent-04.md
- candidate knowledge item reference: KDC-001

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-concurrent-04/acquire/raw-sources/src-001-referential-transparency.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-concurrent-04/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "An expression e is referentially transparent if, for all programs p, all occurrences of e in p can be replaced by the result of evaluating e without affecting the observable behavior of p. A more formal way to state this: if `e1 = e2` then for any context `C`, `C[e1] = C[e2]`. This property is also known as Leibniz's law or the principle of substitutivity of equals."

## Candidate Conclusion
- Referential transparency is the formal property that enables equational reasoning in functional programming — an expression can be replaced by its value without behavioral change. This connects directly to pure functions (whose outputs depend solely on inputs with no side effects) and immutability (values cannot be reassigned, ensuring expressions always evaluate consistently). The three concepts form a mutually reinforcing triad: immutable data plus pure functions yield referential transparency.

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-concurrent-04-referential-transparency.md

## Notes
- none
