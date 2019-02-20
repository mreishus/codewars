module XO where

--module Codewars.Kata.XO where
import qualified Data.Char as C

-- | Returns true if the number of
-- Xs is equal to the number of Os
-- (case-insensitive)
xo :: String -> Bool
xo str = o_num == x_num
  where
    o_num = length $ filter ((==) 'o') xsLower
    x_num = length $ filter ((==) 'x') xsLower
    xsLower = map C.toLower str
