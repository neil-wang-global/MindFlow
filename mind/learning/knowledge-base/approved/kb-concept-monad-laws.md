# Knowledge Base Entry

## Type
- concept

## Summary
- The three monad laws (left identity, right identity, associativity) are not compiler-enforced but are essential correctness contracts. Using Kleisli composition, they state that monadic function composition forms a category with `return` as identity morphism. This means monadic programs can be refactored using these laws as program transformation rules, analogous to how referential transparency enables equational reasoning for pure functions.

## Source Lineage
- Task ID: 20260401-concurrent-04
- Task Learning Record: mind/learning/task-learning/tl-20260401-concurrent-04.md
- Draft File: mind/learning/knowledge-base/drafts/draft-concept-20260401-concurrent-04-monad-laws.md
- Review File: mind/learning/reviews/review-20260401-concurrent-04-monad-laws.md
- Original Source Anchor: tasks/20260401-concurrent-04/acquire/raw-sources/src-003-monad-laws.md
- Original Source URL: https://wiki.haskell.org/Monad_laws

## Key Evidence
> "All instances of the Monad type class should satisfy the following laws. These laws are not enforced by the compiler, but violating them will produce code that behaves incorrectly."

## Review Status
- accepted

## Approved By Review
- mind/learning/reviews/review-20260401-concurrent-04-monad-laws.md

## Applicability
- Applies to: designing composable effect systems; understanding monadic abstractions in Haskell, Scala, or other languages with monad support; reasoning about program transformation correctness when using monadic composition
- Does not apply to: languages without monadic abstraction support; contexts where side effects are managed through other mechanisms (e.g., dependency injection, actor model)

## Notes
- none
