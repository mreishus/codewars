module SplitStrings where

--module Codewars.Kata.SplitStrings where
solution :: String -> [String]
solution []       = []
solution (a:b:xs) = [[a, b]] ++ solution xs
solution (a:[])   = [[a, '_']]
