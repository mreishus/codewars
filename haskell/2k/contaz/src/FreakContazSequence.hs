module FreakContazSequence
  ( freakContazSequence
  , nextContaz
  , stepToTake
  , numToSequence
  , bruteSeqToNum
  , seqToNum
  , seqToNumMulti
  , powersOfThree
  ) where

import           Data.List (find, isPrefixOf)

-- Given a number, provide its list of steps for the contaz sequence.
-- example: numToSequence 1574 = "ddDddUDUddDDD"
numToSequence :: Integer -> String
numToSequence n =
  fmap snd $
  takeWhile ((/= 1) . fst) $
  map (\x -> (x, stepToTake x)) $ iterate nextContaz n

-- Given a number, what is the shorthand for the next step we will take in the contaz sequence?
stepToTake :: Integer -> Char
stepToTake n
  | n `mod` 3 == 0 = 'D'
  | n `mod` 3 == 1 = 'U'
  | n `mod` 3 == 2 = 'd'

-- Given a number, find the next number in the contaz sequence.
nextContaz :: Integer -> Integer
nextContaz n
  | n `mod` 3 == 0 = n `quot` 3
  | n `mod` 3 == 1 = ((4 * n) + 2) `quot` 3
  | n `mod` 3 == 2 = ((2 * n) - 1) `quot` 3

-- MAIN ENTRY POINT.
-- Given a list of steps for the contaz sequence, find the smallest number whose
-- list of steps is a prefix of the steps given.
freakContazSequence :: String -> Int
freakContazSequence xs = fixValue $ seqToNum xs

-- Turn a Just Integer into an Int.
fixValue :: Maybe Integer -> Int
fixValue Nothing  = 0
fixValue (Just x) = fromIntegral x

seqToNum :: String -> Maybe Integer
seqToNum xs
  | l < 4 = bruteSeqToNum xs
  | otherwise = smartSeqToNum xs
  where
    l = length xs

smartSeqToNum :: String -> Maybe Integer
smartSeqToNum xs
  | prevNum == 0 = Nothing
  | otherwise = seqToNumMulti xs (fromIntegral multi) offset
  where
    prevNum = fixValue $ seqToNum $ init xs
    multi = largestPow3Under prevNum
    offset = fromIntegral $ prevNum `mod` multi

powersOfThree :: Num a => [a]
powersOfThree = [3 ^ i | i <- [1 ..]]

largestPow3Under :: (Ord a, Num a) => a -> a
largestPow3Under x = last $ takeWhile (< x) powersOfThree

-- Given a list of steps for the contaz sequence, find the smallest number whose
-- list of steps is a prefix of the steps given.
-- Brute force, quite slow for larger numbers.
bruteSeqToNum :: String -> Maybe Integer
bruteSeqToNum xs = find (\n -> xs `isPrefixOf` (numToSequence n)) range
  where
    range = [1 .. 10 ^ 10]

