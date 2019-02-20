module Dups where

import           Control.Monad (liftM2)
import           Data.Map      (Map)

import qualified Data.Char     as C
import qualified Data.Map      as M

duplicateEncode :: String -> String
duplicateEncode xs = map (encode counts) xsLower
  where
    xsLower = map C.toLower xs
    counts = charCount xsLower

encode :: M.Map Char Int -> Char -> Char
encode map input
  | liftM2 (>) count (Just 1) == Just True = ')'
  | otherwise = '('
  where
    count = M.lookup input map

-- Given a string, convert it to a map of character frequency counts
charCount :: String -> M.Map Char Int
charCount = foldl addCharToMap M.empty

-- Build up a map of character frequency counts by adding one character seen.
addCharToMap :: M.Map Char Int -> Char -> M.Map Char Int
addCharToMap aMap x = M.insertWith (+) x 1 aMap
