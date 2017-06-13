module Site.Parse where

import qualified Data.ByteString.Lazy.Char8 as L8
import           Data.Text
import qualified Site.Zangsisi              as SiteZangsisi
import qualified Text.HTML.DOM              as HTML
import qualified Text.XML                   as XML

data ParsableSite = Zangsisi

parseLBS :: L8.ByteString -> XML.Document
parseLBS = HTML.parseLBS

getImageContents :: ParsableSite -> XML.Document -> [String]
getImageContents site = case site of
  Zangsisi -> SiteZangsisi.getImageContents

getImageTitle :: ParsableSite -> XML.Document -> String
getImageTitle site = case site of
  Zangsisi -> SiteZangsisi.getImageTitle
