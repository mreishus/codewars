import           Roman
import           Test.Hspec
import           Test.QuickCheck

main =
  hspec $ do
    describe "solution" $ do
      it "testing 'XXI'" $ shouldBe (solution "XXI") 21
      it "testing 'I'" $ shouldBe (solution "I") 1
      it "testing 'IV'" $ shouldBe (solution "IV") 4
      it "testing 'MMVIII'" $ shouldBe (solution "MMVIII") 2008
      it "testing 'MDCLXVI'" $ shouldBe (solution "MDCLXVI") 1666
