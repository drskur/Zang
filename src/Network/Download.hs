module Network.Download where

import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Simple
import qualified Network.URI as URI
import           Data.List.Split (splitOn)

lastUrlComponent :: String -> String
lastUrlComponent url =
  last $ splitOn "/" url

downloadFile :: String -> String -> IO String
downloadFile url baseDir = do
  response <- httpLBS $ parseRequest_ url
  L8.writeFile filepath (getResponseBody response)
  return filepath
    where filename = lastUrlComponent url
          filepath = baseDir ++ filename
