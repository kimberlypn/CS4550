defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  # Converts an expression in infix notation to postfix notation.
  # expr: expression in infix notation
  # ops: stack of operators
  # acc: accumulator for the postfix expression to be returned
  def get_postfix(expr, ops, acc) do
    cond do
      # If there are no more characters
      length(expr) == 0 ->
        # Add any remaining ops to acc and return acc
        if length(ops) > 0 do
          get_postfix(expr, Enum.drop(ops, -1), acc ++ Enum.take(ops, -1))
        else
          acc
        end
      # If the character is an operator
      Enum.member?(["*","/","+", "-"], Enum.at(expr, 0)) ->
        rest = Enum.drop(expr, 1)
        char = Enum.at(expr, 0)
        # Push it to the ops stack if it is empty
        if length(ops) == 0 do
          get_postfix(rest, ops ++ [char], acc)
        # Else, check order of precedence: if the top of the stack has the
        # same precedence as char, add the top to acc, and keep checking
        else
          cond do
            # Case where char and top have same precedence
            (char == "*" && Enum.at(ops, -1) == "*") ||
            (char == "*" && Enum.at(ops, -1) == "/") ||
            (char == "/" && Enum.at(ops, -1) == "/") ||
            (char == "/" && Enum.at(ops, -1) == "*") ||
            (char == "+" && Enum.at(ops, -1) == "+") ||
            (char == "+" && Enum.at(ops, -1) == "-") ||
            (char == "-" && Enum.at(ops, -1) == "-") ||
            (char == "-" && Enum.at(ops, -1) == "+") ->
              get_postfix(expr, Enum.drop(ops, -1), acc ++ Enum.take(ops, -1))
            # Case where char has lower precedence
            (char == "+" && Enum.at(ops, -1) == "*") ||
            (char == "+" && Enum.at(ops, -1) == "/") ||
            (char == "-" && Enum.at(ops, -1) == "*") ||
            (char == "-" && Enum.at(ops, -1) == "/") ->
              get_postfix(expr, Enum.drop(ops, -1), acc ++ Enum.take(ops, -1))
            # Case where char has higher precedence
            true ->
              get_postfix(rest, ops ++ [char], acc)
          end
        end
      # If the character is a number
      true ->
        # Add it to the accumulator and recurse on the rest of expr
        rest = Enum.drop(expr, 1)
        char = Enum.at(expr, 0)
        get_postfix(rest, ops, acc ++ [char])
    end
  end

  # Evaluates an expression in postfix notation.
  # expr: expression in postfix notation to be evaluated
  # stack: stack of numbers to be evaluated
  def eval_postfix(expr, stack) do
    cond do
      # If there are no more characters, return the stack
      length(expr) == 0 ->
        String.to_integer(Enum.at(stack, 0))
      # If the character is a number, push it to the stack and recurse
      not Enum.member?(["*","/","+", "-"], Enum.at(expr, 0)) ->
        rest = Enum.drop(expr, 1)
        char = Enum.at(expr, 0)
        eval_postfix(rest, stack ++ [char])
      # If the character is an operator
      true ->
        # Pop the first two numbers on the stack
        first = String.to_integer(Enum.at(stack, -2))
        second = String.to_integer(Enum.at(stack, -1))
        # Add the evaluation of the two numbers to the stack and recurse
        rest = Enum.drop(expr, 1)
        case Enum.at(expr, 0) do
          "*" ->
            eval_postfix(rest,
              (stack
              |> Enum.drop(-1)
              |> Enum.drop(-1)) ++ [Integer.to_string(first * second)])
          "/" ->
          eval_postfix(rest,
            (stack
            |> Enum.drop(-1)
            |> Enum.drop(-1)) ++ [Integer.to_string(first / second)])
          "+" ->
          eval_postfix(rest,
            (stack
            |> Enum.drop(-1)
            |> Enum.drop(-1)) ++ [Integer.to_string(first + second)])
          "-" ->
          eval_postfix(rest,
            (stack
            |> Enum.drop(-1)
            |> Enum.drop(-1)) ++ [Integer.to_string(first - second)])
        end
    end
  end

  def eval(expr) do
    # Convert the equation from infix to postfix notation and evaluate it
    expr
    |> String.trim()
    |> String.split()
    |> get_postfix([], [])
    |> eval_postfix([])
  end

  def main() do
    expr = IO.gets("")
    ans = eval(expr)
    IO.puts(ans)
    main()
  end
end
