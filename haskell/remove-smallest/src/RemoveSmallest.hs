module RemoveSmallest where

--module Codewars.Kata.RemoveSmallest where
removeSmallest :: [Int] -> [Int]
removeSmallest xs = rejectFirst ((==) min) xs
  where
    min = minimum xs

rejectFirst :: (a -> Bool) -> [a] -> [a]
rejectFirst _ [] = []
rejectFirst p (x:xs)
  | p x = xs
  | otherwise = x : (rejectFirst p xs)
