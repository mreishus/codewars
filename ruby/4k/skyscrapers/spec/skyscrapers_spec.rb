# TODO: Replace examples and use TDD development by writing your own tests
# These are some of the methods available:
#   Test.expect(boolean, [optional] message)
#   Test.assert_equals(actual, expected, [optional] message)
#   Test.assert_not_equals(actual, expected, [optional] message)

require_relative '../skyscrapers'
require 'spec_helper'

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

  it "can solve 4x4 puzzle 1" do
    clues    = [ 2, 2, 1, 3,
                 2, 2, 3, 1,
                 1, 2, 2, 3,
                 3, 2, 1, 3 ]

    expected = [ [1, 3, 4, 2],
                 [4, 2, 1, 3],
                 [3, 4, 2, 1],
                 [2, 1, 3, 4] ]

    actual = solve_puzzle(clues)
    expect(actual).to eq(expected)
    #actual.should == expected
    #Test.assert_equals(actual, expected)
  end

  it "can solve 4x4 puzzle 2" do
    clues    = [0, 0, 1, 2,
                0, 2, 0, 0,
                0, 3, 0, 0,
                0, 1, 0, 0]

    expected = [ [2, 1, 4, 3],
                 [3, 4, 1, 2],
                 [4, 2, 3, 1],
                 [1, 3, 2, 4] ]

    actual = solve_puzzle(clues)
    expect(actual).to eq(expected)
    #actual.should == expected
    # Test.assert_equals(actual, expected)
  end
end
