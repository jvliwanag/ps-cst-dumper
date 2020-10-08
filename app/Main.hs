{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE LambdaCase #-}

module Main where

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Language.PureScript.CST (parseFromFile)
import System.Environment (getArgs)
import Text.Show.Pretty (pPrint)
import qualified Data.Text.IO as TextIO

main :: IO ()
main = do
  Target { tgFilepath, tgText } <- getTarget
  case parseFromFile tgFilepath tgText of
    Right r ->
      pPrint r
    Left e ->
      pPrint e

data Target =
  Target { tgFilepath :: FilePath
         , tgText :: Text
         }

getTarget :: IO Target
getTarget = getArgs >>= \case
  tgFilepath : _ -> do
    tgText <- TextIO.readFile tgFilepath
    pure $ Target { tgFilepath, tgText }
  _ -> do
    tgText <- TextIO.getContents
    pure $ Target { tgFilepath = "stdin", tgText }
