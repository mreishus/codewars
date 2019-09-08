#!/usr/bin/env ruby
require 'pp'

NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3

WHITE = 1 
BLACK = 0

def ant(grid, column, row, n, dir=NORTH)
  #puts "Starting grid"
  #puts grid.inspect
  #puts "column #{column} row #{row} dir #{dir}"
  #puts " "
  while (n > 0) do
    this_color = grid[row][column] 

    if this_color == BLACK
      dir = turn_left(dir)
    elsif this_color == WHITE
      dir = turn_right(dir)
    end

    grid[row][column] = inverse_color(this_color)
    grid, column, row = move(grid, column, row, dir)
    #puts "Grid after moving"
    #puts grid.inspect
    #puts "column #{column} row #{row} dir #{dir}"
    #puts " "
    n -= 1
  end
  grid
end

def move(grid, column, row, dir)
  if dir == NORTH
    if (row - 1 < 0)
      grid = expand(grid, dir)
      row += 1
    end
    return grid, column, row - 1
  elsif dir == SOUTH
    if (row + 1 >= grid.length)
      grid = expand(grid, dir)
    end
    return grid, column, row + 1
  elsif dir == EAST
    if (column + 1 >= grid[0].length)
      grid = expand(grid, dir)
    end
    return grid, column + 1, row
  elsif dir == WEST
    if (column - 1 < 0)
      grid = expand(grid, dir)
      column += 1
    end
    return grid, column - 1, row
  end
end

def turn_right(dir)
  (dir + 1) % 4
end

def turn_left(dir)
  (dir - 1) % 4
end

def inverse_color(color)
  color == BLACK ? WHITE : BLACK
end

def expand(grid, dir)
  puts "Expanding"
  case dir
  when NORTH
    return expand_north(grid)
  when SOUTH
    return expand_south(grid)
  when EAST
    return expand_east(grid)
  when WEST
    return expand_west(grid)
  end
  raise "Expand: Given invalid direction"
end

def expand_north(grid)
  cols = (grid[0].length) -1
  new_row = Array.new(cols + 1, 0)
  grid.prepend(new_row)
  grid
end

def expand_south(grid)
  cols = (grid[0].length) -1
  new_row = Array.new(cols + 1, 0)
  grid.push(new_row) 
  grid
end

def expand_east(grid)
  rows = grid.length - 1
  cols = (grid[0].length) -1

  0.upto(rows) do |y|
    grid[y].push(0)
  end

  grid
end

def expand_west(grid)
  rows = grid.length - 1
  cols = (grid[0].length) -1

  0.upto(rows) do |y|
    grid[y].prepend(0)
  end

  grid
end


puts "Testing A"
a = ant([[1]], 0, 0, 1, 0)
a_expected =  [[0, 0]]
puts "Testing B"
b = ant([[0]], 0, 0, 1)
b_expected =  [[0, 1]]

puts "Testing C"
c = ant([[1]], 0, 0, 3, 0) 
c_expected = [[0, 1], [0, 1]]

puts "A"
puts a.inspect
puts a_expected.inspect
puts "B"
puts b.inspect
puts b_expected.inspect
puts "C"
puts c.inspect
puts c_expected.inspect
