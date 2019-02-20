defmodule SongDecoder do
  def decode_song(song) do
    Regex.replace(~r/(WUB)+/, song, " ", [])
    |> String.strip()

    # String.trim() in modern versions of elixir
  end
end
