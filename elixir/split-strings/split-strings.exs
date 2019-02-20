defmodule SplitStrings do
  def pad_if_odd(str) do
    case rem(String.length(str), 2) do
      0 -> str
      1 -> str <> "_"
    end
  end

  def solution(str) do
    str
    |> pad_if_odd
    |> String.graphemes()
    |> Enum.chunk_every(2)
    |> Enum.map(&Enum.join/1)
  end
end
