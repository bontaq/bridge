module ComponentSpec where

import Test.Hspec

import Component

spec = parallel $ do

  describe "render" $ do

    it "can create a div" $ do
      let element = Html "div" [Text "hello world"]

      render [] element `shouldBe` "<div>hello world</div>"

    it "can add an onclick" $ do
      let element =
            Attribute (OnClick 1)
            $ Html "div" [Text "hello world"]

      render [] element `shouldBe`
        "<div bridge-click=\"click\">hello world</div>"

  describe "apply" $ do
    it "can change state" $ do
      let handler =
            MessageHandler (0 :: Int)
              (\action -> case action of
                  "up" -> 1)
              (\state -> Text (show state))

      render [] (apply "up" handler)
        `shouldBe`
        "1"

      render [] handler
        `shouldBe`
        "0"

main = hspec spec