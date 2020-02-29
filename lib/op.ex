defmodule Op do
  @moduledoc false

  # Map function
  def map([], _), do: []
  def map([h | c], f), do: [f.(h) | map(c, f)]

  # FlatMap function
  def flat_map([], _), do: []
  def flat_map([h | c], f), do: f.(h) ++ flat_map(c, f)

  def test_left_law() do
    value = 2
    val_in_collection = [value]
    f = fn (x) -> [[x * 2, 9, 8]]  end

    IO.inspect f.(value)
    IO.inspect flat_map(val_in_collection, f)
  end

  def test_right_law() do
    val_in_collection = [2]
    f = fn x -> [[x]] end

    IO.inspect val_in_collection
    IO.inspect flat_map(val_in_collection, f)
  end

  def test_other_law() do
    val_in_collection = [1]
    f1 = fn x -> [[x * 2]] end
    f2 = fn x -> [[x * 3]] end

    IO.inspect val_in_collection |> Enum.flat_map(f1) |> Enum.flat_map(f2)
    IO.inspect val_in_collection |> Enum.flat_map(fn(x) -> f1.(x) |> Enum.flat_map(f2) end)
  end

  # Map or FlatMap function
  def flat_map2([], _), do: []
  def flat_map2([h | c], f), do: concat(f.(h), flat_map2(c, f))
  defp concat([h | c], []), do: [h] ++ c
  defp concat([h | c], [hh | cc]), do: [h | c] ++ [hh | cc]
  defp concat(v, []), do: [v]
  defp concat(v, c), do: [v] ++ c

end
