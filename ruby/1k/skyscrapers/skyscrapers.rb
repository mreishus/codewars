#!/usr/bin/ruby
#require 'ruby-prof'

SIZE = 7

def solve_puzzle(clues)
  RubyVM::InstructionSequence.compile_option = {
    tailcall_optimization: true,
    trace_instruction: false
  }

  $combs_for_hv = Hash.new
  make_all_combs

  blacklisted_boards = []
  board = solve_boards([empty_board], clues, blacklisted_boards)

  # Clean up, assuming we fixed it
  board.map do |row|
    row.map do |elem|
      elem[0]
    end
  end
end

def solve_boards(boards, clues, blacklisted_boards)
  to_add = []

  boards.each_index do |i|
    next if blacklisted_boards.include?(i)

    c = checksum(boards[i])
    boards[i] = fix_one_round(boards[i], clues, i)
    c2 = checksum(boards[i])

    if invalid_board(boards[i])
      blacklisted_boards.push(i)
    end

    if !fixes_needed(boards[i])
      return boards[i]
    elsif c == c2
      blacklisted_boards.push(i)
      to_add = to_add.concat(split_board(boards[i]))
    end
  end

  solve_boards(boards.concat(to_add), clues, blacklisted_boards)
end

def checksum(board)
  board.flatten.sum
end

def split_board(board_in)
  return_boards = []

  0.upto(SIZE - 1) do |y|
    0.upto(SIZE - 1) do |x|
      next unless board_in[y][x].length > 1
      board_in[y][x].each do |poss_value|
        this_board = deep_copy(board_in)
        this_board[y][x] = [poss_value]
        return_boards.push this_board
      end
      return return_boards
    end
  end
end

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

def fix_one_round(board, clues, board_num)
  cs = parse_clues(board, clues, board_num)
  board = constrain_board(board, cs)
  board = fix_board_rows(board)
  board = fix_board_columns(board)
  board = fix_board_rows(board)
  board = fix_board_columns(board)
  board
end

def fixes_needed(board)
  0.upto(SIZE - 1) do |y|
    0.upto(SIZE - 1) do |x|
      return true if board[y][x].length > 1 || board[y][x] == nil || board[y][x] == []
    end
  end

  return false
end

def invalid_board(board)
  0.upto(SIZE - 1) do |y|
    0.upto(SIZE - 1) do |x|
      return true if board[y][x] == nil || board[y][x] == []
    end
  end

  return false
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
  $all_combs
end

def make_all_combs
  return unless $all_combs == nil
  $all_combs = (1..SIZE).to_a.permutation.to_a.map do |comb|
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


def parse_clues(board, clues, board_num)
  r = clues.map.with_index do |val, idx|
    parse_clue(board, idx, val, board_num)
  end
  r.flatten
end

# See haskell version for docs
# Board -> hintindex -> hintvalue -> [Constraint]
def parse_clue(board, i, hv, board_num) #4.387 - most of which is remove_invalid_combs
  ## Global Var Optimization so we remember which combs we have removed
  comb_key = i.to_s + "_" + hv.to_s + "_" + board_num.to_s
  if ($combs_for_hv[comb_key] == nil)
    combs_pre = combs_for_hint_value(hv) #.3
    $combs_for_hv[comb_key] = remove_invalid_combs(board, i, combs_pre) #3.97
  else
    $combs_for_hv[comb_key] = remove_invalid_combs(board, i, $combs_for_hv[comb_key]) #3.97
  end

  coords = hint_idx_to_coord(i) #nothing

  # [1, 2], [3, 4]
  # [1, 2, 3, 4],  [4, 3, 2, 1], [2, 3, 4, 1]

  coords.map.with_index do |coord, idx|
    possibilities = $combs_for_hv[comb_key].map{ |a|  a[idx] }.uniq
    {x: coord[:x], y: coord[:y], possibilities: possibilities}
  end
end

# Tested via IRB.  See haskell :(
def remove_invalid_combs(board, hi, combs_pre)
  board_view = board_row_from_i(board, hi)

  # Examples of board_view:
  # [[6], [2], [7], [3], [1], [5], [4]]
  # [[5], [3], [1, 2], [1, 2], [6], [4], [7]]
  # [[4], [6], [3], [1, 2, 3], [2], [7], [5]]

  fbv = board_view.flatten
  if fbv.length == SIZE
    return [fbv]
  elsif fbv.length == SIZE * SIZE
    return combs_pre
  end

  combs_pre.select do |c|
    board_view[0].include?( c[0] ) && board_view[1].include?( c[1] ) && board_view[2].include?( c[2] ) && board_view[3].include?( c[3] ) && board_view[4].include?( c[4] ) && board_view[5].include?( c[5] ) && board_view[6].include?( c[6] )
  end

  #pp '---'
  #pp board_view
  #pp '--'

  ##r = combs_pre.select{ |c| validate_comb(board_view, c) }
  ##r
end

# returns true: validate_comb( [ [1,2,3,4], [1,2,3,4], [1,2,3,4], [1,2,3,4] ], [4,3,2,1] )
# (board view can be anthing, so 4, 3, 2, 1 is a valid combo.
# returns false: validate_comb( [ [1], [1,2,3,4], [1,2,3,4], [1,2,3,4] ], [4,3,2,1] )
# (board view, first square must be 1, so 4, 3, 2, 1 is invalid)
def validate_comb(board_view, comb)
  comb.each_with_index do |value, idx|
    return false unless board_view[idx].include?(value)
  end
  true
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

def main
    #actual = solve_puzzle([0,2,3,0,2,0,0, 5,0,4,5,0,4,0, 0,4,2,0,0,0,6, 5,2,2,2,2,4,1]) # for a _very_ hard puzzle, replace the last 7 values with zeroes
    #result = RubyProf.profile do
      actual = solve_puzzle([0,2,3,0,2,0,0, 5,0,4,5,0,4,0, 0,4,2,0,0,0,6, 0,0,0,0,0,0,0]) # for a _very_ hard puzzle, replace the last 7 values with zeroes
      expected = [ [7,6,2,1,5,4,3],
          [1,3,5,4,2,7,6],
          [6,5,4,7,3,2,1],
          [5,1,7,6,4,3,2],
          [4,2,1,3,7,6,5],
          [3,7,6,2,1,5,4],
          [2,4,3,5,6,1,7] ]
      puts "Did it work?"
      pp actual == expected
    #end

    #printer = RubyProf::GraphPrinter.new(result)
    #printer.print(STDOUT, {})
end

#main

