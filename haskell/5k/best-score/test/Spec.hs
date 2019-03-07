import           BestScore       (bestScore)
import           Test.Hspec
import           Test.QuickCheck

main = do
  hspec $ do
    describe "Best Score" $ do
      it "Example Tests" $ do
        bestScore [1, 2, 3] [6, 5] `shouldBe` 3
        bestScore [6, 5] [1, 2, 3] `shouldBe` 0
        bestScore [5, 6, 1] [1, 3, 4] `shouldBe` 2
        bestScore [5, 6, 1] [1, 3, 7, 8] `shouldBe` (-2)
