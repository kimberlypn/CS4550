defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  def get_operators(expr) do
    operators = [] ++
      for x <- 0..length(expr)-1 do
        char = Enum.at(expr, x)
        if Enum.member?(["*","/","+","-"], char) do
          [char]
        else
          [""]
        end
      end
  end

  def get_operands(expr) do
    operands = [] ++
      for x <- 0..length(expr)-1 do
        char = Enum.at(expr, x)
        if not Enum.member?(["*","/","+","-"], char) do
          [char]
        else
          [""]
        end
      end
  end

  def eval(expr) do
    # Convert the equation from infix to postfix notation
    ops = expr |> String.split() |> get_operators() 
    nums = expr |> String.split() |> get_operands()
  end

  def main() do
    expr = IO.gets("") 
    ans = eval(expr)
    #IO.puts(ans)
    #main()
  end
end
