{-# LANGUAGE OverloadedStrings #-}

module Hledger.MakeItSo.Reports
    ( generateReports
    ) where

import Turtle
import Prelude hiding (FilePath, putStrLn)
import Hledger.MakeItSo.Types
import Hledger.MakeItSo.Report.Types
import Hledger.MakeItSo.Common
import Control.Concurrent.STM

generateReports :: ReportOptions -> IO ()
generateReports opts = sh (
  do
    ch <- liftIO newTChanIO
    logHandle <- fork $ consoleChannelLoop ch
    (reports, diff) <- time $ liftIO $ generateReports' opts ch
    liftIO $ channelOut ch $ format ("Generated "%d%" reports in "%s) (length reports) $ repr diff
    liftIO $ terminateChannelLoop ch
    wait logHandle
  )

generateReports' :: ReportOptions -> TChan LogMessage -> IO [FilePath]
generateReports' opts ch = do
  logVerbose opts ch "Something will be here Real Soon Now (tm)"
  channelOut ch "Report generation has not been implemented. Yet. https://github.com/apauley/hledger-makeitso/pull/4"
  return []
