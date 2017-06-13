module Main where

import qualified Network.Download   as DL
import qualified Site.Parse         as Site
import           System.Directory   (createDirectory, removePathForcibly)
import           System.Environment (getArgs)
import           Text.Printf        (printf)

main :: IO ()
main = do
  args <- getArgs
  page <- DL.fetchPage $ head args

  let doc = Site.parseLBS page
      imgs = Site.getImageContents Site.Zangsisi doc
      indexImgs = zip [0..] imgs :: [(Int, String)]
      dir = "temp"

  removePathForcibly dir
  createDirectory dir

  sequence_ $ map (\(i, url) -> DL.downloadFile url (mkFilename dir i)) indexImgs

mkFilename :: String -> Int -> String
mkFilename dir i =
  dir ++ printf "/%03d.jpg" i
