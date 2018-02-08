defmodule Memory.Game do
  # Resets the state of the game
  def new do
    %{
      matches: 0,
      clicks: 0,
      flipped: 0,
      prev: nil,
      ready: true,
      cards: shuffle(),
    }
  end

  def client_view(game) do
    %{
      matches: 0,
      clicks: 0,
      flipped: 0,
      prev: nil,
      ready: true,
      cards: shuffle(),
    }
  end

  def clicked(game, card) do
    IO.inspect(card)
  end

  # Randomizes the order of the cards array
  def shuffle do
    cards = %{
      0 => %{letter: 'A', flipped: false, matched: false},
      1 => %{letter: 'A', flipped: false, matched: false},
      2 => %{letter: 'B', flipped: false, matched: false},
      3 => %{letter: 'B', flipped: false, matched: false},
      4 => %{letter: 'C', flipped: false, matched: false},
      5 => %{letter: 'C', flipped: false, matched: false},
      6 => %{letter: 'D', flipped: false, matched: false},
      7 => %{letter: 'D', flipped: false, matched: false},
      8 => %{letter: 'E', flipped: false, matched: false},
      9 => %{letter: 'E', flipped: false, matched: false},
      10 => %{letter: 'F', flipped: false, matched: false},
      11 => %{letter: 'F', flipped: false, matched: false},
      12 => %{letter: 'G', flipped: false, matched: false},
      13 => %{letter: 'G', flipped: false, matched: false},
      14 => %{letter: 'H', flipped: false, matched: false},
      15 => %{letter: 'H', flipped: false, matched: false}
    }
    #|> Enum.shuffle()
  end
end
