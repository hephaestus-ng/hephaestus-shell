{-# LANGUAGE TemplateHaskell #-}

module Types.State where

import Control.Lens

import Data.FM.Types
import Data.SC.Types
import Data.SC.Asset
import Data.SPL
import Data.Tree
import Data.Tree.Lens


data Env =
  Env {
    _asset  :: Maybe String,
    _fm     :: Maybe FeatureModel,
    _ck     :: Maybe (ConfigurationKnowledge ComponentModel),
    _pc     :: Maybe ProductConfiguration,
    _src    :: Maybe String,
    _target :: Maybe String 
  }
makeClassy ''Env


-- instance Show (ConfigurationKnowledge ComponentModel) where
--   show ck = show "ck"


instance Show Env where
  show (Env (Just as) (Just fm) _ _ _ _)
    = "Env loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv loaded with Asset: " ++ show as
      -- "Env loaded with Configuration Knowledge: " ++ show ck

  show (Env (Just as) Nothing _ _ _ _)
    = "Env loaded with Asset: " ++ show as ++
      "\nEnv not loaded with Feature Model \n" ++
      "Env not loaded with Configuration Knowledge \n"

  show (Env Nothing (Just fm) _ _ _ _)
    = "Env loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv not loaded with Asset \n" ++
      "Env not loaded with Configuration Knowledge \n"

  show (Env Nothing Nothing _ _ _ _)
    = show "Environment is not configured"
