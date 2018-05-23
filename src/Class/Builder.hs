{-# LANGUAGE FlexibleContexts #-}

module Class.Builder where

import Data.Maybe

import Control.Monad.State
import Control.Lens

import Data.FM
import Data.SPL
import Data.Assets

import Types.Hephaestus
import Types.State


class Monad m => MonadBuilder m where

  buildM :: (Asset a) =>
            FeatureModel ->
            ConfigurationKnowledge a ->
            ProductConfiguration ->
            m (Product a)

  exportM :: (Asset a) =>
              Source ->
              Target ->
              Product a ->
              m ()


instance MonadBuilder Hephaestus where
  buildM fm ck pc = do
    let spl = SPL fm ck
    return $ build spl pc

  exportM src trg prod = liftIO $ export src trg prod