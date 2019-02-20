module Codewars.G964.Printer where

printerError :: [Char] -> [Char]
printerError a = show errors ++ "/" ++ show total
  where
    errors = length $ filter (not . flip elem ['a' .. 'm']) a
    total = length a
