# Raw Source

## Source ID
- src-003

## ACQ Event
- ACQ-002

## Source URL
- https://wiki.haskell.org/Monad_laws

## Fetch Timestamp
- 2026-04-01T19:06:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High — Haskell Wiki is the authoritative community-maintained reference for the Haskell programming language

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

# Monad laws

All instances of the Monad type class should satisfy the following laws. These laws are not enforced by the compiler, but violating them will produce code that behaves incorrectly.

## The three monad laws

### 1. Left identity

```
return a >>= f  ≡  f a
```

If we inject a value `a` into a monadic context with `return` and then feed it to a monadic function `f` with `>>=`, the result should be the same as just applying `f` to `a`.

### 2. Right identity

```
m >>= return  ≡  m
```

If we take a monadic value `m` and feed it to `return` with `>>=`, we get back `m`. In other words, `return` is a neutral element for `>>=`.

### 3. Associativity

```
(m >>= f) >>= g  ≡  m >>= (\x -> f x >>= g)
```

Composing monadic functions with `>>=` should be associative. It does not matter whether we first compose `f` and `g` or first apply `f` to `m` and then apply `g`.

## Equivalently, using Kleisli composition

The monad laws can also be expressed using the Kleisli composition operator `(>=>)`:

```haskell
(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> (a -> m c)
f >=> g = \x -> f x >>= g
```

Using Kleisli composition, the laws become:

1. `return >=> f  ≡  f` (left identity)
2. `f >=> return  ≡  f` (right identity)
3. `(f >=> g) >=> h  ≡  f >=> (g >=> h)` (associativity)

In this form, the laws state that Kleisli composition forms a category with `return` as the identity morphism.

## Why the laws matter

The monad laws ensure that monadic composition behaves predictably:
- Programs can be refactored using these laws without changing behavior
- Library authors can rely on these laws to write generic monadic code
- The laws correspond to the mathematical definition of a monad as a monoid in the category of endofunctors

## Functor and Applicative laws

Since every Monad is also a Functor and Applicative, the following laws must also hold:

### Functor laws
```
fmap id  ≡  id                    -- identity
fmap (f . g)  ≡  fmap f . fmap g  -- composition
```

### Applicative laws
```
pure id <*> v  ≡  v                            -- identity
pure (.) <*> u <*> v <*> w  ≡  u <*> (v <*> w) -- composition
pure f <*> pure x  ≡  pure (f x)               -- homomorphism
u <*> pure y  ≡  pure ($ y) <*> u               -- interchange
```

## See also

- Monad
- Functor
- Applicative
- Category theory
