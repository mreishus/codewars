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

  it "can solve 6x6 puzzle 1" do
    clues = [ 3, 2, 2, 3, 2, 1,
              1, 2, 3, 3, 2, 2,
              5, 1, 2, 2, 4, 3,
              3, 2, 1, 2, 2, 4]
          
    expected = [[ 2, 1, 4, 3, 5, 6 ],
                [ 1, 6, 3, 2, 4, 5 ],
                [ 4, 3, 6, 5, 1, 2 ],
                [ 6, 5, 2, 1, 3, 4 ],
                [ 5, 4, 1, 6, 2, 3 ],
                [ 3, 2, 5, 4, 6, 1 ]]
                
    actual = solve_puzzle clues
    expect(actual).to eq(expected)
    #Test.assert_equals(actual, expected)
  end    
  it "can solve 6x6 puzzle 2" do
    clues = [ 0, 0, 0, 2, 2, 0,
              0, 0, 0, 6, 3, 0,
              0, 4, 0, 0, 0, 0,
              4, 4, 0, 3, 0, 0]
              
    expected = [[ 5, 6, 1, 4, 3, 2 ], 
                [ 4, 1, 3, 2, 6, 5 ], 
                [ 2, 3, 6, 1, 5, 4 ], 
                [ 6, 5, 4, 3, 2, 1 ], 
                [ 1, 2, 5, 6, 4, 3 ], 
                [ 3, 4, 2, 5, 1, 6 ]]
                
    actual = solve_puzzle clues
    expect(actual).to eq(expected)
    #Test.assert_equals(actual, expected)
  end
  it ("can solve 6x6 puzzle 3") do
    clues = [ 0, 3, 0, 5, 3, 4, 
              0, 0, 0, 0, 0, 1,
              0, 3, 0, 3, 2, 3,
              3, 2, 0, 3, 1, 0]
              
    expected = [[ 5, 2, 6, 1, 4, 3 ], 
                [ 6, 4, 3, 2, 5, 1 ], 
                [ 3, 1, 5, 4, 6, 2 ], 
                [ 2, 6, 1, 5, 3, 4 ], 
                [ 4, 3, 2, 6, 1, 5 ], 
                [ 1, 5, 4, 3, 2, 6 ]]
                
    actual = solve_puzzle(clues)
    expect(actual).to eq(expected)
    #Test.assert_equals(actual, expected)
  end

end
