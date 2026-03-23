import Data.Char(isAlpha, isLower, isUpper, ord,chr)

atbash :: String -> String
atbash = map (\c -> if isAlpha c then volteado c else c)
  where
    volteado c
      | isLower c = chr $ ord 'z' - (ord c - ord 'a')
      | isUpper c = chr $ ord 'Z' - (ord c - ord 'A')