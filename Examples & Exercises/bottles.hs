bottles :: Int -> Int -> String
bottles original n
  | n > 1     = show n ++ " bottles of beer on the wall, " ++ show n ++ " bottles of beer.\nTake one down and pass it around, " ++ show (n-1) ++ " bottles of beer on the wall.\n"
  | n == 1    = "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
  | otherwise = "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, " ++ show original ++ " bottles of beer on the wall.\n"


main :: IO () 
main = do
  putStrLn "Choose bottles quantity:"
  n <- readLn
  let original = n
  mapM_ (putStrLn . bottles original) [n, n-1 .. 0]
