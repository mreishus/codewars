Code.load_file("potatoes.exs", __DIR__)
ExUnit.start()

defmodule PotatoesTest do
  use ExUnit.Case

  def dotest(p0, w0, p1, exp) do
    assert Potatoes.potatoes(p0, w0, p1) == exp
  end

  test "Basic tests" do
    IO.puts("Test 1")
    dotest(99, 100, 98, 50)
    IO.puts("Test 2")
    dotest(82, 127, 80, 114)
  end
end
