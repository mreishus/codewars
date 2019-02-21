module Dubstep where

import           Data.Char
import           Data.List

--module Codewars.Kata.Dubstep where
songDecoder :: String -> String
songDecoder xs = trim $ compressSpace $ replace "WUB" " " xs

compressSpace :: String -> String
compressSpace xs
  | compressed == xs = compressed
  | otherwise = compressSpace compressed
  where
    compressed = replace "  " " " xs

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

replace :: String -> String -> String -> String
replace search replacement [] = []
replace search replacement str@(x:xs)
  | search `isPrefixOf` str =
    replacement ++ replace search replacement (drop (length search) str)
  | otherwise = x : replace search replacement xs
