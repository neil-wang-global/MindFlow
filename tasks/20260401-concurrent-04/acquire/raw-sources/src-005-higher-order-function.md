# Raw Source

## Source ID
- src-005

## ACQ Event
- ACQ-003

## Source URL
- https://wiki.haskell.org/Higher_order_function

## Fetch Timestamp
- 2026-04-01T19:11:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Haskell Wiki is the authoritative community-maintained reference for the Haskell programming language

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Higher order function

A higher-order function is a function that takes other functions as arguments or returns a function as result.

## Definition

In mathematics and computer science, a higher-order function (also functional, functional form, or functor — though the latter term has a more specific meaning in category theory) is a function that does at least one of the following:

- takes one or more functions as arguments (i.e., a procedural parameter which is a function)
- returns a function as its result

All other functions are first-order functions. In mathematics, higher-order functions are also termed operators or functionals.

## Examples in Haskell

The canonical higher-order functions are `map`, `filter`, and `fold`:

### map

`map` applies a function to every element of a list:

```haskell
map :: (a -> b) -> [a] -> [b]
map f []     = []
map f (x:xs) = f x : map f xs
```

Example:
```haskell
map (+1) [1,2,3]  -- [2,3,4]
map show [1,2,3]  -- ["1","2","3"]
```

### filter

`filter` selects elements from a list that satisfy a predicate:

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter p []     = []
filter p (x:xs)
  | p x       = x : filter p xs
  | otherwise  = filter p xs
```

### foldr

`foldr` reduces a list using a binary function:

```haskell
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)
```

Example:
```haskell
foldr (+) 0 [1,2,3]  -- 6
```

## Function composition

Function composition is one of the most important operations on higher-order functions. In Haskell, it is expressed with the `(.)` operator:

```haskell
(.) :: (b -> c) -> (a -> b) -> (a -> c)
(f . g) x = f (g x)
```

This satisfies the mathematical law of associativity:
```
(f . g) . h  =  f . (g . h)
```

And has an identity element:
```
f . id  =  f
id . f  =  f
```

## Point-free style

Point-free style (also called tacit programming) is a style of defining functions without mentioning their arguments. It relies heavily on function composition and partial application:

```haskell
-- Pointed style (mentions argument x)
sumSquares x = sum (map (^2) x)

-- Point-free style (no mention of argument)
sumSquares = sum . map (^2)
```

Point-free style can make code more concise and emphasize the data flow pipeline, but overuse can reduce readability.

## Relationship to currying

In Haskell, all functions are automatically curried — a function of multiple arguments is actually a chain of functions each taking one argument. This makes partial application natural:

```haskell
add :: Int -> Int -> Int
add x y = x + y

add3 :: Int -> Int
add3 = add 3  -- partial application: fix the first argument
```

## See also

- Function composition
- Currying
- Lambda expressions
- Pointfree
