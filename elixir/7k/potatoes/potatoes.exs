defmodule Potatoes do
  @spec potatoes(integer, integer, integer) :: integer
  def potatoes(p0, w0, p1) do
    initial_water_weight = p0 / 100 * w0
    initial_solid_weight = (100 - p0) / 100 * w0

    ## Goes in oven, some water weight is lost ##

    (initial_solid_weight / (1 - p1 / 100))
    |> round
  end
end

defmodule ProblemDescription do
  @moduledoc """
  All we eat is water and dry matter.

  John bought potatoes: their weight is 100 kilograms. Potatoes contain water and
  dry matter.

  The water content is 99 percent of the total weight. He thinks they are too wet
  and puts them in an oven - at low temperature - for them to lose some water.

  At the output the water content is only 98%.

  What is the total weight in kilograms (water content plus dry matter) coming
  out of the oven?

  He finds 50 kilograms and he thinks he made a mistake: "So much weight lost for
  such a small change in water content!"

  Can you help him?

  Write function potatoes with

    int parameter p0 - initial percent of water- int parameter w0 - initial
  weight - int parameter p1 - final percent of water -

  potatoesshould return the final weight coming out of the oven w1 truncated as
  an int.  Example:

  potatoes(99, 100, 98) --> 50

  """

  @notes """
    # p0 = 99  # Starts out, 99% water.
    # w0 = 100 # Weight. (Initial Water + Initial Solid)
    # 99
    initial_water_weight = p0 / 100 * w0
    # 1
    initial_solid_weight = (100 - p0) / 100 * w0

    ## Goes in oven, some water weight is lost ##

    # final_water(?) + initial_solid_weight = final(?)
    # final_water(?) / final(?) = p1 (98)
    # --
    # final_water = p1 * final
    # ----
    # p1 * final + initial_solid_weight = final(?)
    # p1 * final - final = -initial_solid_weight
    # final - p1 * final = initial_solid_weight
    # (1-p1) * final = initial_solid_weight
    # final = initial_solid_weight / (1 - p1)
  """
end
