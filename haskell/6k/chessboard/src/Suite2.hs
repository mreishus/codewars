module Suite2 where

--module Codewars.G964.Suite2 where
game :: Integer -> Either Integer (Integer, Integer)
game n
  | isOdd = Right (val, 2)
  | otherwise = Left (val `div` 2)
  where
    val = n * n
    isOdd = val `rem` 2 == 1
