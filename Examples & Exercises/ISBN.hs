module IsbnVerifier (isbn) where

import Data.Char (digitToInt)

transl :: Char -> Int
transl 'X' = 10
transl c = digitToInt c

isbn :: String -> Bool
isbn s
  | length f == 10 && valid = mod op 11 == 0
  | otherwise = False
  where f = filter (`elem` "0123456789X") s
        t = map transl f
        valid = all (<10) $ take 9 t
        op = sum $ zipWith (*) t [10,9..1]