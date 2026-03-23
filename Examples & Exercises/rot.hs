module Rot (Rot,createRot,encode) where

import Data.Char (isLetter,isUpper,toLower,toUpper)
import Data.List (elemIndex)

data Rot = Rot Int [Char] [Char]

rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs 

createRot :: Int -> Rot
createRot count = Rot count plain cipher
 where
  plain = ['a'..'z']
  cipher = rotate count plain

encodeChar :: Rot -> Char -> Char
encodeChar (Rot _ plain cipher) char
 | not (isLetter char) = char
 | isUpper char = toUpper (cipher !! index char)
 | otherwise = cipher !! index char
  where
   index c = case elemIndex (toLower c) plain of
    Just i -> i
    Nothing -> error "The char does not exist in the alphabet"

encode :: Rot -> String -> String
encode cipher str = map (encodeChar cipher) str
  

 