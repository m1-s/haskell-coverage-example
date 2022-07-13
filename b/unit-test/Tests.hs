import           B
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "one" $ it "works" $ add 1 1 `shouldBe` 2
