# TODO: Replace examples and use TDD development by writing your own tests
# These are some of the methods available:
#   Test.expect(boolean, [optional] message)
#   Test.assert_equals(actual, expected, [optional] message)
#   Test.assert_not_equals(actual, expected, [optional] message)

require_relative '../skyscrapers'
require 'spec_helper'

describe "split_board" do
  it "split1" do
    input = [[[1, 2], [1, 3], [1, 2, 3, 4, 5], [7], [6], [4, 5], [3, 4]], [[6], [4], [7], [1, 2, 3, 5], [1, 2, 5], [1, 2], [2, 3]], [[1, 2], [2, 3], [3, 4], [6], [1, 2, 3, 4], [7], [5]], [[5], [7], [6], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 4], [1, 2, 3]], [[3, 4], [1, 2, 3], [3, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [6], [7]], [[7], [6], [2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [3, 5], [1, 2, 3, 4]], [[3, 4], [5], [1, 2], [1, 2, 3, 4], [7], [1, 2, 3], [6]]]
    output_board_1 = [[[1], [1, 3], [1, 2, 3, 4, 5], [7], [6], [4, 5], [3, 4]], [[6], [4], [7], [1, 2, 3, 5], [1, 2, 5], [1, 2], [2, 3]], [[1, 2], [2, 3], [3, 4], [6], [1, 2, 3, 4], [7], [5]], [[5], [7], [6], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 4], [1, 2, 3]], [[3, 4], [1, 2, 3], [3, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [6], [7]], [[7], [6], [2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [3, 5], [1, 2, 3, 4]], [[3, 4], [5], [1, 2], [1, 2, 3, 4], [7], [1, 2, 3], [6]]]
    output_board_2 = [[[2], [1, 3], [1, 2, 3, 4, 5], [7], [6], [4, 5], [3, 4]], [[6], [4], [7], [1, 2, 3, 5], [1, 2, 5], [1, 2], [2, 3]], [[1, 2], [2, 3], [3, 4], [6], [1, 2, 3, 4], [7], [5]], [[5], [7], [6], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 4], [1, 2, 3]], [[3, 4], [1, 2, 3], [3, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [6], [7]], [[7], [6], [2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [3, 5], [1, 2, 3, 4]], [[3, 4], [5], [1, 2], [1, 2, 3, 4], [7], [1, 2, 3], [6]]]
    actual = split_board(input)
    expected = [ output_board_1, output_board_2 ]
    expect(actual).to eq(expected)
  end
end

describe "7x7" do
  it "medium" do
    actual = solve_puzzle([7,0,0,0,2,2,3, 0,0,3,0,0,0,0, 3,0,3,0,0,5,0, 0,0,0,0,5,0,4])
    expected = [ [1,5,6,7,4,3,2],
        [2,7,4,5,3,1,6],
        [3,4,5,6,7,2,1],
        [4,6,3,1,2,7,5],
        [5,3,1,2,6,4,7],
        [6,2,7,3,1,5,4],
        [7,1,2,4,5,6,3] ]
    expect(actual).to eq(expected)
  end

  it "very hard" do
    actual = solve_puzzle([0,2,3,0,2,0,0, 5,0,4,5,0,4,0, 0,4,2,0,0,0,6, 5,2,2,2,2,4,1]) # for a _very_ hard puzzle, replace the last 7 values with zeroes
    expected = [ [7,6,2,1,5,4,3],
        [1,3,5,4,2,7,6],
        [6,5,4,7,3,2,1],
        [5,1,7,6,4,3,2],
        [4,2,1,3,7,6,5],
        [3,7,6,2,1,5,4],
        [2,4,3,5,6,1,7] ]
    expect(actual).to eq(expected)
  end

  it "very very hard" do
    actual = solve_puzzle([0,2,3,0,2,0,0, 5,0,4,5,0,4,0, 0,4,2,0,0,0,6, 5,2,2,0,0,0,0])
    expected = [ [7,6,2,1,5,4,3],
        [1,3,5,4,2,7,6],
        [6,5,4,7,3,2,1],
        [5,1,7,6,4,3,2],
        [4,2,1,3,7,6,5],
        [3,7,6,2,1,5,4],
        [2,4,3,5,6,1,7] ]
    expect(actual).to eq(expected)
  end

  it "another very hard, italics" do
    actual = solve_puzzle([0, 2, 3, 0, 2, 0, 0, 5, 0, 4, 5, 0, 4, 0, 0, 4, 2, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0])
    expected = [[7, 6, 2, 1, 5, 4, 3], [1, 3, 5, 4, 2, 7, 6], [6, 5, 4, 7, 3, 2, 1], [5, 1, 7, 6, 4, 3, 2], [4, 2, 1, 3, 7, 6, 5], [3, 7, 6, 2, 1, 5, 4], [2, 4, 3, 5, 6, 1, 7]]
    expect(actual).to eq(expected)
  end

  it "medved" do
    actual = solve_puzzle( [3, 3, 2, 1, 2, 2, 3, 4, 3, 2, 4, 1, 4, 2, 2, 4, 1, 4, 5, 3, 2, 3, 1, 4, 2, 5, 2, 3])
    expected = [[2, 1, 4, 7, 6, 5, 3], [6, 4, 7, 3, 5, 1, 2], [1, 2, 3, 6, 4, 7, 5], [5, 7, 6, 2, 3, 4, 1], [4, 3, 5, 1, 2, 6, 7], [7, 6, 2, 5, 1, 3, 4],[3, 5, 1, 4, 7, 2, 6]]
    expect(actual).to eq(expected)
=begin
Hi, I tested about 30+ python3 solutions and most of them fail to give correct answer in about 1/3 of puzzles with unique solutions.
I currenty generated 700+ such puzzles (with full clues, but it easy to add some zeros to them), for which I'm statistically (very) sure they are really with only one solution.
One of them is [3,3,2,1,2,2,3,4,3,2,4,1,4,2,2,4,1,4,5,3,2,3,1,4,2,5,2,3], so I ask for somebody to try find more solutions for it and let me know if I'm wrong.
My solution (I hope unique) for this is [[2, 1, 4, 7, 6, 5, 3], [6, 4, 7, 3, 5, 1, 2], [1, 2, 3, 6, 4, 7, 5], [5, 7, 6, 2, 3, 4, 1],
                                         [4, 3, 5, 1, 2, 6, 7], [7, 6, 2, 5, 1, 3, 4],[3, 5, 1, 4, 7, 2, 6]]).

                                         Mine gets stuck here
[[[1, 2], [1, 3], [1, 2, 3, 4, 5], [7], [6], [4, 5], [3, 4]],
 [[6], [4], [7], [1, 2, 3, 5], [1, 2, 5], [1, 2], [2, 3]],
 [[1, 2], [2, 3], [3, 4], [6], [1, 2, 3, 4], [7], [5]],
 [[5], [7], [6], [1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 4], [1, 2, 3]],
 [[3, 4], [1, 2, 3], [3, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [6], [7]],
 [[7], [6], [2, 3, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [3, 5], [1, 2, 3, 4]],
 [[3, 4], [5], [1, 2], [1, 2, 3, 4], [7], [1, 2, 3], [6]]]

=end
  end
end


describe "Skyscrapers" do
  it "visible_scrapers" do
    actual = visible_scrapers [1, 2, 3, 4]
    expected = 4
    expect(actual).to eq(expected)

    actual = visible_scrapers [4, 3, 2, 1]
    expected = 1
    expect(actual).to eq(expected)

    actual = visible_scrapers [3, 2, 1, 4]
    expected = 2
    expect(actual).to eq(expected)
  end
end
