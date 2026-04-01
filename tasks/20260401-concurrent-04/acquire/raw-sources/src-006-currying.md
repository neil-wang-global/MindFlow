# Raw Source

## Source ID
- src-006

## ACQ Event
- ACQ-003

## Source URL
- https://wiki.haskell.org/Currying

## Fetch Timestamp
- 2026-04-01T19:11:30Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Haskell Wiki is the authoritative community-maintained reference for the Haskell programming language

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Currying

Currying is the process of transforming a function that takes multiple arguments into a sequence of functions that each take a single argument. It is named after Haskell Curry, though it was originally discovered by Moses Schoenfinkel.

## Formal definition

Given a function `f :: (a, b) -> c`, its curried form is `curry f :: a -> b -> c`, such that:

```
curry f x y = f (x, y)
```

The inverse operation is `uncurry`:

```
uncurry f (x, y) = f x y
```

In Haskell, all functions are curried by default. When you write:

```haskell
add :: Int -> Int -> Int
add x y = x + y
```

The type `Int -> Int -> Int` is actually `Int -> (Int -> Int)`. That is, `add` is a function that takes an `Int` and returns a function `Int -> Int`.

## Partial application

Partial application is the technique of fixing some arguments of a function to produce a new function with fewer arguments. In a curried language like Haskell, partial application is simply the result of supplying fewer arguments than the function expects:

```haskell
add :: Int -> Int -> Int
add x y = x + y

increment :: Int -> Int
increment = add 1    -- partially applied: first argument is 1

double :: Int -> Int
double = (*2)        -- operator section: partially applied multiplication
```

### Operator sections

In Haskell, operator sections are a convenient syntax for partial application of binary operators:

```haskell
(+1)    -- equivalent to \x -> x + 1
(1+)    -- equivalent to \x -> 1 + x
(*2)    -- equivalent to \x -> x * 2
(>0)    -- equivalent to \x -> x > 0
```

## Relationship to function composition

Currying and function composition work together naturally. Because all functions are curried, partially applied functions can be composed:

```haskell
-- Without composition
processItem x = show (negate (abs x))

-- With composition and partial application
processItem = show . negate . abs
```

This is the essence of point-free style: by currying, we obtain functions that can be composed into pipelines without naming intermediate values.

## The `curry` and `uncurry` functions

Haskell provides `curry` and `uncurry` in the standard library:

```haskell
curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y
```

These functions convert between curried and uncurried forms:

```haskell
-- uncurried function
addPair :: (Int, Int) -> Int
addPair (x, y) = x + y

-- curried equivalent
add :: Int -> Int -> Int
add = curry addPair
```

## Historical note

Currying is named after Haskell Brooks Curry (1900-1982), an American mathematician and logician. The concept was introduced earlier by Gottlob Frege (1893) and developed by Moses Schoenfinkel (1924), but Curry's work on combinatory logic popularized the technique.

## See also

- Partial application
- Function composition
- Point-free style
- Combinatory logic
