import           Foldmap
import           Test.Hspec
import           Test.QuickCheck

main :: IO ()
main =
  hspec $
  describe "Testing Foldmap" $ do
    it "properly implements myToList" $
      property (\l -> myToList l == (l :: [Int]))
    it "properly implements myMinimum" $
      property $ \l ->
        let r = myMinimum (l :: [Int])
         in if null l
              then r == Nothing
              else r == Just (minimum l)
    it "properly implements foldr (and)" $
      property (\l -> myFoldr (&&) True l == and (l :: [Bool]))
    it "properly implements foldr (sum)" $
      property (\l -> myFoldr (+) 0 l == sum (l :: [Int]))
    it "properly implements foldr (++)" $
      property (\l -> myFoldr (++) [] l == concat (l :: [[Int]]))
