data Bit = Zero | One
    deriving (Show, Eq)

-- 1
flipBit :: Bit -> Bit
flipBit Zero = One
flipBit One  = Zero

-- 2
invert :: [Bit] -> [Bit]
invert = map flipBit

-- 3
all_bit_seqs :: Int -> [[Bit]]
all_bit_seqs n = sequence $ replicate n [Zero, One]

-- 4
bitSum1 :: [Bit] -> Int
bitSum1 = length . filter (==One)

-- 5
bitSum2 :: [Maybe Bit] -> Int
bitSum2 = length . filter (==Just One)

data List a = Empty | Cons a (List a)
    deriving Show

-- 6
toList :: [a] -> List a
toList = foldr (\x y -> Cons x y) Empty

-- 7
toHaskellList :: List a -> [a]
toHaskellList Empty             = []
toHaskellList (Cons first rest) = first : toHaskellList rest

-- 8
append :: List a -> List a -> List a
append Empty y             = y
append (Cons first rest) y = Cons first (append rest y)

-- 9
removeAll :: (a -> Bool) -> List a -> List a
removeAll _ Empty             = Empty
removeAll f (Cons first rest) = if f first then removeAll f rest else Cons first (removeAll f rest)

-- 10
-- merge L1 L2 will merge 2 sorted lists L1 and L2
merge :: Ord a => List a -> List a -> List a
merge Empty (Cons first rest) = Cons first rest
merge (Cons first rest) Empty = Cons first rest
merge (Cons first1 rest1) (Cons first2 rest2)
      | first1 < first2       = Cons first1 (merge rest1 (Cons first2 rest2))
      | otherwise             = Cons first2 (merge (Cons first1 rest1) rest2)

-- len L will return length of list L
len :: Ord a => List a -> Int
len Empty         = 0
len (Cons _ rest) = 1 + len rest

-- split L i n will make a sublist of L starting at index i and containing n (if there are n) elements
split :: Ord a => List a -> Int -> Int -> List a
split Empty _ _             = Empty
split (Cons _ _) _ 0        = Empty
split (Cons first rest) 0 n = Cons first (split rest 0 (n - 1))
split (Cons _ rest) i n     = split rest (i - 1) n

sort :: Ord a => List a -> List a
sort Empty              = Empty
sort (Cons first Empty) = Cons first Empty
sort (Cons first rest)  = merge (sort left) (sort right)
                          where left  = split (Cons first rest) 0 (len (Cons first rest) `div` 2)
                                right = split (Cons first rest) (len (Cons first rest) `div` 2) (len (Cons first rest))

-- 11
best_partition :: [Int] -> (Int, [Int], [Int])
best_partition = best . partitions

quicksort :: [Int] -> [Int]
quicksort []     = []
quicksort (x:xs) = smalls ++ [x] ++ bigs
                   where smalls = quicksort [n | n <- xs, n < x]
                         bigs   = quicksort [n | n <- xs, n >= x]

-- find the best partition from a list of partitions
best :: [([Int], [Int])] -> (Int, [Int], [Int])
best []                = (maxBound :: Int, [], [])
best ((left,right):xs) = let diff = abs $ sum left - sum right in
                         if bestdiff >= diff then (diff, quicksort left, quicksort right) else (bestdiff, bestleft, bestright)
                         where (bestdiff, bestleft, bestright) = best xs

-- find all partitions of a list
partitions :: [Int] -> [([Int],[Int])]
partitions []     = [([], [])]
partitions (x:xs) = [(x : left, right) | (left, right) <- ps] ++
                    [(left, x : right) | (left, right) <- ps]
                    where ps = partitions xs


