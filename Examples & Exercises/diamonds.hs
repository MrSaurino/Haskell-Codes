import Data.Char

diamond :: Char -> [String]
diamond c = map (diamondRow c) (['A'..c] ++  reverse ['A'..pred c])

diamondRow :: Char -> Char -> String
diamondRow c x = let spaces = replicate (ord c - ord x) '.' 
                     middleSpaces = replicate (2 * (ord x - ord 'A') - 1) '.'
                 in spaces ++ [x] ++ if x == 'A' then spaces else middleSpaces ++ [x] ++ spaces

main :: IO () 
main = do
  putStrLn "Type a capital letter"
  c <- readLn
  mapM_ putStrLn (diamond c)
