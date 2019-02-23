--module Haskell.Codewars.Skyscrapers where
module Skyscrapers where

import           Data.Foldable (toList)
import           Data.List     (delete, nub, permutations, transpose)
import           Data.Sequence (fromList, mapWithIndex)

type Clues = [[Int]]

type Puzzle = [[Int]]

data Square
  = Known Int
  | Possible [Int]
  deriving (Show, Eq)

type UnsolvedPuzzle = [[Square]]

-- fixme
solve :: Clues -> Puzzle
solve []    = []
solve clues = convertBoard $ fix emptyBoard clues

convertBoard :: [[Square]] -> Puzzle
convertBoard board = map convertRow board
  where
    convertRow row = map convertSquare row

convertSquare :: Square -> Int
convertSquare (Possible _) = 99
convertSquare (Known x)    = x

emptyBoard :: [[Square]]
emptyBoard = replicate 4 $ replicate 4 sq
  where
    sq = Possible [1, 2, 3, 4]

-- try
myClues :: Clues
myClues = [[2, 2, 1, 3], [2, 2, 3, 1], [1, 2, 2, 3], [3, 2, 1, 3]]

mySolve = fix emptyBoard myClues

fix b clues
  | b == fixedBoard = fixedBoard
  | otherwise = fix fixedBoard clues
  where
    fixedBoard =
      fixBoardCols $ fixBoardRows $ constrainBoard b $ parseClues b clues

-- All permutations of 1, 2, 3, 4, with the number of visible scrapers added.
allCombs :: [([Int], Int)]
allCombs = map (\x -> (x, visibleScrapers x)) $ permutations [1, 2, 3, 4]

-- Given a hint value, find all possible combinations for that row.
-- Example
-- input: combsForHintValue 1  (hv = 1, 1 building is visible)
-- output: [[4,3,2,1],[4,2,3,1],[4,1,2,3],[4,2,1,3],[4,1,3,2],[4,3,1,2]]
-- (All combos with 1 building visible)
combsForHintValue :: Int -> [[Int]]
combsForHintValue 0  = map fst allCombs
combsForHintValue hv = map fst $ filter (\x -> snd x == hv) allCombs

-- Given a row/column like [1, 2, 3, 4], how many scrapers are visible?
-- [1, 2, 3, 4] = 4 (See all 4)
-- [4, 3, 2, 1] = 1 (4, the tallest, blocks the rest)
-- [3, 2, 1, 4] = 2 (See 3 and 4, 2 and 1 are blocked by 3)
visibleScrapers :: [Int] -> Int
visibleScrapers xs' = go xs' 0 0
  where
    go [] _ visible = visible
    go (x:xs) max visible
      | x > max = go xs x (visible + 1)
      | otherwise = go xs max visible

