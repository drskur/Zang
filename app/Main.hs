module Main where

import qualified Codec.Archive.Zip    as Zip
import qualified Data.ByteString.Lazy as BL
import qualified Network.Download     as DL
import qualified Site.Parse           as Site
import           System.Directory     (createDirectory, removePathForcibly)
import           System.Environment   (getArgs)
import           Text.Printf          (printf)

main :: IO ()
main = do
  args <- getArgs
  page <- DL.fetchPage $ head args

  let doc = Site.parseLBS page
      imgs = Site.getImageContents Site.Zangsisi doc
      title = Site.getImageTitle Site.Zangsisi doc
      indexImgs = zip [0..] imgs :: [(Int, String)]

  removePathForcibly title
  createDirectory title

  print title

  sequence_ $ map (\(i, url) -> DL.downloadFile url (mkFilename title i)) indexImgs

mkFilename :: String -> Int -> FilePath
mkFilename dir i =
  dir ++ printf "/%03d.jpg" i

mkZip_ :: [FilePath] -> FilePath -> IO ()
mkZip_ paths target = do
  archive <- Zip.addFilesToArchive
    [ Zip.OptVerbose
    , Zip.OptRecursive
    , Zip.OptLocation "temp" True ] Zip.emptyArchive ["temp"]
  BL.writeFile target $ Zip.fromArchive archive
