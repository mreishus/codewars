Code.load_file("product_fib.exs", __DIR__)
ExUnit.start()

defmodule ProdFibTest do
  use ExUnit.Case

  def dotest(n, exp) do
    IO.puts("Testing : #{n}")
    act = ProdFib.product_fib(n)
    IO.puts("#{inspect(act)}")
    IO.puts("#{inspect(exp)}")
    assert act == exp
    IO.puts("#")
  end

  test "product_fib" do
    dotest(4895, [55, 89, true])
    dotest(5895, [89, 144, false])
    dotest(74_049_690, [6765, 10946, true])
  end
end
