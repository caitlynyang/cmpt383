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
invert_bits2 = map (\x -> if is_bit x then flip_bit x else x)

-- 4c
invert_bits3 :: [Int] -> [Int]
invert_bits3 lst = new_lst
                   where new_lst = [if is_bit n then flip_bit n else n | n <- lst]

-- 5
bit_count :: [Int] -> (Int, Int)
bit_count lst = (length $ filter (==0) lst, length $ filter (==1) lst)

-- 6
dec_to_bit_seq :: Int -> Int -> [Int]
dec_to_bit_seq _ 0     = []
dec_to_bit_seq val len = dec_to_bit_seq (val `div` 2) (len - 1) ++ [rem val 2]

all_bit_seqs :: Int -> [[Int]]
all_bit_seqs n
             | n < 1     = []
             | otherwise = map (\x -> dec_to_bit_seq x n) [0..2^n - 1]











