module Disemvowel
  ( disemvowel
  ) where

import           Data.Char (toLower)

disemvowel :: String -> String
disemvowel xs = filter (not . flip elem vowels . toLower) xs
  where
    vowels = "aeiou"
