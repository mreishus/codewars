Code.load_file("recreation_one.exs", __DIR__)
ExUnit.start()

defmodule TestSolution do
  use ExUnit.Case

  test "Divisors" do
    assert RecreationOne.divisors(42) == [42, 1, 2, 3, 6, 7, 14, 21]
  end

  test "Sum of squared divisors" do
    assert RecreationOne.sum_squared_divisors(42) == 2500
  end

  test "Is Square" do
    assert RecreationOne.square?(1) == true
    assert RecreationOne.square?(2) == false
    assert RecreationOne.square?(16) == true
    assert RecreationOne.square?(17) == false
    assert RecreationOne.square?(2500) == true
    assert RecreationOne.square?(2501) == false
  end

  test "Example Tests" do
    assert RecreationOne.list_squared(1, 250) == [{1, 1}, {42, 2500}, {246, 84100}]
    assert RecreationOne.list_squared(42, 250) == [{42, 2500}, {246, 84100}]
    assert RecreationOne.list_squared(250, 500) == [{287, 84100}]
  end

  test "big one" do
    l = length(RecreationOne.list_squared(1, 20000))
    assert l == 13
  end
end
