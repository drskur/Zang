{-# LANGUAGE OverloadedStrings #-}

module Site.Zangsisi where

import qualified Data.Text       as T
import           Text.XML
import           Text.XML.Cursor

-- import Network.Download
-- import qualified Text.HTML.DOM as HTML
-- import qualified Data.ByteString.Lazy.Char8 as L8

-- aaa :: IO ()
-- aaa = do
--   p <- fetchPage "http://zangsisi.net?p=118855"

--   let doc = HTML.parseLBS p
--       cursor = fromDocument doc
--   print $ cursor $// findNodes &| (T.unpack . T.concat . attribute "src")

getImageContents :: Document -> [String]
getImageContents doc =
  cursor $// findNodes &| (T.unpack . T.concat . attribute "src")
  where cursor = fromDocument doc

getImageTitle :: Document -> String
getImageTitle doc =
  head $ cursor $// findTitleNodes &| (T.unpack . T.concat . content)
  where cursor = fromDocument doc

findTitleNodes :: Cursor -> [Cursor]
findTitleNodes = attributeIs "id" "post" &/ attributeIs "class" "title" >=> child

findNodes :: Cursor -> [Cursor]
findNodes =
  attributeIs "id" "post" &/
  attributeIs "class" "contents" &//
  element "img"


