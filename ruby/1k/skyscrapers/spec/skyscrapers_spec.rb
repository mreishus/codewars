# TODO: Replace examples and use TDD development by writing your own tests
# These are some of the methods available:
#   Test.expect(boolean, [optional] message)
#   Test.assert_equals(actual, expected, [optional] message)
#   Test.assert_not_equals(actual, expected, [optional] message)

require_relative '../skyscrapers'
require 'spec_helper'

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
