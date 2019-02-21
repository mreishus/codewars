defmodule ProdFib do
  def product_fib(n) do
    Fib.start_link()
    answer = product_fib(n, 1)
    Fib.stop()
    answer
  end

  def product_fib(target, n) do
    product = Fib.fib(n) * Fib.fib(n + 1)

    cond do
      product == target ->
        [Fib.fib(n), Fib.fib(n + 1), true]

      product < target ->
        product_fib(target, n + 1)

      product > target ->
        [Fib.fib(n), Fib.fib(n + 1), false]
    end
  end
end

defmodule Fib do
  use GenServer

  ###########################
  ## API
  ###########################

  def start_link() do
    {:ok, pid} = GenServer.start_link(__MODULE__, :no_args, name: __MODULE__)
    pid
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end

  def fib(n) when n >= 0 do
    GenServer.call(__MODULE__, {:fib, n})
  end

  def see_cache do
    GenServer.call(__MODULE__, :see_cache)
  end

  ###########################
  ## GenServer Implementation
  ###########################

  def init(_) do
    cache = %{0 => 0, 1 => 1}
    {:ok, cache}
  end

  def handle_call(:see_cache, _from, cache) do
    {:reply, cache, cache}
  end

  # {:fib, n} -> Returns fib number for N with side effect of updating cache
  def handle_call({:fib, n}, _from, cache) when n >= 0 do
    {answer, cache} = calc_fib(n, cache)
    {:reply, answer, cache}
  end

  defp calc_fib(n, cache) do
    case cache[n] do
      nil ->
        {fib_n2, cache} = calc_fib(n - 2, cache)
        {fib_n1, cache} = calc_fib(n - 1, cache)
        answer = fib_n1 + fib_n2
        {answer, Map.put(cache, n, answer)}

      answer ->
        {answer, cache}
    end
  end
end
