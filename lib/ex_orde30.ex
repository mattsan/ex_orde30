defmodule ExOrde30 do
  def div_floor(dividend, divisor) when dividend >= 0, do: div(dividend, divisor)
  def div_floor(dividend, divisor), do: div(dividend - divisor, divisor)

  def range([_], target) when target < 0, do: 0
  def range([_], target), do: target + 1

  def range([length, above_length | rest_lengths], target) do
    left = length * target
    right = length * (target + 1) - 1

    (div_floor(left, above_length) - 1)..(div_floor(right, above_length) + 1)
    |> Stream.map(&range([above_length | rest_lengths], &1))
  end

  def interest([_, _], interesting_cells), do: interesting_cells
  def interest([cell, cell, cell | rest], interesting_cells), do: interest([cell, cell | rest], interesting_cells)
  def interest([_, cell | rest], interesting_cells), do: interest([cell | rest], [cell | interesting_cells])

  def fold(cell) when is_integer(cell), do: cell

  def fold([cell | _] = cells) when is_integer(cell) do
    cells
    |> interest([])
    |> Enum.sum
    |> rem(1_000)
  end

  def fold(cells) do
    cells
    |> Enum.map(&fold/1)
    |> fold()
  end

  def solve(input) do
    [lengths_s, target_s] = String.split(input, "/")

    target = String.to_integer(target_s)

    lengths_s
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()
    |> range(target - 1)
    |> fold()
    |> inspect
  end
end