-- Like bruteSeqToNum, but only searches some numbers.
-- If you provide multi = 9 and offset = 3,
-- it will only search numbers where (num `mod` 9) == 3
seqToNumMulti :: String -> Integer -> Integer -> Maybe Integer
seqToNumMulti xs multi offset =
  find (\n -> xs `isPrefixOf` (numToSequence n)) range
  where
    range = [(i * multi) + offset | i <- [1 .. 10 ^ 7]]
{-
*Main FreakContazSequence Lib> seqToNumMulti "ddDddUDUDUDUddDUUUdd" 2187 1574
Just 1883021696

That worked reasonably quickly.  The key concept is
bruteSeqToNum "ddDddUDUDU" = 8135.   8135 `mod` 2187 = 1574
3^7 = 2187..

We can do 3^8, too = 6561.  So check 8135 `mod` 6561 = 1574
Now run
seqToNumMulti "ddDddUDUDUDUddDUUUdd" 6561 1574
-}
{-
getRange (x:xs)
  | x == 'D' = [i | i <- [1 .. 10 ^ 10], i `mod` 3 == 0]
  | x == 'd' = [i | i <- [1 .. 10 ^ 10], i `mod` 3 == 2]
  | x == 'U' = [i | i <- [1 .. 10 ^ 10], i `mod` 3 == 1]
-}
{-
    Freak Contaz Sequence is another version of Collatz sequence of integers is
    obtained from the starting a(1) in the following way: ``` a(n + 1) = a(n) / 3
    if a(n) is divisible by 3. We shall denote this as a large downward step, "D".

    a(n + 1) = (4 * a(n) + 2) / 3 if a(n) divided by 3 gives a remainder of 1. We
    shall denote this as an upward step, "U".

    a(n + 1) = (2 * a(n) - 1) / 3 if a(n) divided by 3 gives a remainder of 2. We
    shall denote this as a small downward step, "d".```

    The sequence stops when a(k) = 1 for some k.

    Given any integer, we can list out the sequence of steps:

    For instance if a(1) = 231, then the sequence {an} =
    {231,77,51,17,11,7,10,14,9,3,1}corresponds to the steps "DdDddUUdDD".

    Of course, there are other sequences that begin with that same sequence
    "DdDddUUdDD....".

    For example, if a = 1004064, then the sequence is
    "DdDddUUdDDDdUDUUUdDdUUDDDUdDD".

    Your task is to find the smallest positive number N > 1 such that the sequence
    begins with the string s. That is, if s = "DdDddUUdDD", the result should be
    231 instead of 1004064.

    Note: For a(1) = 1, the sequence terminate immediately and the string of length
    0 is returned!  Input/Output

    [input] string s

    a string, corresponds to the steps.

    [output] integer N

    The answer N fits in a integer, 2 <= N <= 10^10.
-}
{-
D
DD
DU
Dd

U  4
UD 4
UU
Ud

d  5
dD 5
dU
dd

"D" - Divisible by 3 = 0
"DD" - Divisble by 9 = 0
(9,"DD"),
(18,"DDd"),
(27,"DDD"),
(36,"DDUDd"),
(45,"DDdD"),
(54,"DDDd"),

"D" - Divisible by 3 = 0
"DU" - mod by 9 = 3
(12,"DUDd"),
(21,"DUUdDD"),
(30,"DUdDD"),
(39,"DUDDd"),
(48,"DUUDUdDD"),
(57,"DUdddUUdDD"),

"D" - Divisible by 3 = 0
"Dd" - mod by 9 = 6
(6,"Dd"),
(15,"DdD"),
(24,"DddD"),
(33,"DdUUdDD"),
(42,"DdDD"),
(51,"DddUUdDD"),
(60,"DdUDDd")]

"U" - Mod by 3 = 1
"Ud" - mod by 9 = 1
(10,"UdDD"),
(19,"UdddUUdDD"),
(28,"UdUUUddDDD"),
(37,"UdDdUUdDD"),
(46,"UddDDD"),
(55,"UdUDUDUdDD"),

"U" - Mod by 3 = 1
"UD" - mod by 9 = 4
(13,"UDDd"),
(22,"UDUdDD"),
(31,"UDdDD"),
(40,"UDDDd"),
(49,"UDUDUdDD"),
(58,"UDdddUUdDD"),

"U" - Mod by 3 = 1
"UU" - mod by 9 = 7
(7,"UUdDD"),
(16,"UUDUdDD"),
(25,"UUUddDDD"),
(34,"UUddDDD"),
(43,"UUDdddUUdDD"),
(52,"UUUDDdDD"),

"dD" - mod by 9 = 5
(14,"dDD"),
(23,"dDdD"),
(32,"dDUUdDD"),
(41,"dDDD"),
(50,"dDdUUdDD"),
(59,"dDUDDd"),

"dU" - mod by 9 = 2
(11,"dUUdDD"),
(20,"dUDDd"),
(29,"dUdddUUdDD"),
(38,"dUUUddDDD"),
(47,"dUDdDD"),
(56,"dUdDdUUdDD"),

"dd" - mod by 9 = 8
(8,"ddD"),
(17,"ddUUdDD"),
(26,"dddUUdDD"),
(35,"ddDdD"),
(44,"ddUdddUUdDD"),
(53,"dddDdD"),
-}
