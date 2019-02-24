#!/usr/bin/ruby

SIZE = 4

def solve_puzzle(clues)
  board = empty_board
  old_board = []

  while (old_board <=> board) != 0
    old_board = board.clone
    board = fix_one_round(board, clues)
  end

  # Clean up, assuming we fixed it
  board.map do |row|
    row.map do |elem|
      elem[0]
    end
  end
end

def fix_one_round(board, clues)
  cs = parse_clues(board, clues)
  board = constrain_board(board, cs)
  board = fix_board_rows(board)
  board = fix_board_columns(board)
  board
end

###################

def empty_board()
  grid = Array.new(SIZE) { Array.new(SIZE) }

  0.upto(SIZE - 1) do |y|
    0.upto(SIZE - 1) do |x|
      grid[y][x] = (1..SIZE).to_a
    end
  end
  grid
end

# All permutations of 1, 2, 3, 4 with # of visible scrapers added.
# Input: None
# Output:
# [{:comb=>[1, 2, 3, 4], :visible_scrapers=>4}, ... ]
def all_combs
  (1..SIZE).to_a.permutation.to_a.map do |comb|
    {comb: comb, visible_scrapers: visible_scrapers(comb) }
	end
end

# Given a hint value, find all possible combinations for that row.
# Example
# input: combsForHintValue 1  (hv = 1, 1 building is visible)
# output: [[4,3,2,1],[4,2,3,1],[4,1,2,3],[4,2,1,3],[4,1,3,2],[4,3,1,2]]
# (All combos with 1 building visible)
def combs_for_hint_value(hv)
  all_combs = all_combs()
  if hv == 0
    return all_combs.map{ |x| x[:comb] }
  end

  all_combs.select{ |x| x[:visible_scrapers] == hv }.map{ |x| x[:comb] }
end

# Given a row/column like [1, 2, 3, 4], how many scrapers are visible?
# [1, 2, 3, 4] = 4 (See all 4)
# [4, 3, 2, 1] = 1 (4, the tallest, blocks the rest)
# [3, 2, 1, 4] = 2 (See 3 and 4, 2 and 1 are blocked by 3)
def visible_scrapers(heights)
  max = 0
  r = 0
  heights.each do |item|
    if item > max
      r += 1
      max = item
    end
  end
  r
end

# Hint indexes vs X,Y Coordinates
#      0     1        2      3
# 15 [0, 0] [1, 0] [2, 0] [3, 0]  4
# 14 [0, 1] [1, 1] [2, 1] [3, 1]  5
# 13 [0, 2] [1, 2] [2, 2] [3, 2]  6
# 12 [0, 3] [1, 3] [2, 3] [3, 3]  7
#     11      10     9      8
def hint_idx_to_coord(i)
  j = i % SIZE

  if i >= 0 && i < SIZE
    # top
    r = (0..(SIZE-1)).to_a.map{ |a|  {x: j, y: a}   }
  elsif i >= SIZE && i < (SIZE * 2)
    r = (0..(SIZE-1)).to_a.reverse.map{ |a|  {x: a, y: j}   }
  elsif i >= (SIZE * 2) && i < (SIZE * 3)
    r = (0..(SIZE-1)).to_a.reverse.map{ |a|  {x: (SIZE - 1) - j, y: a} }
  else
    r = (0..(SIZE-1)).to_a.map{ |a|  {x: a, y: (SIZE - 1) - j}   }
  end
  r
end

# Given a board and a hint index, look at the board from that direction, return a row
def board_row_from_i(board, i)
  j = i % SIZE

  if i >= 0 && i < SIZE
    r = (board.transpose)[j]
  elsif i >= SIZE && i < (SIZE * 2)
    r = board[j].reverse
  elsif i >= (SIZE * 2) && i < (SIZE * 3)
    r = (board.transpose)[ (SIZE - 1) - j ].reverse
  else
    r = board[ (SIZE - 1) - j ]
  end
  r
end


def parse_clues(board, clues)
  r = clues.map.with_index do |val, idx|
    parse_clue(board, idx, val)
  end
  r.flatten
end

# See haskell version for docs
# Board -> hintindex -> hintvalue -> [Constraint]
def parse_clue(board, i, hv)
  combs_pre = combs_for_hint_value(hv)
  combs = remove_invalid_combs(board, i, combs_pre)
  coords = hint_idx_to_coord(i)

  coords.map.with_index do |coord, idx|
    possibilities = combs.map{ |a|  a[idx] }.uniq
    {x: coord[:x], y: coord[:y], possibilities: possibilities}
  end
end

# Tested via IRB.  See haskell :(
def remove_invalid_combs(board, hi, combs_pre)
  board_view = board_row_from_i(board, hi)
  r = combs_pre.select{ |c| validate_comb(board_view, c) }
  r
end

# returns true: validate_comb( [ [1,2,3,4], [1,2,3,4], [1,2,3,4], [1,2,3,4] ], [4,3,2,1] )
# (board view can be anthing, so 4, 3, 2, 1 is a valid combo.
# returns false: validate_comb( [ [1], [1,2,3,4], [1,2,3,4], [1,2,3,4] ], [4,3,2,1] )
# (board view, first square must be 1, so 4, 3, 2, 1 is invalid)
def validate_comb(board_view, comb)
  truths = comb.map.with_index do |value, idx|
    board_view[idx].include?(value)
  end
  truths.all? {|t| t}
end

def constrain_board(board, constraints)
  constraints.each do |ct|
    x = ct[:x]
    y = ct[:y]
    board[y][x] &= ct[:possibilities]
  end
  board
end

def fix_board_rows(board)
  board.map {|row| fix_row(row) }
end

def fix_board_columns(board)
  b = board.transpose
  b1 = fix_board_rows(b)
  b1.transpose
end

# fix_row([  [1,2], [1,2,3], [4], [1,2] ])
# Should determine that the second cell has to be "3".
def fix_row(row)
  values = (1..SIZE).to_a
  values.each do |v|
    if reducable(row, v)
      row = replace_possible_with_known(row, v)
    end
  end
  row
end

def replace_possible_with_known(row, fix_val)
  row.map do |v|
    r = v
    if v.include?(fix_val)
      r = [fix_val]
    end
    r
  end
end

# Reducable
#irb#1(main):816:0> reducable( [ [1,2], [1,2,3], [4], [1,2] ], 3 )
#=> true
#irb#1(main):817:0> reducable( [ [1,2], [1,2,3], [4], [1,2] ], 4 )
#=> true  -- Debating if this should be true or false
#irb#1(main):818:0> reducable( [ [1,2], [1,2,3], [4], [1,2] ], 2 )
#=> false
#irb#1(main):819:0> reducable( [ [1,2], [1,2,3], [4], [1,2] ], 1 )
#=> false
def reducable(row, x)
  row.select {|values| values.include?(x) }.length == 1
end

