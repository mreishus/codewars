Code.load_file("snail.exs", __DIR__)

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule SnailTest do
  use ExUnit.Case

  test "3x3 positions" do
    matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    assert Snail.snail(matrix) == [1, 2, 3, 6, 9, 8, 7, 4, 5]
  end

  test "3x3 order" do
    matrix = [[1, 2, 3], [8, 9, 4], [7, 6, 5]]

    assert Snail.snail(matrix) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end
end
