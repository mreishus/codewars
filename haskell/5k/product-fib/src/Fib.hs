module Fib where

--module Codewars.Kata.Fib where
-- | Returns a pair of consecutive Fibonacci numbers a b,
--   where (a*b) is equal to the input, or proofs that the
--   number isn't a product of two consecutive Fibonacci
--   numbers.
productFib :: Integer -> (Integer, Integer, Bool)
productFib x = go x 0
  where
    go target n
      | product == target = (fib_n, fib_n1, True)
      | product < target = go target (n + 1)
      | product > target = (fib_n, fib_n1, False)
      where
        fib_n = fibs !! n
        fib_n1 = fibs !! (n + 1)
        product = (*) fib_n fib_n1

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
