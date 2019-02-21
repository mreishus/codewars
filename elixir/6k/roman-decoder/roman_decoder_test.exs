Code.load_file("roman_decoder.exs", __DIR__)
ExUnit.start()

defmodule TestSolution do
  use ExUnit.Case

  test "should equals 21" do
    assert Solution.decode("XXI") == 21
  end

  test "should equals 1" do
    assert Solution.decode("I") == 1
  end

  test "should equals 4" do
    assert Solution.decode("IV") == 4
  end

  test "should equals 2008" do
    assert Solution.decode("MMVIII") == 2008
  end

  test "should equals 1666" do
    assert Solution.decode("MDCLXVI") == 1666
  end

  test "should equals 1990" do
    assert Solution.decode("MCMXC") == 1990
  end
end
