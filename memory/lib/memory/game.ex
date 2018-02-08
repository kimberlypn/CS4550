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
      matches: game.matches,
      clicks: game.clicks,
      flipped: game.flipped,
      prev: game.prev,
      ready: game.ready,
      cards: game.cards,
    }
  end

  # Returns the match count and a flag indicating if the match count increased
  def matched(game, card) do
    # If this is the second card in the turn and this card's letter
    # matches the previous card's letter
    if game.flipped != 0 && game.prev["letter"] == card["letter"] do
      # Increment the number of matches by 1
      [game.matches + 1, true]
    else
      # Else, do not change anything
      [game.matches, false]
    end
  end

  # Updates prev if the current card is the first guess in the turn
  def set_prev(game, card) do
    if game.flipped == 0 do
      card
    else
      game.prev
    end
  end

  # Sets the flipped flag of the card to true and the matched flag
  # if applicable
  def update_card(game, card, flag) do
    Map.put(game.cards,
    card["id"],
    %{letter: card["letter"], id: card["id"], flipped: true, matched: flag})
  end

  def clicked(game, card) do
    IO.inspect(game)
    if not card["flipped"]
      && game.ready
      && (game.flipped == 0 || game.prev["id"] != card["id"]) do
      matched = matched(game, card)
      game
      |> Map.put(:matches, Enum.at(matched, 0))
      |> Map.put(:flipped, game.flipped + 1)
      |> Map.put(:prev, set_prev(game, card))
      |> Map.put(:ready, game.flipped == 0)
      |> Map.put(:cards, update_card(game, card, Enum.at(matched, 1)))
      |> Map.put(:clicks, game.clicks + 1)
    else
      game
    end
  end

  # Randomizes the order of the cards array
  def shuffle do
    cards = %{
      0 => %{letter: "A", id: 0, flipped: false, matched: false},
      1 => %{letter: "A", id: 1, flipped: false, matched: false},
      2 => %{letter: "B", id: 2, flipped: false, matched: false},
      3 => %{letter: "B", id: 3, flipped: false, matched: false},
      4 => %{letter: "C", id: 4, flipped: false, matched: false},
      5 => %{letter: "C", id: 5, flipped: false, matched: false},
      6 => %{letter: "D", id: 6, flipped: false, matched: false},
      7 => %{letter: "D", id: 7, flipped: false, matched: false},
      8 => %{letter: "E", id: 8, flipped: false, matched: false},
      9 => %{letter: "E", id: 9, flipped: false, matched: false},
      10 => %{letter: "F", id: 10, flipped: false, matched: false},
      11 => %{letter: "F", id: 11, flipped: false, matched: false},
      12 => %{letter: "G", id: 12, flipped: false, matched: false},
      13 => %{letter: "G", id: 13, flipped: false, matched: false},
      14 => %{letter: "H", id: 14, flipped: false, matched: false},
      15 => %{letter: "H", id: 15, flipped: false, matched: false}
    }
    #|> Enum.shuffle()
  end
end
