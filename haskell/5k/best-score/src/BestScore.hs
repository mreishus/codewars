module BestScore
  ( bestScore
  , bestScoreT
  ) where

-- Find the best (score_a - score_b) across all possible thresholds.
bestScore :: [Int] -> [Int] -> Int
bestScore [] [] = 0
bestScore as bs = maximum scores_by_threshold
  where
    scores = as ++ bs
    max = maximum scores + 1
    min = minimum scores - 1
    scores_by_threshold = map (bestScoreT as bs) [min .. max]

-- Calculate (score_a - score_b) for a given threshold
bestScoreT :: [Int] -> [Int] -> Int -> Int
bestScoreT as bs threshold = score_a - score_b
  where
    score_a = score as threshold
    score_b = score bs threshold

-- Calculate one team's score given their distances and threshold.
score :: [Int] -> Int -> Int
score distances threshold = num_3 * 3 + num_2 * 2
  where
    num_3 = length $ filter (threshold <=) distances
    num_2 = length $ filter (not . (threshold <=)) distances
