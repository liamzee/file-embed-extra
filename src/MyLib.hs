{-# LANGUAGE PatternSynonyms #-}

module MyLib where

import Data.FileEmbed
import Language.Haskell.TH
import Data.Traversable

pattern (:=) key value = (key, value)
infixr 0 :=

type Binding = String

embedBindingFilePath :: (Binding, FilePath) -> Q Dec
embedBindingFilePath (!defName, !filePath) = do
    serializedFile <- embedFile filePath
    name <- newName defName
    pure $ FunD name [Clause [] (NormalB serializedFile) []]

embedListBindingFilePath :: [(Binding, FilePath)] -> Q [Dec]
embedListBindingFilePath = traverse embedBindingFilePath

embedBindingFilePathRelativeToProject :: FilePath -> (Binding, FilePath) -> Q Dec
embedBindingFilePathRelativeToProject origin (!defName, !filePath) = do
    serializedFile <- makeRelativeToProject (origin <> filePath) >>= embedFile 
    name <- newName defName
    pure $ FunD name [Clause [] (NormalB serializedFile) []]

embedListBindingFilePathRelativeToProject :: FilePath -> [(Binding, FilePath)] -> Q [Dec]
embedListBindingFilePathRelativeToProject origin
    = traverse (embedBindingFilePathRelativeToProject origin)