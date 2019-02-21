module Roman where

import           Data.List

decodeTable :: [(String, Int)]
decodeTable =
  [ ("M", 1000)
  , ("CM", 900)
  , ("D", 500)
  , ("CD", 400)
  , ("C", 100)
  , ("XC", 90)
  , ("L", 50)
  , ("XL", 40)
  , ("X", 10)
  , ("IX", 9)
  , ("V", 5)
  , ("IV", 4)
  , ("I", 1)
  ]

-- Given a string, look to see if anything in the table given
-- matches the beginning of the string.
lookupPrefix :: Eq a => [a] -> [([a], b)] -> Maybe ([a], b)
lookupPrefix _ [] = Nothing
lookupPrefix target ((x1, x2):xs)
  | x1 `isPrefixOf` target = Just (x1, x2)
  | otherwise = lookupPrefix target xs

solution :: String -> Int
solution xs = solution' xs 0

solution' :: String -> Int -> Int
solution' xs total =
  case lookupPrefix xs decodeTable of
    Just (letters, value) -> solution' (removePre letters xs) (total + value)
    Nothing               -> total

-- RemovePre: Remove a prefix from a string.
removePre :: String -> String -> String
removePre toremovePre xs =
  if toremovePre `isPrefixOf` xs
    then drop (length toremovePre) xs
    else xs
