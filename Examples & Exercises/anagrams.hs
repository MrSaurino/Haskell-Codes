module Anagram where

import Data.Char (toLower)
import Data.List (nub, sort)  --Sorts the imports

--Data type definition for the anagram
newtype Anagram = Anagram String deriving (Show, Eq)

--Function that verifies 2 strings for anagrams
checkAnagram :: Anagram -> String -> Bool
checkAnagram (Anagram source) word =
  let sourceList = nub $ map toLower source
      wordList = nub $ map toLower word
  in sort sourceList == sort wordList

--Find anagrams in a list of words
findAnagrams :: Anagram -> [String] -> [String]
findAnagrams source = filter (checkAnagram source)