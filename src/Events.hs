{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Events where

import           Data.Text (Text, pack)
import           Data.Aeson
import           GHC.Generics

data Event = Event
  { event :: Text
  , message :: Text
  } deriving (Generic, Show)

data FromEvent = FromEvent
  { event :: Text
  , message :: Value
  } deriving Show

instance FromJSON FromEvent where
  parseJSON (Object o) =
      FromEvent <$> o .: "event" <*> (o .: "message")
  parseJSON _ = error "fail"

instance ToJSON Event where
  toEncoding = genericToEncoding defaultOptions