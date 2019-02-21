defmodule RecreationOne do
  def list_squared(m, n) do
    m..n
    |> Parallel.map(fn x -> {x, sum_squared_divisors(x)} end)
    |> Enum.filter(fn {_, ssd} -> square?(ssd) end)
  end

  def special?(num), do: num |> sum_squared_divisors |> square?

  def divisors(1), do: [1]

  def divisors(num) do
    check_max = (num / 2) |> trunc

    divs =
      1..check_max
      |> Enum.to_list()
      |> Enum.filter(fn x -> rem(num, x) == 0 end)

    [num | divs]
  end

  def sum_squared_divisors(num) do
    divisors(num)
    |> Enum.map(fn x -> x * x end)
    |> Enum.sum()
  end

  def square?(num) do
    s = :math.sqrt(num)
    s == trunc(s)
  end
end

defmodule Parallel do
  def map(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Enum.map(&Task.await/1)
  end
end

defmodule ProblemDescription do
  @moduledoc """
  Divisors of 42 are : 1, 2, 3, 6, 7, 14, 21, 42. These divisors squared are:
  1, 4, 9, 36, 49, 196, 441, 1764. The sum of the squared divisors is 2500 which
  is 50 * 50, a square!

  Given two integers m, n (1 <= m <= n) we want to find all integers between m
  and n whose sum of squared divisors is itself a square. 42 is such a number.

  The result will be an array of arrays or of tuples (in C an array of Pair) or
  a string, each subarray having two elements, first the number whose squared
  divisors is a square and then the sum of the squared divisors.

  #Examples:

  list_squared(1, 250) --> [[1, 1], [42, 2500], [246, 84100]] list_squared(42,
  250) --> [[42, 2500], [246, 84100]]

  The form of the examples may change according to the language, see Example
  Tests: for more details.

  Note

  In Fortran - as in any other language - the returned string is not permitted
  to contain any redundant trailing whitespace: you can use dynamically allocated
  character strings
  """

  @notes """
  """
end
