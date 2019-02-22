Code.load_file("printer_error.exs", __DIR__)
ExUnit.start()

defmodule PrintererrorTest do
  use ExUnit.Case

  defp testing(numtest, s, ans) do
    IO.puts("Test #{numtest} \n")
    assert Printererror.printer_error(s) == ans
  end

  test "printer_error" do
    s = "aaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyz"
    testing(1, s, "3/56")
    s = "kkkwwwaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyz"
    testing(2, s, "6/60")
    s = "kkkwwwaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbmmmmmmmmmmmmmmmmmmmxyzuuuuu"
    testing(3, s, "11/65")
  end
end
