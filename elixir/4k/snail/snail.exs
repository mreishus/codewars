defmodule Snail do
  @directions [:north, :east, :south, :west]
  @doc """

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """

  @spec snail([[term]]) :: [term]

  def snail([[]]), do: []

  def snail(matrix) do
    max_y = length(matrix) - 1
    max_x = (Enum.at(matrix, 0) |> length) - 1
    do_snail(matrix, [], :east, {0, 0}, {0, max_x}, {0, max_y})
  end

  def do_snail(
        matrix,
        r,
        direction,
        {x, y} = c,
        {_min_x, _max_x} = xrange,
        {_min_y, _max_y} = yrange
      ) do
    # Get value of current square
    value = Enum.at(matrix, y) |> Enum.at(x)
    new_r = [value | r]

    do_turn = need_to_turn?(direction, c, xrange, yrange)
    # Turn if needed
    direction =
      case do_turn do
        true -> turn(direction, 1)
        false -> direction
      end

    # If turn, also change xrange/yrange
    {xrange, yrange} =
      case do_turn do
        true -> fix_range(direction, xrange, yrange)
        false -> {xrange, yrange}
      end

    # Take step forward
    new_pos = advance_position({x, y}, direction)

    case out_of_range?(new_pos, xrange, yrange) do
      true -> Enum.reverse(new_r)
      false -> do_snail(matrix, new_r, direction, new_pos, xrange, yrange)
    end
  end

  defp out_of_range?({x, y}, {min_x, max_x}, {min_y, max_y}) do
    x < min_x || x > max_x || y < min_y || y > max_y
  end

  defp fix_range(:south, xrange, {min_y, max_y}), do: {xrange, {min_y + 1, max_y}}
  defp fix_range(:north, xrange, {min_y, max_y}), do: {xrange, {min_y, max_y - 1}}
  defp fix_range(:east, {min_x, max_x}, yrange), do: {{min_x + 1, max_x}, yrange}
  defp fix_range(:west, {min_x, max_x}, yrange), do: {{min_x, max_x - 1}, yrange}

  defp need_to_turn?(direction, {x, y}, {min_x, max_x}, {min_y, max_y}) do
    # Take a step forward
    {new_x, new_y} = advance_position({x, y}, direction)
    # Did it go out of bounds?
    new_x > max_x || new_x < min_x || new_y > max_y || new_y < min_y
  end

  # advance_position: Gives position after taking a step forward.
  # (Position, Direction) -> Position
  defp advance_position(position, direction) do
    direction
    |> direction_vector
    |> addt(position)
  end

  # addt: Adds two tuples.
  defp addt({a, b}, {c, d}), do: {a + c, b + d}

  # direction_vector: Converts a direction (atom) into a unit vector.
  # (Direction) -> Position
  defp direction_vector(:north), do: {0, -1}
  defp direction_vector(:south), do: {0, 1}
  defp direction_vector(:west), do: {-1, 0}
  defp direction_vector(:east), do: {1, 0}

  # process_turn: Updates a robot with a turn specified in number of 90 deg clockwise turns.
  # (Direction, Integer) -> direction
  defp turn(direction, direction_delta) do
    @directions
    |> Enum.find_index(fn x -> x == direction end)
    |> Kernel.+(direction_delta)
    |> rem(4)
    |> (fn x -> Enum.at(@directions, x) end).()
  end
end
