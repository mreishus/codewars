defmodule Solution do
  def decode(x), do: roman(x)

  def roman(roman_str) do
    roman(roman_str, 0)
  end

  defp roman("", num), do: num
  defp roman("M" <> str, num), do: roman(str, num + 1000)
  defp roman("CM" <> str, num), do: roman(str, num + 900)
  defp roman("D" <> str, num), do: roman(str, num + 500)
  defp roman("CD" <> str, num), do: roman(str, num + 400)
  defp roman("C" <> str, num), do: roman(str, num + 100)
  defp roman("XC" <> str, num), do: roman(str, num + 90)
  defp roman("L" <> str, num), do: roman(str, num + 50)
  defp roman("XL" <> str, num), do: roman(str, num + 40)
  defp roman("X" <> str, num), do: roman(str, num + 10)
  defp roman("IX" <> str, num), do: roman(str, num + 9)
  defp roman("V" <> str, num), do: roman(str, num + 5)
  defp roman("IV" <> str, num), do: roman(str, num + 4)
  defp roman("I" <> str, num), do: roman(str, num + 1)
end
