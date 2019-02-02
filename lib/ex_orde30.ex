defmodule ExOrde30 do
  def range([length], target) do
    target
  end

  def range([length, above_length | rest_lengths], target) do
    left = length * (target - 1)
    right = (length * target) - 1

    (div(left, above_length) - 1)..(div(right, above_length) + 1)
    |> Enum.map(fn t ->
      range([above_length | rest_lengths], t)
    end)
  end

  def solve(input) do
    [lengths_s, target_s] = String.split(input, "/")

    target = String.to_integer(target_s)
    lengths =
      lengths_s
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()

    inspect IO.inspect range(lengths, target)
  end
end
