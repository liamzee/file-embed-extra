{-# LANGUAGE TemplateHaskell #-}

module THAsset where

import MyLib
import Data.ByteString



$(embedListBindingFilePath [("houllebecq" := "C:\\lidtrace.txt"), ("iceCreamTruck" := "C:\\Users\\Liam\\Desktop\\Haskell Projects\\file-embed-extras\\LICENSE")]  )