import           Skyscrapers
import           Test.Hspec

clues :: [Clues]
clues =
  [ [[2, 2, 1, 3], [2, 2, 3, 1], [1, 2, 2, 3], [3, 2, 1, 3]]
  , [[0, 0, 1, 2], [0, 2, 0, 0], [0, 3, 0, 0], [0, 1, 0, 0]]
  ]

outcomes :: [Puzzle]
outcomes =
  [ [[1, 3, 4, 2], [4, 2, 1, 3], [3, 4, 2, 1], [2, 1, 3, 4]]
  , [[2, 1, 4, 3], [3, 4, 1, 2], [4, 2, 3, 1], [1, 3, 2, 4]]
  ]

main :: IO ()
main =
  hspec $ do
    describe "Testing 4x4 Skyscrapers" $ do
      it "empty code" $ do (solve []) `shouldBe` []
      it "predefined puzzles" $ do (map solve clues) `shouldBe` outcomes
{-

[Possible [1,2],Known 3,Known 4,Possible [1,2]]
[Known 4,Possible [1,2],Possible [1,2],Known 3]
[Known 3,Known 4,Possible [1,2],Possible [1,2]]
[Possible [1,2],Possible [1,2,3],Known 3,Known 4]

     .    .     .     .
     2    2     1    3

3.  1,2   3     4   1,2    2  .
1.   4   1,2   1,2   3     2  .
2.   3    4    1,2  1,2    3  we can infer, because 4... FUCK :)
3?  1,2  1,2,3  3    4     1  .

     3     2      2      1
     .     .      .      .
-}
