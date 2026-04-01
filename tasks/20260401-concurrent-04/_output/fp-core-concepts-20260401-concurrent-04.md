# Functional Programming Core Concepts — Knowledge Synthesis

## Task ID
- 20260401-concurrent-04

## Overview
This document synthesizes the three core functional programming concepts acquired through this task: immutability and pure functions, monads and functors, and higher-order functions with currying. All content is grounded in verified sources from the Haskell Wiki.

## 1. Immutability and Pure Functions

### Referential Transparency
An expression is referentially transparent if it can be replaced with its corresponding value without changing the program's behavior. Formally: if `e1 = e2` then for any context `C`, `C[e1] = C[e2]` (Leibniz's law).

### Pure Functions
A function is pure if: (1) its result depends only on argument values, and (2) evaluation causes no observable side effects. Pure functions are inherently thread-safe and can be memoized.

### Immutability
Once a value is created, it cannot be changed. Benefits include thread safety, predictability, structural sharing for memory efficiency, and natural state history preservation. In Haskell, all bindings are immutable by default.

### Side-Effect Isolation
Purely functional languages isolate side effects using the type system. The IO monad encapsulates operations that interact with the outside world, preventing pure functions from accidentally performing I/O.

## 2. Monads and Functors

### Functor Laws
A functor is a type that can be mapped over: `fmap :: (a -> b) -> f a -> f b`. Two laws: identity (`fmap id = id`) and composition (`fmap (f . g) = fmap f . fmap g`).

### Monad Laws
1. Left identity: `return a >>= f = f a`
2. Right identity: `m >>= return = m`
3. Associativity: `(m >>= f) >>= g = m >>= (\x -> f x >>= g)`

Using Kleisli composition `(>=>)`, these state that Kleisli composition forms a category with `return` as identity morphism.

### Specific Monad Types
- **Maybe**: models computations that may fail; short-circuits on `Nothing`
- **Either**: models computations that may fail with error information; `Left` carries error, `Right` carries success
- **IO**: encapsulates side-effecting computations; no way to escape once in IO

## 3. Higher-Order Functions and Currying

### Higher-Order Functions
Functions that take functions as arguments or return functions as results. Canonical examples: `map`, `filter`, `foldr`.

### Currying
Transforming a function of multiple arguments into a chain of single-argument functions. In Haskell, all functions are curried by default: `Int -> Int -> Int` is `Int -> (Int -> Int)`.

### Partial Application
Fixing some arguments to produce a new function with fewer arguments. Natural consequence of currying.

### Function Composition
The `(.)` operator: `(f . g) x = f (g x)`. Satisfies associativity: `(f . g) . h = f . (g . h)` with identity: `f . id = f`.

### Point-Free Style
Defining functions without mentioning arguments, using composition and partial application: `sumSquares = sum . map (^2)`.

## Sources
- ACQ-001: src-001 (Haskell Wiki: Referential transparency), src-002 (Haskell Wiki: Functional programming)
- ACQ-002: src-003 (Haskell Wiki: Monad laws), src-004 (Haskell Wiki: All About Monads)
- ACQ-003: src-005 (Haskell Wiki: Higher order function), src-006 (Haskell Wiki: Currying)