--
-- Hint indexes vs X,Y Coordinates
--      0     1        2      3
-- 15 [0, 0] [1, 0] [2, 0] [3, 0]  4
-- 14 [0, 1] [1, 1] [2, 1] [3, 1]  5
-- 13 [0, 2] [1, 2] [2, 2] [3, 2]  6
-- 12 [0, 3] [1, 3] [2, 3] [3, 3]  7
--     11      10     9      8
--
-- Hmm, I left this as partial.. :(
hintIdx2Coord :: Int -> [(Int, Int)]
hintIdx2Coord i
  | i >= 0 && i <= 3 = [(i, 0), (i, 1), (i, 2), (i, 3)]
  | i >= 4 && i <= 7 = [(3, y), (2, y), (1, y), (0, y)]
  | i >= 8 && i <= 11 = [(z, 3), (z, 2), (z, 1), (z, 0)]
  | i >= 12 && i <= 15 = [(0, z), (1, z), (2, z), (3, z)]
  where
    y = i `mod` 4
    z = 3 - y

-- Given a board and a hint index, look at the board from that direction, return a row
boardRowFromI :: [[a]] -> Int -> [a]
boardRowFromI board i
  | i >= 0 && i <= 3 = transpose board !! i
  | i >= 4 && i <= 7 = reverse $ board !! y
  | i >= 8 && i <= 11 = reverse $ transpose board !! z
  | i >= 12 && i <= 15 = board !! z
  where
    y = i `mod` 4
    z = 3 - y

type Constraint = (Int, Int, [Int])

parseClues :: [[Square]] -> Clues -> [Constraint]
parseClues board clues' = concatMap (parseClue board) clues
  where
    clues = flattenAddIdx clues'

flattenAddIdx :: Clues -> [(Int, Int)]
flattenAddIdx clues = zip [0 ..] (concat clues)

-- parseClue :: (Int, Int) -> [Constraint]
--              (I, HV) -> [Constraint]
-- I have a hint at index I with hint value HV.
-- We would like to transform this into a list of constraints.
--
-- <hintIndex2Coord I> gives a list of coords my hint applies to
--     [(a, b), (c, d), (e, f), (g, h)].
-- <combsForHintValue HV> gives a list of possible values for those.
--     z = [[4,3,2,1],[4,2,3,1],[4,1,2,3],[4,2,1,3],[4,1,3,2],[4,3,1,2]]
-- In this example, we know that (a, b) must be 4.
--   This is because
--      - (a, b) is the first coordinate.
--      - all of the elements of Z have 4 as their first element.
--
-- (c, d) could be 3, 2, or 1.
--     This is because
--        - (c, d) is the second coordinate.
--        - All of the lists in Z have either 3, 2, or 1 in their second element.
--
-- If we were only processing those two, our final output (list of constraints) would
-- be [ (a, b, [4] ),  (c, d, [3, 2, 1] ) ]
-- or:
-- nub $ map (!! 0) z = [4]
-- nub $ map (!! 1) z = [3, 2, 1]
--
-- Constraints are 3-tuples: (x, y, [Possible Values] )
parseClue :: [[Square]] -> (Int, Int) -> [Constraint]
parseClue board (i, hv) =
  mapIL (\i (x, y) -> (x, y, nub $ map (!! i) combs')) coords
  where
    coords = hintIdx2Coord i -- [ (1,0), (1, 1), (1, 2), (1, 3) ]
    combs = combsForHintValue hv -- [ [3,2,1,4], [3,1,2,4] ... ]
    combs' = removeInvalidCombs board i combs

-- boardView [ Known 3, Possible [1, 2, 3], Possible [1, 2] ]
removeInvalidCombs :: [[Square]] -> Int -> [[Int]] -> [[Int]]
removeInvalidCombs board hi combs = filter (validateComb boardView) combs
  where
    boardView = boardRowFromI board hi

--hasPossibleValue :: Int -> Square -> Bool
-- Comb = [4, 2, 1, 3]
-- BoardView = [Known 1, .. ]
validateComb :: [Square] -> [Int] -> Bool
validateComb boardView comb = and truths
  where
    truths = mapIL (\i x -> hasValue x (boardView !! i)) comb

-- mapIL: map w/ index (only works on lists)
mapIL :: (Int -> a -> b) -> [a] -> [b]
mapIL f l = toList $ mapWithIndex f $ fromList l

-- Apply list of constraints to a board
constrainBoard :: [[Square]] -> [Constraint] -> [[Square]]
constrainBoard board cs = foldl constrainBoard1 board cs

-- Apply 1 constraint to a board
constrainBoard1 :: [[Square]] -> Constraint -> [[Square]]
constrainBoard1 board c@(x, y, _) = updateBoard board x y sq'
  where
    sq = board !! y !! x
    sq' = constrainSquare sq c

-- Apply 1 contraint to a Square
constrainSquare :: Square -> Constraint -> Square
constrainSquare (Known answer) _ = Known answer
constrainSquare (Possible answers) (_, _, possible) =
  case length newanswers of
    1 -> Known (head newanswers)
    _ -> Possible newanswers
  where
    newanswers = intersectL answers possible

-- Replace one square in a board.
updateBoard :: [[Square]] -> Int -> Int -> Square -> [[Square]]
updateBoard board x y newsq = replaceNth y row board
  where
    row = replaceNth x newsq (board !! y)

-- Ok, we also want to use
fixBoardRows :: [[Square]] -> [[Square]]
fixBoardRows board = map fixRow board

fixBoardCols :: [[Square]] -> [[Square]]
fixBoardCols board = transpose $ map fixRow (transpose board)

-- We are bypassing the constraint mechanism and simply fixing the rows individually.
fixRow :: [Square] -> [Square]
fixRow row = foldl fixRowNum row [1, 2, 3, 4]

--constrainBoard board cs = foldl constrainBoard1 board cs
fixRowNum :: [Square] -> Int -> [Square]
fixRowNum row x =
  case reducable row x of
    True  -> replacePossibleWithKnown row x
    False -> row

replacePossibleWithKnown :: [Square] -> Int -> [Square]
replacePossibleWithKnown row x = map fixCell row
  where
    fixCell cell =
      case hasPossibleValue x cell of
        True  -> Known x
        False -> cell

-- Is it possible to reduce this row with value x?
-- For example, say one row of the board is
-- [Possible [1,2],Possible [1,2,3],Known 4,Possible [1,2]]
-- reducable row 3 = True
reducable :: [Square] -> Int -> Bool
reducable row x = knownPossibleOne && possibleOne
  where
    knownPossibleOne = length (filter (hasValue x) row) == 1
    possibleOne = length (filter (hasPossibleValue x) row) == 1

-- HasValue x.  Does Square = Known x || Possible [..contains..x] ?
hasValue :: Int -> Square -> Bool
hasValue x (Known y)       = x == y
hasValue x (Possible list) = elem x list

-- HasPossibleValue x.  Does Square = Possible [..contains..x] ?  Known X doesn't count.
hasPossibleValue :: Int -> Square -> Bool
hasPossibleValue _ (Known _)       = False
hasPossibleValue x (Possible list) = elem x list

-- Dumb functions to update something in a list
-- Since I'm using a list of lists instead of an actual Matrix
modifyNth :: Int -> (a -> a) -> [a] -> [a]
modifyNth _ _ [] = []
modifyNth n f (x:xs)
  | n == 0 = f x : xs
  | otherwise = x : modifyNth (n - 1) f xs

replaceNth :: Int -> a -> [a] -> [a]
replaceNth n newVal = modifyNth n (const newVal)

-- Intersection of two lists
intersectL :: Eq a => [a] -> [a] -> [a]
intersectL [] _ = []
intersectL (x:xs) ys
  | x `elem` ys = x : intersectL xs (delete x ys)
  | otherwise = intersectL xs ys
