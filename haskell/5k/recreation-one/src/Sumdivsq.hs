module Sumdivsq where

import qualified Data.List as L

--module Codewars.G964.Sumdivsq where
listSquared :: Int -> Int -> [(Int, Int)]
listSquared m n = [(x, sum_squared_divisors (x)) | x <- [m .. n], is_special x]

is_special :: Int -> Bool
is_special x = is_square $ sum_squared_divisors x

sum_squared_divisors :: Int -> Int
sum_squared_divisors n = sum $ map square $ divisors n

divisors :: Int -> [Int]
divisors 1 = [1]
divisors n = L.nub $ concatMap (\x -> [x, n `div` x]) lower_half
  where
    check_max = round $ sqrt (fromIntegral n)
    check_list = n : [1 .. check_max]
    lower_half = filter (\x -> n `rem` x == 0) check_list

square :: Int -> Int
square x = x ^ 2

is_square :: (Integral a) => a -> Bool
is_square n = (round . sqrt $ fromIntegral n) ^ 2 == n
