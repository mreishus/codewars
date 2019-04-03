import           FreakContazSequence (freakContazSequence)
import           Test.Hspec

spec :: Spec
spec = do
  it "Example Tests" $ do
    freakContazSequence "d" `shouldBe` 2
    freakContazSequence "D" `shouldBe` 3
    freakContazSequence "U" `shouldBe` 4
    freakContazSequence "dU" `shouldBe` 11
    freakContazSequence "DU" `shouldBe` 12
    freakContazSequence "DdU" `shouldBe` 33
    freakContazSequence "DdDddUUdDD" `shouldBe` 231
    freakContazSequence "UddUDUD" `shouldBe` 1450
    freakContazSequence "UDdDDUd" `shouldBe` 2218
    freakContazSequence "UDUDUDUddDUUUdd" `shouldBe` 9193711
    freakContazSequence "ddDddUDUDUDUddDUUUdd" `shouldBe` 1883021696

main = hspec spec
