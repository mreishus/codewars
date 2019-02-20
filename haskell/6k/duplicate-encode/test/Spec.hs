import           Dups
import           Test.Hspec

spec :: Spec
spec = do
  it "encodes the codes" $ do
    duplicateEncode "din" `shouldBe` "((("
    duplicateEncode "recede" `shouldBe` "()()()"
    duplicateEncode "Success" `shouldBe` ")())())"
    duplicateEncode "CodeWarrior" `shouldBe` "()(((())())"
    duplicateEncode "Supralapsarian" `shouldBe` ")()))()))))()("
    duplicateEncode "iiiiii" `shouldBe` "))))))"

-- the following line is optional for 8.2
main = hspec spec --main :: IO ()
--main = putStrLn "Test suite not yet implemented"
