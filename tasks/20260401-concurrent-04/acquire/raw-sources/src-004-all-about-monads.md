# Raw Source

## Source ID
- src-004

## ACQ Event
- ACQ-002

## Source URL
- https://wiki.haskell.org/All_About_Monads

## Fetch Timestamp
- 2026-04-01T19:06:30Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Haskell Wiki is the authoritative community-maintained reference for the Haskell programming language

## Fetch Status
- success

## Fetch Completeness
- truncated — page is very large; content truncated by tool output limit to the sections most relevant to the knowledge gap (monad types overview)

## Original Content

# All About Monads

## What is a monad?

A monad is a way to structure computations in terms of values and sequences of computations using those values. Monads allow the programmer to build up computations using sequential building blocks, which can themselves be sequences of computations. The monad determines how combined computations form a new computation and frees the programmer from having to code the combination manually each time it is required.

## The Monad class

In Haskell, monads are defined by the `Monad` type class:

```haskell
class Applicative m => Monad m where
  return :: a -> m a
  (>>=)  :: m a -> (a -> m b) -> m b
```

- `return` injects a value into the monadic context
- `(>>=)` (bind) chains monadic computations

## Common monads

### Maybe

The `Maybe` monad models computations that may fail. It is defined as:

```haskell
data Maybe a = Nothing | Just a

instance Monad Maybe where
  return = Just
  Nothing >>= f = Nothing
  (Just x) >>= f = f x
```

`Maybe` short-circuits on `Nothing` — if any step in a chain produces `Nothing`, the whole chain produces `Nothing`. This is useful for computations that may not have a result, such as looking up a value in a dictionary.

### Either

The `Either` monad models computations that may fail with an error value:

```haskell
data Either e a = Left e | Right a

instance Monad (Either e) where
  return = Right
  (Left e) >>= f = Left e
  (Right x) >>= f = f x
```

`Either` is like `Maybe` but carries error information in the `Left` case. It is commonly used for error handling where the caller needs to know what went wrong.

### IO

The `IO` monad encapsulates computations that interact with the outside world:

```haskell
main :: IO ()
main = do
  name <- getLine
  putStrLn ("Hello, " ++ name)
```

The `IO` monad is special because there is no way to "escape" from it — once a computation is in `IO`, it stays in `IO`. This is how Haskell isolates side effects: all I/O operations return values in the `IO` monad, and pure code cannot invoke them directly.

The `do` notation is syntactic sugar for `>>=`:

```haskell
main = getLine >>= \name -> putStrLn ("Hello, " ++ name)
```

### State

The `State` monad threads a state value through a computation:

```haskell
newtype State s a = State { runState :: s -> (a, s) }
```

### Reader

The `Reader` monad provides read-only access to a shared environment:

```haskell
newtype Reader r a = Reader { runReader :: r -> a }
```

## Monad as a design pattern

Monads are often described as a design pattern for structuring programs with effects. Each monad type encapsulates a different kind of computational effect:

- `Maybe` — partiality (computation may not produce a value)
- `Either` — error handling (computation may fail with an error)
- `IO` — input/output (computation may interact with the outside world)
- `State` — mutable state (computation may read and write state)
- `Reader` — shared environment (computation may read a shared configuration)
- `Writer` — logging (computation may produce output alongside a value)
- `List` — nondeterminism (computation may produce multiple values)

## Functors

A functor is a type that can be mapped over. In Haskell:

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

Every monad is a functor. The functor laws are:

```
fmap id = id
fmap (f . g) = fmap f . fmap g
```

Functors represent a "container" or "context" that can have functions applied to its contents without changing the structure of the container.

## See also

- Monad laws
- Functor
- Applicative functors
- Monad transformers
