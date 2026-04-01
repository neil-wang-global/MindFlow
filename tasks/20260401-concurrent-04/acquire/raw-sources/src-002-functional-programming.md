# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001

## Source URL
- https://wiki.haskell.org/Functional_programming

## Fetch Timestamp
- 2026-04-01T19:01:30Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Haskell Wiki is the authoritative community-maintained reference for the Haskell programming language and functional programming concepts

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Functional programming

Functional programming is a programming paradigm that treats computation as the evaluation of mathematical functions and avoids changing-state and mutable data. It is a declarative programming paradigm, which means programming is done with expressions or declarations instead of statements.

## Core principles

### Pure functions

In functional programming, functions are pure: they take inputs and produce outputs without side effects. A pure function's output is determined entirely by its inputs.

Properties of pure functions:
- Deterministic: same inputs always produce the same output
- No side effects: no mutation of external state, no I/O operations
- Referentially transparent: can be replaced by their return value

### Immutability

Immutability means that once a value is created, it cannot be changed. Instead of modifying existing data, functional programs create new values.

Benefits of immutability:
- Thread safety: immutable data can be freely shared between threads
- Predictability: values do not change unexpectedly
- Structural sharing: efficient memory usage through sharing unchanged parts
- Undo/redo: previous states are naturally preserved

In Haskell, all bindings are immutable. You cannot reassign a variable:

```haskell
x = 5
-- x = 6  -- This would be a type error in Haskell
```

### Side-effect isolation

Purely functional languages like Haskell isolate side effects using the type system. The IO monad encapsulates all operations that interact with the outside world:

```haskell
-- Pure function: no IO
add :: Int -> Int -> Int
add x y = x + y

-- Impure function: IO monad
greet :: String -> IO ()
greet name = putStrLn ("Hello, " ++ name)
```

The type system ensures that pure functions cannot accidentally perform I/O or mutate state. Side effects are explicitly marked in the type signature.

## Advantages over imperative programming

1. Easier reasoning: referential transparency allows equational reasoning
2. Better testability: pure functions are easy to unit test
3. Natural parallelism: no shared mutable state means no data races
4. Composability: pure functions compose cleanly via function composition

## Historical foundations

Functional programming is rooted in lambda calculus, developed by Alonzo Church in the 1930s. Lambda calculus is a formal system for expressing computation based on function abstraction and application.

Key historical languages:
- LISP (1958) — first functional language
- ML (1973) — introduced type inference
- Haskell (1990) — purely functional, lazy evaluation
- Erlang (1986) — functional with actor model for concurrency

## See also

- Referential transparency
- Higher-order functions
- Monads
- Lambda calculus
