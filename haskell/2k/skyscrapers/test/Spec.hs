import           Skyscrapers
import           Test.Hspec

import           Data.List   (transpose)

clue1 =
  [ [3, 2, 2, 3, 2, 1]
  , [1, 2, 3, 3, 2, 2]
  , [5, 1, 2, 2, 4, 3]
  , [3, 2, 1, 2, 2, 4]
  ]

expected1 =
  [ [2, 1, 4, 3, 5, 6]
  , [1, 6, 3, 2, 4, 5]
  , [4, 3, 6, 5, 1, 2]
  , [6, 5, 2, 1, 3, 4]
  , [5, 4, 1, 6, 2, 3]
  , [3, 2, 5, 4, 6, 1]
  ]

clue2 =
  [ [0, 0, 0, 2, 2, 0]
  , [0, 0, 0, 6, 3, 0]
  , [0, 4, 0, 0, 0, 0]
  , [4, 4, 0, 3, 0, 0]
  ]

expected2 =
  [ [5, 6, 1, 4, 3, 2]
  , [4, 1, 3, 2, 6, 5]
  , [2, 3, 6, 1, 5, 4]
  , [6, 5, 4, 3, 2, 1]
  , [1, 2, 5, 6, 4, 3]
  , [3, 4, 2, 5, 1, 6]
  ]

clue3 =
  [ [0, 3, 0, 5, 3, 4]
  , [0, 0, 0, 0, 0, 1]
  , [0, 3, 0, 3, 2, 3]
  , [3, 2, 0, 3, 1, 0]
  ]

expected3 =
  [ [5, 2, 6, 1, 4, 3]
  , [6, 4, 3, 2, 5, 1]
  , [3, 1, 5, 4, 6, 2]
  , [2, 6, 1, 5, 3, 4]
  , [4, 3, 2, 6, 1, 5]
  , [1, 5, 4, 3, 2, 6]
  ]

clue4 =
  [ [4, 3, 2, 5, 1, 5]
  , [2, 2, 2, 2, 3, 1]
  , [1, 3, 2, 3, 3, 3]
  , [5, 4, 1, 2, 3, 4]
  ]

expected4 =
  [ [3, 4, 5, 1, 6, 2]
  , [4, 5, 6, 2, 1, 3]
  , [5, 6, 1, 3, 2, 4]
  , [6, 1, 2, 4, 3, 5]
  , [2, 3, 4, 6, 5, 1]
  , [1, 2, 3, 5, 4, 6]
  ]

clues :: [Clues]
clues = [clue1, clue2, clue3, clue4]

outcomes :: [Puzzle]
outcomes = [expected1, expected2, expected3, expected4]

clue_turn :: Clues -> [Clues]
clue_turn clues = take (length clues) (iterate shift clues)
  where
    shift (x:xs) = xs ++ [x]

clues_turn :: [Clues] -> [Clues]
clues_turn = concatMap clue_turn

puzzle_turn :: Puzzle -> [Puzzle]
puzzle_turn = take 4 . iterate (reverse . transpose)

puzzles_turn :: [Puzzle] -> [Puzzle]
puzzles_turn = concatMap puzzle_turn

main :: IO ()
main =
  hspec $ do
    describe "Testing 6x6 Skyscrapers" $ do
      it "empty code" $ do (solve []) `shouldBe` []
      it "predefined puzzles" $ do (map solve clues) `shouldBe` outcomes
      it "random tests" $ do
        (map solve (clues_turn clues)) `shouldBe` (puzzles_turn outcomes)
