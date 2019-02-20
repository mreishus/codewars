Code.load_file("benefactor.exs", __DIR__)
ExUnit.start()

defmodule BenefactorTest do
  use ExUnit.Case

  test "Benefactor new_avg" do
    IO.puts("Test 1")
    assert Benefactor.new_avg([14, 30, 5, 7, 9, 11, 16], 90) == 628
    IO.puts("Test 2")

    assert_raise ArgumentError, "Expected New Average is too low", fn ->
      Benefactor.new_avg([14, 30, 5, 7, 9, 11, 15], 2)
    end

    IO.puts("Test 3")
    assert Benefactor.new_avg([1400.25, 30000.76, 5.56, 7, 9, 11, 15.48, 120.98], 10000) == 58430
  end
end
