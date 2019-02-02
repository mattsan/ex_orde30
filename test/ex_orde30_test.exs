defmodule TestMacro do
  defmacro dtest(desc, input, expect) do
    quote do
      test unquote(desc) do
        assert unquote(expect) == ExOrde30.solve(unquote(input))
      end
    end
  end
end

defmodule ExOrde30Test do
  use ExUnit.Case
  import TestMacro

  dtest("1", "abc", "abc")
  dtest("2", "ABC", "abc")
end
