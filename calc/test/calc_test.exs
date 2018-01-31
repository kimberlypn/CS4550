defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "addition" do
    assert Calc.eval("2 + 3") == 5
    assert Calc.eval("-3 + -4") == -7
    assert Calc.eval("-3 + 10") == 7
    assert Calc.eval("-250 + 10") == -240
    assert Calc.eval("5 + -7") == -2
    assert Calc.eval("30 + -10") == 20
    assert Calc.eval("(4 + 5) + 10") == 19
    assert Calc.eval("1 + 2 + 3 + 4") == 10
  end

  test "subtraction" do
    assert Calc.eval("100 - 50") == 50
    assert Calc.eval("50 - 100") == -50
    assert Calc.eval("-3 - -4") == 1
    assert Calc.eval("-67 - -17") == -50
    assert Calc.eval("-3 - 10") == -13
    assert Calc.eval("5 - -7") == 12
    assert Calc.eval("(40 - 5) - 10") == 25
    assert Calc.eval("100 - 50 - 5 - 10") == 35
  end

  test "multiplication" do
    assert Calc.eval("2 * 3") == 6
    assert Calc.eval("-3 * -4") == 12
    assert Calc.eval("-3 * 10") == -30
    assert Calc.eval("5 * -7") == -35
    assert Calc.eval("(4 * 5) * 10") == 200
    assert Calc.eval("1 * 2 * 3 * 4") == 24
  end

  test "division" do
    assert Calc.eval("20 / 4") == 5
    assert Calc.eval("-24 / -4") == 6
    assert Calc.eval("-30 / 10") == -3
    assert Calc.eval("1 / 2") == 0.5
    assert Calc.eval("(20 / 5) / 2") == 2
    assert Calc.eval("900 / 9 / 5 / 4") == 5
  end

  test "order of operations" do
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
    assert Calc.eval("5 * 4 / 10") == 2
    assert Calc.eval("4 - 6 + 7") == 5
    assert Calc.eval("5 - 3 / 3") == 4
    assert Calc.eval("3 * 4 * (5 + 7)") == 144
  end

  test "obnoxious parentheses" do
    assert Calc.eval("(((((5)))))") == 5
    assert Calc.eval("(4 + 5) * (3)") == 27
    assert Calc.eval("4 + (5 * (3 - (2 + 1)))") == 4
  end

  test "single value" do
    assert Calc.eval("5") == 5
    assert Calc.eval("-20") == -20
  end
end
