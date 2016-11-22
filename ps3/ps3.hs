-- 1
is_bit :: Int -> Bool
is_bit 0 = True
is_bit 1 = True
is_bit _ = False 

-- 2
flip_bit :: Int -> Int
flip_bit 0 = 1
flip_bit 1 = 0
flip_bit _ = error "x must be 0 or 1"

-- 3a
is_bit_seq1 :: [Int] -> Bool
is_bit_seq1 []          = True
is_bit_seq1 (x:xs)
            | is_bit x  = is_bit_seq1 xs
            | otherwise = False

-- 3b
is_bit_seq2 :: [Int] -> Bool
is_bit_seq2 []     = True
is_bit_seq2 (x:xs) = if is_bit x then is_bit_seq2 xs else False

-- 3c
is_bit_seq3 :: [Int] -> Bool
is_bit_seq3 = all is_bit

-- 4a
invert_bits1 :: [Int] -> [Int]
invert_bits1 []     = []
invert_bits1 (x:xs)
             | x == 0    = 1 : invert_bits1 xs
             | x == 1    = 0 : invert_bits1 xs
             | otherwise = x : invert_bits1 xs

-- 4b
invert_bits2 :: [Int] -> [Int]
invert_bits2 = map (\x -> if x == 0 then 1 else if x == 1 then 0 else x)

-- 4c not done
invert_bits3 :: [Int] -> [Int]
invert_bits3 lst = new
                   where new = [flip_bit n | n <- lst, is_bit n]

-- 5
bit_count :: [Int] -> (Int, Int)
bit_count lst = (length (filter (==0) lst), length (filter (==1) lst))

-- 6 not done
all_bit_seqs :: Int -> [[Int]]
all_bit_seqs n
             | n < 1 = []
             | otherwise = [[1]]











