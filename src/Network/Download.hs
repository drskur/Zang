module Network.Download where

import qualified Data.ByteString.Lazy.Char8 as L8
import           Data.List.Split            (splitOn)
import           Network.HTTP.Simple

lastUrlComponent :: String -> String
lastUrlComponent url =
  last $ splitOn "/" url

downloadFile :: String -> String -> IO String
downloadFile url filepath = do
  putStrLn $ "Downloading " ++ url ++ " to " ++ filepath
  response <- httpLBS $ parseRequest_ url
  L8.writeFile filepath (getResponseBody response)
  return filepath

fetchPage :: String -> IO L8.ByteString
fetchPage url = do
  response <- httpLBS $ parseRequest_ url
  return $ getResponseBody response
