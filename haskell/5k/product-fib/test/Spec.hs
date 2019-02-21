import           Fib        (productFib)
import           Test.Hspec

--module Codewars.Kata.Fib.Test (main) where
--import Codewars.Kata.Fib (productFib)
main =
  hspec $ do
    describe "productFib" $ do
      it "should work for some examples" $ do
        productFib 4895 `shouldBe` (55, 89, True)
        productFib 5895 `shouldBe` (89, 144, False)
