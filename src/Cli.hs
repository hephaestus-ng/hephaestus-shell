{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

-- extension used for deriving instances to hephaestus type

module Cli where

import Error
import Config
import Parser
-- import Shell


import Control.Monad.Reader
import Control.Monad.Except
import Control.Lens


hcfg     = HephConfig "asset-path" "fm-path" "ck-path"

splerr   = FeatureModelErr "invalid feature model"
asseterr = ParserTErr "invalid path"

herr     = HephSPLError splerr


type Command = String


-- Type class definitions
class Monad m => MonadLog m where
  shLog :: String -> m ()

class Monad m => MonadShell m where
  getCommand    :: m Command
  handleCommand :: Command -> m ()


-- Monadic operations behaviour when composing MonadShell with IO
instance MonadShell IO where
  getCommand   = getLine
  handleCommand c = putStrLn c


instance MonadLog IO where
  shLog c = putStrLn c


shell :: (MonadShell m, MonadIO m, MonadLog m)
         => m ()
shell = do
  cmd <- getCommand
  shLog ("running command " ++ cmd)
  handleCommand cmd
  shell

shell2 :: Hephaestus ()
shell2 = do
  cmd <- liftIO $ getLine
  liftIO $ putStrLn ("running command " ++ cmd)
  -- handleCommand cmd
  shell2
-- readConfig :: (MonadReader HephConfig m, MonadIO m) => m ()
-- readConfig = do
--   cfg <- ask
--   liftIO $ putStrLn (view assetConfig cfg)
--
--
-- modifyConfig :: (MonadHephConfig m) => String -> m ()
-- modifyConfig s = do
--   modifyAssetCfg s
--
--
-- main :: (MonadIO m) => m ()
-- main = do
--   runReaderT (readConfig) hcfg




newtype Hephaestus a =
  Hephaestus {
    appHeph :: ReaderT HephConfig IO a
    -- appHeph :: ReaderT HephConfig (ExceptT HephError IO) a
  } deriving (
    Functor, Applicative, Monad,
    MonadReader HephConfig,
    MonadIO
  )

main :: Hephaestus ()
main = undefined
