import           Suite2

import           Test.Hspec
import           Text.Printf (printf)

testGame :: Integer -> Either Integer (Integer, Integer) -> Spec
testGame n s = it (printf "should return game") $ game n `shouldBe` s

main =
  hspec $ do
    describe "game" $ do
      testGame 0 (Left 0)
      testGame 1 (Right (1, 2))
      testGame 8 (Left 32)
