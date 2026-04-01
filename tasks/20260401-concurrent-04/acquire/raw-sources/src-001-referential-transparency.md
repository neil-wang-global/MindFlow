# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001

## Source URL
- https://wiki.haskell.org/Referential_transparency

## Fetch Timestamp
- 2026-04-01T19:01:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Haskell Wiki is the authoritative community-maintained reference for the Haskell programming language and functional programming concepts

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Referential transparency

Referential transparency is an important property of functional programming. An expression is called referentially transparent if it can be replaced with its corresponding value without changing the program's behavior. This requires that the expression is pure, that is to say the expression value must be the same for the same inputs and its evaluation must have no side effects.

## Definition

An expression e is referentially transparent if, for all programs p, all occurrences of e in p can be replaced by the result of evaluating e without affecting the observable behavior of p.

A more formal way to state this: if `e1 = e2` then for any context `C`, `C[e1] = C[e2]`. This property is also known as Leibniz's law or the principle of substitutivity of equals.

## Connection to pure functions

A function f is pure if the expression f(x) is referentially transparent for all referentially transparent arguments x. Pure functions have two properties:

1. The result depends only on the argument values (no dependence on hidden state).
2. Evaluation of the result does not cause any observable side effect (no mutation of mutable objects, no output to I/O devices).

Because pure functions have no side effects, they are inherently thread-safe and can be memoized.

## Referential transparency and immutability

Referential transparency is closely related to immutability. If all values are immutable, then every expression is referentially transparent because:

- Variables cannot be reassigned, so a name always refers to the same value
- Data structures cannot be modified in place, so structural sharing is safe
- Functions cannot depend on mutable state, so they are automatically pure

In Haskell, all values are immutable by default. This is enforced by the type system and is one of the key properties that makes Haskell a purely functional language.

## Equational reasoning

Referential transparency enables equational reasoning — the ability to substitute equals for equals when reasoning about programs. Given that `f x = x + 1`, we can replace any occurrence of `f 3` with `4` without changing the program's behavior.

This property is the foundation of program transformation and optimization techniques used by compilers and programmers alike.

## See also

- Pure functions
- Side effects
- IO monad
- Lambda calculus
