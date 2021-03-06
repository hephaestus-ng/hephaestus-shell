{-# LANGUAGE TemplateHaskell #-}

module Types.State where

import Control.Lens

import Data.FM.Types
import Data.Assets
import Data.SPL
import Data.Tree
import Data.Tree.Lens


data Env =
  Env {
    _asset   :: Maybe String,

    -- SPL configs
    _fm      :: Maybe FeatureModel,
    _ck      :: Maybe (ConfigurationKnowledge ComponentModel),
    _pc      :: Maybe ProductConfiguration,
    _ab      :: Maybe ComponentModel,

    -- Build configs
    _prdct   :: Maybe (Product ComponentModel),
    _src     :: Maybe String,
    _target  :: Maybe String
  }
makeClassy ''Env



instance Show Env where
  show (Env (Just as) (Just fm) _ (Just pc) _ _ _ _)
    = "Env loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv loaded with Asset: " ++ show as ++
      "\nEnv loaded with Product Configuration: " ++ show pc

  show (Env _ (Just fm) (Just ck) _ (Just ab) _ _ _)
    = "Env loaded with Asset Base: " ++ show ab ++
      "\nEnv loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv  loaded with Configuration Knowledge "

  show (Env _ (Just fm) (Just ck) (Just pc) (Just ab) _ _ _)
    = "Env loaded with Asset Base: " ++ show ab ++
      "\nEnv loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv loaded with Product Configuration: " ++ show pc ++
      "\nEnv  loaded with Configuration Knowledge "

  show (Env (Just as) _ _ _ _ _ _ _)
    = "Env loaded with Asset: " ++ show as ++
      "\nEnv not loaded with Feature Model \n" ++
      "Env not loaded with Configuration Knowledge \n"

  show (Env _ (Just fm) (Just ck) (Just pc) _ _ _ _)
    = "Env loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv loaded with Product Configuration: " ++ show pc ++
      "\nEnv  loaded with Configuration Knowledge "

  show (Env _ (Just fm) (Just ck) (Just pc) (Just ab) _ _ _)
    = "Env loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv loaded with Product Configuration: " ++ show pc ++
      "\nEnv loaded with Asset Base: " ++ show ab ++
      "\nEnv  loaded with Configuration Knowledge "

  show (Env _ (Just fm) (Just ck) _ _ _ _ _)
    = "Env loaded with Feature Model: " ++ show (view name $ view root $ view featureTree fm) ++
      "\nEnv  loaded with Configuration Knowledge "

  show (Env _ _ _ _ _ _ _ _)
    = show "Environment is not configured"

  show (Env _ _ _ _ (Just ab) _ _ _)
    = "Env loaded with Asset Base: " ++ show ab ++
      "\nEnv not loaded with Feature Model \n" ++
      "Env not loaded with Configuration Knowledge \n" ++
      "Env not loaded with Product Configuration \n"
