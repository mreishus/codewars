import           Disemvowel (disemvowel)
import           Test.Hspec

main =
  hspec $ do
    it "should work for single words" $ do
      disemvowel "hat" `shouldBe` "ht"
      disemvowel "toast" `shouldBe` "tst"
    it "should work with spaces" $ do disemvowel "toast hat" `shouldBe` "tst ht"
    it "should preserve case" $ do
      disemvowel "Jumps Over Dog" `shouldBe` "Jmps vr Dg"
--main :: IO ()
--main = putStrLn "Test suite not yet implemented"
