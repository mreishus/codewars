#! /usr/bin/env elixir

defmodule Maxball do
  # h = v*t - (0.5*g*t*t)
  # h' = v - g*t
  # h' = 0 = v - g*t
  # g*t = v
  # t = v / g
  @g 9.81
  def max_ball(v_km_h) do
    (kmh_to_ms(v_km_h) / @g * 10)
    |> Float.round()
  end

  def kmh_to_ms(x), do: x / (60.0 * 60.0) * 1000.0
end

[15, 25, 37]
|> Enum.map(fn x -> Maxball.max_ball(x) end)
|> IO.inspect()
