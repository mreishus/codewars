defmodule Chessboard do
  def game(1), do: [1, 2]

  def game(n) do
    value = n * n

    case rem(n, 2) do
      1 -> [value, 2]
      0 -> [value / 2]
    end
  end
end

defmodule Notes do
  @moduledoc """
  1/2 2/3 3/4 4/5  = 163/60
  1/3 2/4 3/5 4/6  = 289/60
  1/4 2/5 3/6 4/7  = 1373/210
  1/5 2/6 3/7 4/8  = 8
  """
end
