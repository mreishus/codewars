import           MultiplesOf3And5
import           Test.Hspec
import           Test.QuickCheck

main =
  hspec $ do
    describe "solution" $ do it "testing 10" $ (solution 10) `shouldBe` 23
