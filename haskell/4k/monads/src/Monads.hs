{-# LANGUAGE NoImplicitPrelude #-}

module Monads where

import           Data.Monoid
import           Prelude     hiding (Identity, Maybe (..), Monad, Reader, State,
                              Writer)

class Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b

data Identity a =
  Identity a
  deriving (Show, Eq)

data Maybe a
  = Nothing
  | Just a
  deriving (Show, Eq)

data State s a = State
  { runState :: s -> (a, s)
  }

data Reader s a = Reader
  { runReader :: s -> a
  }

data Writer w a = Writer
  { runWriter :: (w, a)
  }

instance Monad Identity where
  return = Identity
  (Identity v) >>= f = f v

instance Monad Maybe where
  return = Just
  Nothing >>= f = Nothing
  (Just v) >>= f = f v

instance Monad (State s) where
  return x = State (\state -> (x, state))
  (>>=) state1 f =
    State
      (\state ->
         let (state1result, newstate) = runState state1 state
          in runState (f state1result) newstate)

instance Monad (Reader s) where
  return x = Reader (\state -> x)
  (Reader g) >>= f = Reader (\state -> runReader (f (g state)) state)

instance Monoid w => Monad (Writer w) where
  return x = Writer (mempty, x)
  (Writer (s, v)) >>= f =
    let (w_new, new_value) = runWriter (f v)
     in Writer (s `mappend` w_new, new_value)
