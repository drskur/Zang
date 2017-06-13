module Site.Parse where

import qualified Text.HTML.DOM as HTML
import qualified Data.ByteString.Lazy.Char8 as L8
import qualified Text.XML as XML
import qualified Site.Zangsisi as SiteZangsisi

data ParsableSite = Zangsisi

parseLBS :: L8.ByteString -> XML.Document
parseLBS = HTML.parseLBS

getImageContents :: ParsableSite -> XML.Document -> [String]
getImageContents site = case site of
  Zangsisi -> SiteZangsisi.getImageContents
