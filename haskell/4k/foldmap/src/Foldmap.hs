module Foldmap where

import           Data.Foldable (Foldable, foldMap)
import           Data.Monoid

-- myToList : turn any Foldable into a list
--
-- Turn into single element array, let the array monoid flatten them
myToList :: Foldable t => t a -> [a]
myToList x = foldMap (\x -> [x]) x

-- myMinimum : get the minimum value from any Foldable
-- (hint : you will have to write a custom type, with a custom Monoid instance)
--
-- The key here is that we don't have Bounded.. so how are we going to
-- make an MEMPTY without a bounded value? The only way is to use Nothing, which
-- makes sense since the myMinimum is supposed to return a "Maybe a"
-- Still.. sort of a trick question?
newtype Min n = Min
  { get :: Maybe n
  }

instance (Ord n) => Semigroup (Min n) where
  Min (Just x) <> Min (Just y) = Min (Just (min x y))
  Min (Nothing) <> Min (Just y) = Min (Just y)
  Min (Just x) <> Min (Nothing) = Min (Just x)

instance (Ord n) => Monoid (Min n) where
  mempty = Min Nothing

myMinimum :: (Ord a, Foldable t) => t a -> Maybe a
myMinimum xs = get $ foldMap (\x -> Min (Just x)) xs

-- myFoldr : implement foldr in terms of foldMap
-- (hint : there is a suitable Monoid in Data.Monoid)
--
-- myFoldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
--   foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- Type signature is the same.
-- foldMap :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
myFoldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- First, build an endo by linking together... if F = (+) and xs = 1 2 3
-- We can make a a->a that adds one, two, and three together
buildEndo f xs = foldMap (\x -> Endo $ f x) xs

-- Then we can run it with the initial value
-- I'm sort of assuming a=b here? Not sure..
myFoldr f init xs = (buildEndo f xs) `appEndo` init
