--module Codewars.Kata.Dubstep.Test where
import           Dubstep    (songDecoder)
import           Test.Hspec

main =
  hspec $ do
    describe "songDecoder" $ do
      it "should work for some examples" $ do
        songDecoder "AWUBBWUBC" `shouldBe` "A B C"
        songDecoder "AWUBWUBWUBBWUBWUBWUBC" `shouldBe` "A B C"
        songDecoder "WUBAWUBBWUBCWUB" `shouldBe` "A B C"
        songDecoder "WUBWEWUBAREWUBWUBTHEWUBCHAMPIONSWUBMYWUBFRIENDWUB" `shouldBe`
          "WE ARE THE CHAMPIONS MY FRIEND"
        songDecoder
          "NEVERWUBWUBGONNAWUBGIVEWUBWUBYOUWUBWUBUPWUBWUBNEVERWUBWUBWUBWUBGONNAWUBWUBLETWUBWUBYOUWUBWUBDOWN" `shouldBe`
          "NEVER GONNA GIVE YOU UP NEVER GONNA LET YOU DOWN"
