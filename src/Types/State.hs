{-# LANGUAGE TemplateHaskell #-}

module Types.State where

import Control.Lens

import Data.FM.Types
import Data.SPL
import Data.Tree


data FM =
  FM {
    _path     :: String,
    _parsedFM :: FeatureModel
  } deriving (Show)
-- makeClassy ''FM

data Env =
  Env {
    _asset :: String,
    _fm    :: FM,
    _ck    :: String
  } deriving (Show)
-- makeClassy ''Env


fmcfg    = FM "fm-path" (FeatureModel (Node (Feature "iris" BasicFeature Mandatory) []) [])

envv     = Env "asset-path" fmcfg "ck-path"

class HasFM t where
  fmConfig :: Lens' t FM
  path     :: Lens' t String
  parsedFM :: Lens' t FeatureModel

instance HasFM FM where
  fmConfig = id
  path     =
    lens _path (\c a -> c { _path = a })
  parsedFM =
    lens _parsedFM (\c b -> c { _parsedFM = b })

instance HasFM Env where
  fmConfig =
    lens _fm (\env fm -> env { _fm = fm })


class HasEnv t where
  env         :: Lens' t Env
  asset       :: Lens' t String
  fm          :: Lens' t FM
  ck          :: Lens' t String

instance HasEnv Env where
  env   = id
  asset =
    lens _asset (\h a -> h { _asset = a })
  fm    =
    lens _fm (\h b -> h { _fm = b })
  ck    =
    lens _ck (\h c -> h { _ck = c })